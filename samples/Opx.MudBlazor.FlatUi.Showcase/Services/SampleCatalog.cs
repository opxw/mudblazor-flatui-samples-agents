// Copyright (c) 2026 opx. All rights reserved.

namespace Opx.MudBlazor.FlatUi.Sample.Services;

public sealed class SampleCatalog
{
    public IReadOnlyList<AssetRecord> Assets { get; } =
    [
        new("NB-OPS-001", "Notebook Finance 01", "Finance", "Rina", "Online", "Jakarta", "2026-08-05", 94),
        new("NB-OPS-002", "Notebook HR 02", "Human Resource", "Dimas", "Online", "Bandung", "2026-08-05", 89),
        new("PC-PRD-010", "Production Scanner Gate", "Production", "Line A", "Pending", "Factory", "2026-08-04", 77),
        new("PC-WHS-021", "Warehouse Packing", "Warehouse", "Sari", "Offline", "Factory", "2026-08-03", 52),
        new("NB-DEV-017", "Developer Mobile Rig", "IT", "Bayu", "Online", "Jakarta", "2026-08-05", 98),
        new("PC-QC-005", "Quality Station", "Quality", "Maya", "Online", "Factory", "2026-08-05", 91),
        new("NB-SLS-012", "Sales Visit Kit", "Sales", "Tono", "Pending", "Surabaya", "2026-08-02", 70),
        new("PC-FIN-008", "Tax Workstation", "Finance", "Wulan", "Online", "Jakarta", "2026-08-05", 86)
    ];

    public IReadOnlyList<TicketRecord> Tickets { get; } =
    [
        new("TCK-2401", "Accounting printer not detected", "Finance", "Open", "High", "08:10"),
        new("TCK-2402", "Install payroll application", "Human Resource", "Progress", "Medium", "09:25"),
        new("TCK-2403", "Barcode scanner intermittent", "Warehouse", "Open", "High", "10:05"),
        new("TCK-2404", "Reset VPN user sales", "Sales", "Done", "Low", "11:40"),
        new("TCK-2405", "Production PC is slow during night shift", "Production", "Progress", "High", "13:15")
    ];

    public IReadOnlyList<StaticRecord> StaticData { get; } =
    [
        new("BR-001", "Branch", "Jakarta", "Active", "Operational head office"),
        new("BR-002", "Branch", "Bandung", "Active", "Regional office"),
        new("DP-IT", "Department", "IT", "Active", "Support and development"),
        new("DP-HR", "Department", "Human Resource", "Active", "HR operation"),
        new("CAT-LAP", "Asset Category", "Laptop", "Active", "Notebooks and ultrabooks"),
        new("CAT-PC", "Asset Category", "Desktop", "Active", "PC workstation"),
        new("SLA-H", "SLA", "High Priority", "Active", "4 business hour target")
    ];

    public IReadOnlyList<ReportRecord> Reports { get; } =
    [
        new("RPT-001", "Asset Utilization", "Operations", "Monthly", "2026-08-01", 128, "Ready"),
        new("RPT-002", "SLA Ticket", "Support", "Weekly", "2026-08-04", 37, "Ready"),
        new("RPT-003", "Inventory Aging", "Asset", "Monthly", "2026-08-01", 212, "Draft"),
        new("RPT-004", "Monitoring Uptime", "Infrastructure", "Daily", "2026-08-05", 24, "Ready"),
        new("RPT-005", "Device Replacement", "Asset", "Quarter", "2026-07-31", 18, "Review")
    ];

    public IReadOnlyList<DatabaseMonitorRecord> Databases { get; } =
    [
        new("IT-ASSET-MONITORING", "IT", "Connected", "MariaDB.10.MySqlConnector", "DB Cloud Config", "8", "05/08/2026 22:51:34"),
        new("IT-TASK", "IT", "Disconnected", "MariaDB.10.MySqlConnector", "Connection timeout", "-", "05/08/2026 22:51:34"),
        new("SAP", "SAP", "Disconnected", "MariaDB.10.MySqlConnector", "Credential is not available yet", "-", "05/08/2026 22:51:34"),
        new("FINANCE", "Finance", "Connected", "MariaDB.10.MySqlConnector", "DB Cloud Config", "12", "05/08/2026 22:51:34"),
        new("HR-FINAC", "HR", "Connected", "MariaDB.10.MySqlConnector", "DB Cloud Config", "9", "05/08/2026 22:51:34"),
        new("WAREHOUSE", "Operation", "Connected", "MariaDB.10.MySqlConnector", "DB Cloud Config", "7", "05/08/2026 22:51:34"),
        new("ASSET-LEGACY", "IT", "Disconnected", "MariaDB.10.MySqlConnector", "Host is not responding", "-", "05/08/2026 22:51:34"),
        new("MAILER", "Platform", "Connected", "MariaDB.10.MySqlConnector", "DB Cloud Config", "5", "05/08/2026 22:51:34"),
        new("CDN", "Platform", "Connected", "MariaDB.10.MySqlConnector", "DB Cloud Config", "6", "05/08/2026 22:51:34"),
        new("ADMINISTRATION", "Core", "Connected", "MariaDB.10.MySqlConnector", "DB Cloud Config", "10", "05/08/2026 22:51:34"),
        new("LOGGING", "Monitoring", "Connected", "MariaDB.10.MySqlConnector", "DB Cloud Config", "11", "05/08/2026 22:51:34"),
        new("ARCHIVE", "Operation", "Disconnected", "MariaDB.10.MySqlConnector", "Maintenance window", "-", "05/08/2026 22:51:34")
    ];

    public IReadOnlyList<ProductRecord> Products { get; } =
    [
        new("PRD-001", "Everyday Backpack", "Bags", "Water-resistant commuter backpack with laptop divider.", "$59.00", "$79.00", "New", "In stock", 4.8m),
        new("PRD-002", "Minimal Desk Lamp", "Home Office", "Dimmable LED lamp with warm and cool light modes.", "$42.00", "", "Best seller", "In stock", 4.6m),
        new("PRD-003", "Wireless Travel Mouse", "Accessories", "Compact multi-device mouse with silent clicks.", "$24.00", "$29.00", "Sale", "In stock", 4.4m),
        new("PRD-004", "Ceramic Coffee Set", "Lifestyle", "Two-cup ceramic set for desk or kitchen display.", "$34.00", "", "Limited", "Low stock", 4.7m),
        new("PRD-005", "Portable Monitor 14\"", "Electronics", "Slim USB-C monitor for mobile workstations.", "$189.00", "$219.00", "Featured", "In stock", 4.5m),
        new("PRD-006", "Notebook Organizer", "Stationery", "Flat pouch for notebooks, pens, cables, and cards.", "$18.00", "", "New", "In stock", 4.3m)
    ];

    public IReadOnlyList<JobRecord> Jobs { get; } =
    [
        new("JK-2401", "Senior .NET Developer", "Novalab", "Singapore", "Full Time", "Remote / Hybrid", "IDR 18.000.000", "3 days ago", "Build and maintain enterprise Blazor + API services with strong UI quality and performance standards."),
        new("JK-2402", "UI/UX Analyst", "Nexa Studio", "Jakarta", "Hybrid", "On-site", "IDR 12.000.000", "4 days ago", "Create reusable component specs and improve digital experiences for product and operational systems."),
        new("JK-2403", "Recruitment Officer", "People First", "Bandung", "Full Time", "On-site", "IDR 10.000.000", "6 days ago", "Run hiring campaigns, coordinate assessments, and maintain clear role documentation from open positions to onboarding."),
        new("JK-2404", "Support Analyst", "InfraOps", "Surabaya", "Full Time", "Hybrid", "IDR 11.500.000", "1 day ago", "Deliver IT support workflows with documentation, incident tracking, and smooth handover to engineering."),
        new("JK-2405", "QA Engineer", "Brightline", "Bali", "Contract", "Remote", "IDR 14.000.000", "5 days ago", "Own end-to-end test design, reporting quality gates, and release-readiness checks for product teams."),
        new("JK-2406", "Product Operations Associate", "Ops Lab", "Yogyakarta", "Part Time", "On-site", "IDR 7.500.000", "7 days ago", "Run daily ops planning, track ticket progress, and maintain operational reports that support leadership decisions.")
    ];
}

public sealed record AssetRecord(
    string Code,
    string Name,
    string Department,
    string Owner,
    string Status,
    string Location,
    string LastSeen,
    int Health);

public sealed record TicketRecord(
    string Code,
    string Title,
    string Department,
    string Status,
    string Priority,
    string Time);

public sealed record StaticRecord(
    string Code,
    string Group,
    string Name,
    string Status,
    string Description);

public sealed record ReportRecord(
    string Code,
    string Name,
    string Scope,
    string Period,
    string Date,
    int Rows,
    string Status);

public sealed record DatabaseMonitorRecord(
    string Name,
    string Group,
    string Status,
    string Provider,
    string Reason,
    string ConnectTimeMs,
    string CheckedAt);

public sealed record ProductRecord(
    string Code,
    string Name,
    string Category,
    string Description,
    string Price,
    string PreviousPrice,
    string Badge,
    string Availability,
    decimal Rating);

public sealed record JobRecord(
    string Id,
    string Title,
    string Company,
    string Location,
    string EmploymentType,
    string WorkMode,
    string SalaryRange,
    string PostedAgo,
    string Summary);
