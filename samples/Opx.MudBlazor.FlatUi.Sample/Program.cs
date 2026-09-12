using Opx.MudBlazor.FlatUi.Sample.Components;
using Opx.MudBlazor.FlatUi.Sample.Services;
using Opx.MudBlazor.FlatUi.Models;
using Opx.MudBlazor.FlatUi.Services;
using Opx.MudBlazor.FlatUi.Showcase;
using MudBlazor.Services;
using System.Net.WebSockets;
using System.Text;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
var detailedCircuitErrors = builder.Environment.IsDevelopment()
    && builder.Configuration.GetValue("DetailedErrors", false);
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents(options =>
    {
        options.DetailedErrors = detailedCircuitErrors;
    });
var snackbarOptions = builder.Configuration
    .GetSection("OpxFlatUi:Snackbar")
    .Get<FlatSnackbarOptions>() ?? new FlatSnackbarOptions();
builder.Services.AddSingleton(snackbarOptions);
builder.Services.AddMudServices(options =>
{
    options.SnackbarConfiguration.HideTransitionDuration =
        snackbarOptions.NormalizedHideTransitionDurationMs;
});
builder.Services.AddOpxFlatUiShowcase();
builder.Services.AddScoped<FlatPageLoadingState>();
builder.Services.AddScoped<FlatMessageBoxService>();
builder.Services.AddScoped<IFlatPrintService, FlatWebPrintService>();
builder.Services.AddScoped<IDeviceNotificationService, FlatWebDeviceNotificationService>();
var applicationOptions = builder.Configuration
    .GetSection("OpxFlatUi:Application")
    .Get<FlatApplicationOptions>() ?? new FlatApplicationOptions();
builder.Services.AddSingleton(applicationOptions);
var displayOptions = builder.Configuration
    .GetSection("OpxFlatUi:Display")
    .Get<FlatUiDisplayOptions>() ?? new FlatUiDisplayOptions();
builder.Services.AddSingleton(displayOptions);
var reconnectOptions = builder.Configuration
    .GetSection("OpxFlatUi:Reconnect")
    .Get<FlatReconnectOptions>() ?? new FlatReconnectOptions();
builder.Services.AddSingleton(reconnectOptions);
var deviceNotificationOptions = builder.Configuration
    .GetSection("OpxFlatUi:DeviceNotification")
    .Get<FlatDeviceNotificationOptions>() ?? new FlatDeviceNotificationOptions();
builder.Services.AddSingleton(deviceNotificationOptions);
var gridOptions = builder.Configuration
    .GetSection("OpxFlatUi:Grid")
    .Get<FlatGridOptions>() ?? new FlatGridOptions();
builder.Services.AddSingleton(gridOptions);
var loadingOptions = builder.Configuration
    .GetSection("OpxFlatUi:Loading")
    .Get<FlatLoadingOptions>() ?? new FlatLoadingOptions();
builder.Services.AddSingleton(loadingOptions);
var assetOptions = builder.Configuration
    .GetSection("OpxFlatUi:Assets")
    .Get<FlatAssetOptions>() ?? new FlatAssetOptions();
builder.Services.AddSingleton(assetOptions);
var localizationOptions = builder.Configuration
    .GetSection("OpxFlatUi:Localization")
    .Get<FlatLocalizationOptions>() ?? new FlatLocalizationOptions();
builder.Services.AddSingleton(localizationOptions);
builder.Services.AddSingleton(sp => new FlatValueFormatter(sp.GetRequiredService<FlatLocalizationOptions>()));
builder.Services.AddScoped<FlatUiPreferencesService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}
app.UseStatusCodePagesWithReExecute("/not-found", createScopeForStatusCodePages: true);
app.UseHttpsRedirection();

app.UseAntiforgery();
app.UseWebSockets();

app.MapGet("/sample-documents/sales-report.pdf", () => Results.File(
    CreateSampleSalesPdf(),
    "application/pdf",
    "sales-report-august-2026.pdf",
    enableRangeProcessing: true));

app.Map("/ws/chat-demo", async context =>
{
    if (!context.WebSockets.IsWebSocketRequest)
    {
        context.Response.StatusCode = StatusCodes.Status400BadRequest;
        return;
    }

    using var socket = await context.WebSockets.AcceptWebSocketAsync();
    var buffer = new byte[16 * 1024];
    while (socket.State == WebSocketState.Open && !context.RequestAborted.IsCancellationRequested)
    {
        var received = await socket.ReceiveAsync(buffer, context.RequestAborted);
        if (received.MessageType == WebSocketMessageType.Close)
            break;
        if (!received.EndOfMessage || received.Count == buffer.Length)
        {
            await socket.CloseAsync(WebSocketCloseStatus.MessageTooBig, "Event too large", CancellationToken.None);
            break;
        }

        var item = JsonSerializer.Deserialize<FlatChatSocketEvent>(buffer.AsSpan(0, received.Count), new JsonSerializerOptions(JsonSerializerDefaults.Web));
        if (item?.Type != "message")
            continue;

        async Task SendEventAsync(FlatChatSocketEvent value)
        {
            var payload = JsonSerializer.SerializeToUtf8Bytes(value, new JsonSerializerOptions(JsonSerializerDefaults.Web));
            await socket.SendAsync(payload, WebSocketMessageType.Text, true, context.RequestAborted);
        }

        await SendEventAsync(new("typing", item.ConversationId, "Rina", "RN"));
        await Task.Delay(700, context.RequestAborted);
        await SendEventAsync(new("message", item.ConversationId, "Rina", "RN", "Received through the configured demo WebSocket endpoint.", Guid.NewGuid().ToString("N")));
    }
});

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddAdditionalAssemblies(typeof(Opx.MudBlazor.FlatUi.Showcase.ShowcaseAssemblyMarker).Assembly)
    .AddInteractiveServerRenderMode();

app.Run();

static byte[] CreateSampleSalesPdf()
{
    const int pageCount = 12;
    var objects = new List<string>();
    var pageObjectNumbers = Enumerable.Range(0, pageCount).Select(index => 3 + (index * 2)).ToArray();
    var fontObjectNumber = 3 + (pageCount * 2);
    objects.Add("<< /Type /Catalog /Pages 2 0 R >>");
    objects.Add($"<< /Type /Pages /Kids [{string.Join(' ', pageObjectNumbers.Select(number => $"{number} 0 R"))}] /Count {pageCount} >>");

    for (var index = 0; index < pageCount; index++)
    {
        var pageNumber = index + 1;
        var contentObjectNumber = pageObjectNumbers[index] + 1;
        var content = $"BT /F1 20 Tf 72 760 Td (Sales Report - August 2026) Tj 0 -34 Td /F1 12 Tf (Page {pageNumber} of {pageCount}) Tj 0 -42 Td (OPX PDF.js responsive viewer sample) Tj 0 -28 Td (Parameters, search, thumbnails, download, share, and print are host-controlled.) Tj ET";
        objects.Add($"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 595 842] /Resources << /Font << /F1 {fontObjectNumber} 0 R >> >> /Contents {contentObjectNumber} 0 R >>");
        objects.Add($"<< /Length {Encoding.ASCII.GetByteCount(content)} >>\nstream\n{content}\nendstream");
    }

    objects.Add("<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>");
    using var stream = new MemoryStream();
    using var writer = new StreamWriter(stream, Encoding.ASCII, leaveOpen: true) { NewLine = "\n" };
    writer.WriteLine("%PDF-1.4");
    writer.Flush();
    var offsets = new List<long> { 0 };
    for (var index = 0; index < objects.Count; index++)
    {
        offsets.Add(stream.Position);
        writer.WriteLine($"{index + 1} 0 obj");
        writer.WriteLine(objects[index]);
        writer.WriteLine("endobj");
        writer.Flush();
    }

    var xrefOffset = stream.Position;
    writer.WriteLine("xref");
    writer.WriteLine($"0 {objects.Count + 1}");
    writer.WriteLine("0000000000 65535 f ");
    foreach (var offset in offsets.Skip(1)) writer.WriteLine($"{offset:0000000000} 00000 n ");
    writer.WriteLine("trailer");
    writer.WriteLine($"<< /Size {objects.Count + 1} /Root 1 0 R >>");
    writer.WriteLine("startxref");
    writer.WriteLine(xrefOffset);
    writer.WriteLine("%%EOF");
    writer.Flush();
    return stream.ToArray();
}
