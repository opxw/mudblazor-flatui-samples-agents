using System.Reflection;
using CommunityToolkit.Maui;
using Microsoft.Extensions.Configuration;
using MudBlazor.Services;
using Opx.MudBlazor.FlatUi.Models;
using Opx.MudBlazor.FlatUi.Services;
using Opx.MudBlazor.FlatUi.Maui.Template.Services;

namespace Opx.MudBlazor.FlatUi.Maui.Template;

public static class MauiProgram
{
    public static MauiApp CreateMauiApp()
    {
        using var settings = Assembly.GetExecutingAssembly()
            .GetManifestResourceStream("appsettings.json")
            ?? throw new InvalidOperationException("Embedded appsettings.json was not found.");

        var builder = MauiApp.CreateBuilder();
        builder.Configuration.AddJsonStream(settings);
        builder
            .UseMauiApp<App>()
            .UseMauiCommunityToolkit();

        MobileWebViewPolicies.Configure();

        builder.Services.AddMauiBlazorWebView();
        builder.Services.AddMudServices();
        builder.Services.AddSingleton<MainPage>();
        builder.Services.AddSingleton<MobileThemeBridge>();
        builder.Services.AddSingleton(builder.Configuration
            .GetSection("OpxFlatUi:Application")
            .Get<FlatApplicationOptions>() ?? new FlatApplicationOptions());
        builder.Services.AddSingleton(builder.Configuration
            .GetSection("OpxFlatUi:Display")
            .Get<FlatUiDisplayOptions>() ?? new FlatUiDisplayOptions());
        builder.Services.AddSingleton(builder.Configuration
            .GetSection("OpxFlatUi:Reconnect")
            .Get<FlatReconnectOptions>() ?? new FlatReconnectOptions());
        builder.Services.AddScoped<FlatUiPreferencesService>();
        builder.Services.AddScoped<FlatPageLoadingState>();
        builder.Services.AddScoped<FlatMessageBoxService>();
        builder.Services.AddScoped<IRootStartupGateValidator, SampleRootStartupGateValidator>();

        return builder.Build();
    }
}
