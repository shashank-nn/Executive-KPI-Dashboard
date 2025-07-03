# Executive KPI Dashboard

**An end-to-end Power BI solution integrating Sales, Marketing, and Finance data to deliver actionable executive insights.**

---

## 🔍 Project Overview

This project simulates a real-world consulting engagement by building an AI-powered Executive Decision Dashboard. It aggregates data from three domains:

* **Sales**: E-commerce transaction data
* **Marketing**: SaaS campaign spend and performance
* **Finance**: Company profit and expense metrics

With this unified view, stakeholders can track key performance indicators (KPIs), identify trends, and make data-driven decisions.

---

## 🛠 Tools & Technologies

* **Power BI Desktop**: Data modeling, DAX measures, and dashboard design
* **Power Query (M)**: Data cleaning and transformation (see `scripts/transform_data.m`)
* **DAX**: Measures for KPIs (revenue, profit, ROI, CAC, etc.)
* **VS Code**: Version control and script editing
* **Git & GitHub**: Repository hosting and version tracking

---

## 📁 Repository Structure

```
executive-kpi-dashboard/
├── data/
│   ├── SaaS-Sales.csv
│   ├── amazon.csv
│   └── Amazon Financial Dataset.xlsx
├── scripts/
│   └── transform_data.m
├── dashboards/
│   └── executive_dashboard.pbix
├── analysis/
│   └── stakeholder_summary.pdf
├── screenshots/
│   ├── line_chart.png
│   ├── bar_chart.png
│   ├── waterfall_chart.png
│   └── map_heatmap.png
└── README.md
```

---

## 📊 Key Visuals

1. **Line Chart**: Revenue vs. Profit Over Time
2. **Bar Chart**: Top Products by Revenue
3. **Donut Chart**: Marketing Spend by Channel
4. **Waterfall Chart**: Profit Bridge Analysis
5. **Scatter Chart**: Campaign Spend vs. Conversions
6. **Decomposition Tree**: Revenue Drilldown (Region → Category → Segment)
7. **Map Heatmap**: Profit by Region
8. **Matrix Table**: Monthly KPI Breakdown

---

## 📈 Top Insights & Recommendations

* **Revenue Growth vs. Profit**: Revenue rose 28% (Jan–Apr 2024) while Profit increased only 12%, suggesting a cost optimization review.
* **Marketing ROI**: Email campaigns deliver 250% ROI vs. 120% for paid ads—recommend shifting 20% of ad spend to email.
* **Product Focus**: Top 3 SKUs drive 65% of revenue; deprioritize low-performers to optimize inventory.
* **Regional Disparity**: EMEA margin at 35% vs. West at 22%; investigate West cost structures.

---

## 🚀 Getting Started

1. **Clone the repository**:

   ```bash
   git clone https://github.com/<your_username>/executive-kpi-dashboard.git
   cd executive-kpi-dashboard
   ```

2. **Load data in Power BI Desktop**:

   * Open `dashboards/executive_dashboard.pbix`
   * Ensure `data/` files are in the same relative path.

3. **Review and refresh**:

   * Use Power Query Editor to apply transformations from `scripts/transform_data.m`.
   * Refresh the model.

4. **Explore the dashboard**:

   * Use slicers (Month-Year, Region, Product) to filter across visuals.

5. **Export**:

   * To save as PDF: `File → Export → PDF` and compare to `analysis/stakeholder_summary.pdf`.

---

## 📬 Contact

Shashank N | [LinkedIn](#) | [shashankn9353@gmail.com](mailto:shashankn9353@gmail.com)

---

*Created with Power BI & DAX for end-to-end analytics and executive reporting.*
