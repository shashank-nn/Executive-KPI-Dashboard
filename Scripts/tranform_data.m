let
    // --- SaaS-Sales Transformation ---
    Source_SaaS = Csv.Document(File.Contents("data/SaaS-Sales.csv"), [Delimiter=",", Columns=15, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    PromotedHeaders_SaaS = Table.PromoteHeaders(Source_SaaS, [PromoteAllScalars=true]),
    KeptColumns_SaaS = Table.SelectColumns(PromotedHeaders_SaaS, {"Order Date","Region","Customer","Segment","Product","Sales","Quantity","Discount","Profit"}),
    ChangedType_SaaS = Table.TransformColumnTypes(KeptColumns_SaaS,{{"Order Date", type date}, {"Sales", type number}, {"Quantity", Int64.Type}, {"Discount", type number}, {"Profit", type number}}),
    AddedMonthYear_SaaS = Table.AddColumn(ChangedType_SaaS, "Month-Year", each Text.PadStart(Text.From(Date.Month([Order Date])), 2, "0") & "-" & Text.From(Date.Year([Order Date])), type text),
    RenamedColumns_SaaS = Table.RenameColumns(AddedMonthYear_SaaS, {{"Sales","Marketing Spend"}, {"Quantity","Conversions"}, {"Profit","Campaign Profit"}}),
    Cleaned_SaaS = Table.RemoveRowsWithErrors(RenamedColumns_SaaS, {"Order Date"}),

    // --- Amazon Sales Transformation ---
    Source_Amazon = Csv.Document(File.Contents("data/amazon.csv"), [Delimiter=",", Columns=9, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    PromotedHeaders_Amazon = Table.PromoteHeaders(Source_Amazon, [PromoteAllScalars=true]),
    KeptColumns_Amazon = Table.SelectColumns(PromotedHeaders_Amazon, {"product_id","product_name","discounted_price","actual_price","rating","rating_count"}),
    ReplacedRupee_Amazon = Table.ReplaceValue(KeptColumns_Amazon, "₹", "", Replacer.ReplaceText, {"discounted_price","actual_price"}),
    ReplacedComma_Amazon = Table.ReplaceValue(ReplacedRupee_Amazon, ",", "", Replacer.ReplaceText, {"discounted_price","actual_price"}),
    ChangedType_Amazon = Table.TransformColumnTypes(ReplacedComma_Amazon,{{"discounted_price", type number}, {"actual_price", type number}, {"rating", type number}, {"rating_count", Int64.Type}}),
    AddedMonthYear_Amazon = Table.AddColumn(ChangedType_Amazon, "Month-Year", each "01-2024", type text),
    AddedDiscountPct = Table.AddColumn(AddedMonthYear_Amazon, "Discount %", each ([actual_price] - [discounted_price]) / [actual_price], Percentage.Type),
    AddedRevenuePerProduct = Table.AddColumn(AddedDiscountPct, "Revenue per Product", each [discounted_price] * [rating_count], type number),

    // --- Amazon Financial Transformation ---
    Source_Financial = Excel.Workbook(File.Contents("data/Amazon Financial Dataset.xlsx"), null, true),
    Sheet_Financial = Source_Financial{[Name="Sheet1"]}[Data],
    PromotedHeaders_Financial = Table.PromoteHeaders(Sheet_Financial, [PromoteAllScalars=true]),
    RenamedColumns_Financial = Table.RenameColumns(PromotedHeaders_Financial, {{"R&D Amount (in $)","R&D Spend"},{"Marketing Amount (in $)","Marketing Spend"},{"Profit (in $)","Profit"}}),
    ChangedType_Financial = Table.TransformColumnTypes(RenamedColumns_Financial,{{"R&D Spend", type number},{"Marketing Spend", type number},{"Profit", type number},{"Employee Count", Int64.Type},{"Product Count", Int64.Type}}),
    AddedMonthYear_Financial = Table.AddColumn(ChangedType_Financial, "Month-Year", each "01-2024", type text),
    AddedROIFinancial = Table.AddColumn(AddedMonthYear_Financial, "Marketing ROI", each if [Marketing Spend] <> 0 then [Profit] / [Marketing Spend] else null, type number),
    AddedProfitPerEmployee = Table.AddColumn(AddedROIFinancial, "Profit per Employee", each if [Employee Count] <> 0 then [Profit] / [Employee Count] else null, type number),

    // --- Output Tables ---
    SaaS_Sales_Cleaned = Cleaned_SaaS,
    Amazon_Sales_Cleaned = AddedRevenuePerProduct,
    Amazon_Financial_Cleaned = AddedProfitPerEmployee
in
    [
        SaaS_Sales = SaaS_Sales_Cleaned,
        Amazon_Sales = Amazon_Sales_Cleaned,
        Amazon_Financial = Amazon_Financial_Cleaned
    ]
