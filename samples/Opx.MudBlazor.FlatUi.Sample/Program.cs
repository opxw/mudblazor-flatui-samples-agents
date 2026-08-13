using Opx.MudBlazor.FlatUi.Sample.Components;
using Opx.MudBlazor.FlatUi.Sample.Services;
using Opx.MudBlazor.FlatUi.Models;
using Opx.MudBlazor.FlatUi.Services;
using MudBlazor.Services;
using System.Net.WebSockets;
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
builder.Services.AddSingleton<SampleCatalog>();
builder.Services.AddSingleton<ErpSampleCatalog>();
builder.Services.AddScoped(typeof(FlatSessionCartService<>));
builder.Services.AddScoped<FlatPageLoadingState>();
builder.Services.AddScoped<FlatMessageBoxService>();
builder.Services.AddScoped<FlatChatWebSocketClient>();
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
    .AddInteractiveServerRenderMode();

app.Run();
