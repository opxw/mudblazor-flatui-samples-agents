// Copyright © 2026 opx. All rights reserved.

namespace Opx.MudBlazor.FlatUi.Sample.Services;

public sealed class ErpSampleCatalog
{
    public IReadOnlyList<ErpEmployee> Employees { get; } =
    [
        new("EMP-1001", "Alicia Morgan", "Finance", "Senior Accountant", "Jakarta", "Permanent", "Active"),
        new("EMP-1002", "Daniel Kim", "Production", "Shift Supervisor", "Plant A", "Permanent", "Active"),
        new("EMP-1003", "Maya Chen", "Human Resources", "HR Business Partner", "Jakarta", "Permanent", "Active"),
        new("EMP-1004", "Samuel Reed", "Supply Chain", "Buyer", "Surabaya", "Contract", "Probation"),
        new("EMP-1005", "Nadia Putri", "Sales", "Account Executive", "Bandung", "Permanent", "Active"),
        new("EMP-1006", "Victor Tan", "Quality", "QC Inspector", "Plant A", "Permanent", "Leave")
    ];

    public IReadOnlyList<ErpAttendance> Attendance { get; } =
    [
        new("EMP-1001", "Alicia Morgan", "Finance", "08:02", "17:11", "Present"),
        new("EMP-1002", "Daniel Kim", "Production", "06:55", "15:04", "Present"),
        new("EMP-1003", "Maya Chen", "Human Resources", "08:18", "17:20", "Late"),
        new("EMP-1004", "Samuel Reed", "Supply Chain", "07:58", "17:02", "Present"),
        new("EMP-1005", "Nadia Putri", "Sales", "Remote", "Remote", "Business trip"),
        new("EMP-1006", "Victor Tan", "Quality", "-", "-", "Approved leave")
    ];

    public IReadOnlyList<ErpWorkOrder> WorkOrders { get; } =
    [
        new("WO-260801", "FG-AX100", "Industrial Pump AX100", "Line 1", 1200, 840, "In progress", "07 Aug"),
        new("WO-260802", "FG-VL220", "Control Valve VL220", "Line 2", 800, 800, "Completed", "06 Aug"),
        new("WO-260803", "FG-MT410", "Motor Unit MT410", "Line 3", 450, 180, "At risk", "08 Aug"),
        new("WO-260804", "FG-SK115", "Seal Kit SK115", "Line 1", 2500, 0, "Released", "09 Aug"),
        new("WO-260805", "FG-BR330", "Bearing BR330", "Line 2", 1600, 0, "Planned", "11 Aug")
    ];

    public IReadOnlyList<ErpQualityCheck> QualityChecks { get; } =
    [
        new("QC-0841", "WO-260801", "Dimensional inspection", "A. Rahman", "Passed", "10:12"),
        new("QC-0842", "WO-260803", "Winding resistance", "V. Tan", "Hold", "10:38"),
        new("QC-0843", "WO-260802", "Pressure test", "A. Rahman", "Passed", "11:05"),
        new("QC-0844", "WO-260801", "Surface finish", "L. Wijaya", "Rework", "11:44"),
        new("QC-0845", "WO-260804", "Incoming material", "V. Tan", "Pending", "12:10")
    ];

    public IReadOnlyList<ErpLedgerEntry> LedgerEntries { get; } =
    [
        new("JV-2608-0018", "06 Aug", "110100", "Cash at Bank", "Customer receipt SO-1048", 125000000m, 0m, "Posted"),
        new("JV-2608-0019", "06 Aug", "210200", "Trade Payables", "Supplier invoice INV-8821", 0m, 48500000m, "Posted"),
        new("JV-2608-0020", "06 Aug", "510300", "Production Overhead", "Monthly allocation", 18750000m, 0m, "Draft"),
        new("JV-2608-0021", "06 Aug", "110100", "Cash at Bank", "Payment run PR-081", 0m, 76300000m, "Pending approval"),
        new("JV-2608-0022", "06 Aug", "410100", "Product Revenue", "Daily sales posting", 0m, 214800000m, "Posted")
    ];

    public IReadOnlyList<ErpOpenItem> Payables { get; } =
    [
        new("AP-8821", "PT Alpha Steel", "15 Aug", 48500000m, "Current"),
        new("AP-8827", "Global Bearings Ltd", "09 Aug", 76250000m, "Due soon"),
        new("AP-8794", "Nusantara Logistics", "02 Aug", 18400000m, "Overdue"),
        new("AP-8832", "Prima Packaging", "20 Aug", 32900000m, "Current")
    ];

    public IReadOnlyList<ErpOpenItem> Receivables { get; } =
    [
        new("AR-1048", "Atlas Engineering", "12 Aug", 125000000m, "Current"),
        new("AR-1032", "Metro Utilities", "05 Aug", 98750000m, "Due soon"),
        new("AR-0998", "Eastern Manufacturing", "28 Jul", 44200000m, "Overdue"),
        new("AR-1055", "Pacific Process", "22 Aug", 166500000m, "Current")
    ];

    public IReadOnlyList<ErpPurchaseOrder> PurchaseOrders { get; } =
    [
        new("PO-2608-031", "PT Alpha Steel", "Raw Material", 48500000m, "Approved", "12 Aug"),
        new("PO-2608-032", "Global Bearings Ltd", "MRO", 76250000m, "Awaiting approval", "14 Aug"),
        new("PO-2608-033", "Prima Packaging", "Packaging", 32900000m, "Sent", "10 Aug"),
        new("PO-2608-034", "Nusantara Logistics", "Service", 18400000m, "Draft", "18 Aug")
    ];

    public IReadOnlyList<ErpInventoryItem> Inventory { get; } =
    [
        new("RM-STL-08", "Steel Plate 8 mm", "Raw Material", "RM-A01", 1860, 1200, "Healthy"),
        new("RM-BRG-22", "Bearing 6205 ZZ", "Raw Material", "RM-B04", 284, 350, "Reorder"),
        new("WIP-AX100", "Pump AX100 Assembly", "WIP", "WIP-L1", 840, 0, "In production"),
        new("FG-VL220", "Control Valve VL220", "Finished Goods", "FG-A02", 126, 80, "Healthy"),
        new("PK-CRT-L", "Export Crate Large", "Packaging", "PK-C01", 42, 75, "Critical")
    ];

    public IReadOnlyList<ErpSalesOrder> SalesOrders { get; } =
    [
        new("SO-2608-1048", "Atlas Engineering", "Industrial Pump AX100", 125000000m, "Ready to ship", "08 Aug"),
        new("SO-2608-1051", "Metro Utilities", "Control Valve VL220", 98750000m, "In production", "12 Aug"),
        new("SO-2608-1055", "Pacific Process", "Motor Unit MT410", 166500000m, "Credit hold", "15 Aug"),
        new("SO-2608-1058", "Eastern Manufacturing", "Seal Kit SK115", 44200000m, "Confirmed", "10 Aug")
    ];
}

public sealed record ErpEmployee(string Code, string Name, string Department, string Role, string Location, string Employment, string Status);
public sealed record ErpAttendance(string Code, string Name, string Department, string CheckIn, string CheckOut, string Status);
public sealed record ErpWorkOrder(string Number, string ItemCode, string Item, string Resource, int Planned, int Completed, string Status, string DueDate);
public sealed record ErpQualityCheck(string Number, string WorkOrder, string Check, string Inspector, string Result, string Time);
public sealed record ErpLedgerEntry(string Number, string Date, string Account, string AccountName, string Reference, decimal Debit, decimal Credit, string Status);
public sealed record ErpOpenItem(string Number, string Partner, string DueDate, decimal Amount, string Status);
public sealed record ErpPurchaseOrder(string Number, string Supplier, string Category, decimal Amount, string Status, string DeliveryDate);
public sealed record ErpInventoryItem(string Code, string Name, string Category, string Warehouse, int OnHand, int ReorderPoint, string Status);
public sealed record ErpSalesOrder(string Number, string Customer, string Item, decimal Amount, string Status, string DeliveryDate);
