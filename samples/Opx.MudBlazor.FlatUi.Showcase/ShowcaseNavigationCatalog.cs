// Copyright (c) 2026 opx. All rights reserved.

using MudBlazor;
using Opx.MudBlazor.FlatUi.Models;

namespace Opx.MudBlazor.FlatUi.Showcase;

public static class ShowcaseNavigationCatalog
{
    public static IReadOnlyList<FlatNavigationMenuItem> NavigationItems { get; } =
    [
        new("Dashboard", "/", Icons.Material.Outlined.Dashboard),
        new("ERP", Icon: Icons.Material.Outlined.Business, Children:
        [
            new("ERP Overview", "/erp", Icons.Material.Outlined.SpaceDashboard),
            new("ERP Toolkit", "/erp-toolkit", Icons.Material.Outlined.AccountTree),
            new("Human Resources", "/erp/hr", Icons.Material.Outlined.Groups, Children:
            [
                new("Employees", "/erp/hr/employees", Icons.Material.Outlined.Badge),
                new("Attendance & Leave", "/erp/hr/attendance", Icons.Material.Outlined.EventAvailable)
            ]),
            new("Production", "/erp/production", Icons.Material.Outlined.Factory, Children:
            [
                new("Work Orders", "/erp/production/work-orders", Icons.Material.Outlined.PrecisionManufacturing),
                new("Quality Control", "/erp/production/quality", Icons.Material.Outlined.FactCheck)
            ]),
            new("Finance", "/erp/finance", Icons.Material.Outlined.AccountBalance, Children:
            [
                new("General Ledger", "/erp/finance/general-ledger", Icons.Material.Outlined.MenuBook),
                new("Accounts Payable", "/erp/finance/payables", Icons.Material.Outlined.Payments),
                new("Accounts Receivable", "/erp/finance/receivables", Icons.Material.Outlined.RequestQuote)
            ]),
            new("Supply Chain", "/erp/procurement", Icons.Material.Outlined.ShoppingCart, Children:
            [
                new("Inventory", "/erp/inventory", Icons.Material.Outlined.Inventory2)
            ]),
            new("Sales", "/erp/sales", Icons.Material.Outlined.PointOfSale, Children:
            [
                new("Sales Orders", "/erp/sales/orders", Icons.Material.Outlined.ReceiptLong)
            ])
        ]),
        new("Operations", Icon: Icons.Material.Outlined.AccountTree, Children:
        [
            new("CRUD Asset", "/crud", Icons.Material.Outlined.EditNote),
            new("CRUD Simple", "/crud-simple", Icons.Material.Outlined.AddBox),
            new("Grid Editor", "/grid-editor", Icons.Material.Outlined.EditRoad),
            new("Advanced Editable Grid", "/advanced-editable-grid", Icons.Material.Outlined.TableView),
            new("Model CRUD", "/model-crud", Icons.Material.Outlined.DynamicForm),
            new("Form Designer", "/model-form-designer", Icons.Material.Outlined.DashboardCustomize),
            new("Dynamic Menu", "/dynamic-menu", Icons.Material.Outlined.AccountTree),
            new("Operations Workspace", "/operations-workspace", Icons.Material.Outlined.Workspaces),
            new("Spatial Operations", "/spatial-operations", Icons.Material.Outlined.Explore),
            new("Tree Grid", "/tree-grid", Icons.Material.Outlined.AccountTree),
            new("Hierarchy Designer", "/hierarchy-designer", Icons.Material.Outlined.Schema),
            new("Kanban", "/kanban", Icons.Material.Outlined.ViewKanban),
            new("Calendar", "/calendar", Icons.Material.Outlined.CalendarMonth),
            new("Scheduler", "/scheduler", Icons.Material.Outlined.CalendarViewWeek),
            new("Sales Pipeline", "/sales-pipeline", Icons.Material.Outlined.FilterAlt),
            new("Jobs", "/jobs", Icons.Material.Outlined.WorkOutline),
            new("Chat", "/chat", Icons.Material.Outlined.Chat),
            new("AI Chat", "/ai-chat", Icons.Material.Outlined.AutoAwesome),
            new("Email", "/email", Icons.Material.Outlined.MailOutline),
            new("Computer Monitoring", "/monitoring/computers", Icons.Material.Outlined.Computer),
            new("Service Monitoring", "/monitoring", Icons.Material.Outlined.MonitorHeart),
            new("Database Monitoring", "/monitoring-database", Icons.Material.Outlined.Dns)
        ]),
        new("Data & Reports", Icon: Icons.Material.Outlined.FolderOpen, Children:
        [
            new("Static / Master", "/static-data", Icons.Material.Outlined.Storage),
            new("Large Data Grid", "/data-grid-large", Icons.Material.Outlined.TableRows),
            new("Grouped Data Grid", "/grouped-data-grid", Icons.Material.Outlined.ViewStream),
            new("Reports", "/reports", Icons.Material.Outlined.Assessment),
            new("PDF Viewer", "/pdf-viewer", Icons.Material.Outlined.PictureAsPdf),
            new("Pivot", "/pivot", Icons.Material.Outlined.PivotTableChart),
            new("Enterprise Toolkit", "/enterprise-toolkit", Icons.Material.Outlined.DomainAdd),
            new("Experience Toolkit", "/experience-toolkit", Icons.Material.Outlined.AccessibilityNew),
            new("Business Toolkit", "/business-toolkit", Icons.Material.Outlined.AccountTree),
            new("ERP Release Train", "/erp-release-train", Icons.Material.Outlined.Factory)
        ]),
        new("Commerce & Content", Icon: Icons.Material.Outlined.Storefront, Children:
        [
            new("Product Catalog", "/catalog", Icons.Material.Outlined.ShoppingBag),
            new("Product Management", "/product-management", Icons.Material.Outlined.Inventory2),
            new("Product Detail", "/product-detail", Icons.Material.Outlined.Sell),
            new("Product Editor", "/product-editor", Icons.Material.Outlined.EditNote),
            new("Website Front", "/website", Icons.Material.Outlined.Language),
            new("Job Landing", "/job-landing", Icons.Material.Outlined.WorkOutline),
            new("Blog", "/blog", Icons.Material.Outlined.Article)
        ]),
        new("Account", Icon: Icons.Material.Outlined.ManageAccounts, Children:
        [
            new("Edit Account", "/account/edit", Icons.Material.Outlined.ManageAccounts),
            new("Login", "/login", Icons.Material.Outlined.Login),
            new("Two-step verification", "/two-step-verification", Icons.Material.Outlined.VerifiedUser),
            new("Reset password", "/reset-password", Icons.Material.Outlined.LockReset)
        ]),
        new("UI Kit", Icon: Icons.Material.Outlined.Widgets, Children:
        [
            new("Components", "/components", Icons.Material.Outlined.Widgets),
            new("Development Rules", "/development-rules", Icons.Material.Outlined.Rule),
            new("Accordions", "/accordions", Icons.Material.Outlined.UnfoldMore),
            new("Charts", "/charts", Icons.Material.Outlined.InsertChartOutlined),
            new("File Upload", "/file-upload", Icons.Material.Outlined.CloudUpload),
            new("Grid Preferences", "/grid-preferences", Icons.Material.Outlined.ViewColumn),
            new("Vector Map", "/vector-map", Icons.Material.Outlined.Map),
            new("Colors", "/colors", Icons.Material.Outlined.Palette),
            new("Timeline", "/timeline", Icons.Material.Outlined.Timeline),
            new("Widgets", "/widgets", Icons.Material.Outlined.ViewQuilt),
            new("Profile Card Grid", "/profile-grid", Icons.Material.Outlined.Badge)
        ])
    ];

    public static IReadOnlyList<FlatNavigationSearchItem> SearchItems { get; } = BuildSearchItems(NavigationItems);

    public static string ResolvePageTitle(string uriOrPath)
    {
        var rawPath = Uri.TryCreate(uriOrPath, UriKind.Absolute, out var absolute)
            ? absolute.AbsolutePath
            : uriOrPath.Split('?', '#')[0];
        var path = "/" + rawPath.Trim('/').ToLowerInvariant();
        if (path == "//") path = "/";

        var item = Flatten(NavigationItems).FirstOrDefault(candidate =>
            string.Equals(candidate.Href.TrimEnd('/'), path.TrimEnd('/'), StringComparison.OrdinalIgnoreCase));
        return item is null ? "Not found" : item.Title;
    }

    private static IReadOnlyList<FlatNavigationSearchItem> BuildSearchItems(
        IReadOnlyList<FlatNavigationMenuItem> items) => Flatten(items)
        .Where(item => !string.IsNullOrWhiteSpace(item.Href))
        .Select(item => new FlatNavigationSearchItem(
            item.Title,
            item.Href,
            ResolveGroup(items, item.Href),
            $"{item.Title} {ResolveGroup(items, item.Href)} showcase sample",
            item.Icon))
        .ToArray();

    private static IEnumerable<FlatNavigationMenuItem> Flatten(IEnumerable<FlatNavigationMenuItem> items)
    {
        foreach (var item in items)
        {
            yield return item;
            if (item.Children is null) continue;
            foreach (var child in Flatten(item.Children)) yield return child;
        }
    }

    private static string ResolveGroup(IEnumerable<FlatNavigationMenuItem> roots, string href) =>
        roots.FirstOrDefault(root => Flatten([root]).Any(item => item.Href == href))?.Title ?? "Showcase";
}
