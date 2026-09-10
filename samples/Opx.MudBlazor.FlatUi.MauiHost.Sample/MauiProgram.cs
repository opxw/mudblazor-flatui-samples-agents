// Copyright (c) 2026 opx. All rights reserved.

using CommunityToolkit.Maui;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using MudBlazor.Services;
using Opx.MudBlazor.FlatUi.Models;
using Opx.MudBlazor.FlatUi.Services;
using Opx.MudBlazor.FlatUi.Showcase;
using Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample;

public static class MauiProgram
{
    public static MauiApp CreateMauiApp()
    {
        var builder = MauiApp.CreateBuilder()
            .UseMauiApp<App>()
            .UseMauiCommunityToolkit();

#if ANDROID
        builder.ConfigureMauiHandlers(handlers => handlers.AddHandler<RefreshView, NativeRefreshViewHandler>());
#endif

        using var settings = typeof(MauiProgram).Assembly
            .GetManifestResourceStream("appsettings.json")
            ?? throw new InvalidOperationException("Embedded appsettings.json was not found.");
        builder.Configuration.AddJsonStream(settings);

        builder.Services.AddMauiBlazorWebView();
        builder.Services.AddMudServices(options =>
        {
            var snackbar = builder.Configuration.GetSection("OpxFlatUi:Snackbar")
                .Get<FlatSnackbarOptions>() ?? new FlatSnackbarOptions();
            options.SnackbarConfiguration.HideTransitionDuration = snackbar.NormalizedHideTransitionDurationMs;
        });

        RegisterFlatUiOptions(builder.Services, builder.Configuration);
        builder.Services.AddOpxFlatUiShowcase();
        builder.Services.AddSingleton<FlatNativePullToRefreshState>();
        FlatMobileConfigurationValidator.ValidateOrThrow(
            builder.Configuration.GetSection("OpxFlatUi:Mobile:Pages").Get<FlatPageRefreshConfiguration[]>() ?? [],
            FlatUiHostKind.MauiHybrid, nativeAdapterRegistered: true);
        builder.Services.AddScoped<FlatPageLoadingState>();
        builder.Services.AddScoped<FlatMessageBoxService>();
        builder.Services.AddScoped<FlatOverlayCoordinator>();
        builder.Services.AddScoped<FlatUiPreferencesService>();
        builder.Services.AddSingleton<IHybridDeviceAdapter, MauiHybridDeviceAdapter>();
        builder.Services.AddSingleton<IHybridStatusBarService, MauiHybridStatusBarService>();
        builder.Services.AddSingleton<IHybridSessionBootstrapper, SampleHybridSessionBootstrapper>();
        builder.Services.AddSingleton<IDeviceNotificationService, MauiDeviceNotificationService>();
        builder.Services.AddSingleton<MainPage>();

#if DEBUG
        builder.Services.AddBlazorWebViewDeveloperTools();
        builder.Logging.AddDebug();
#endif

        return builder.Build();
    }

    private static void RegisterFlatUiOptions(IServiceCollection services, IConfiguration configuration)
    {
        services.AddSingleton(configuration.GetSection("OpxFlatUi:Application")
            .Get<FlatApplicationOptions>() ?? new FlatApplicationOptions());
        services.AddSingleton(configuration.GetSection("OpxFlatUi:Display")
            .Get<FlatUiDisplayOptions>() ?? new FlatUiDisplayOptions());
        services.AddSingleton(configuration.GetSection("OpxFlatUi:Reconnect")
            .Get<FlatReconnectOptions>() ?? new FlatReconnectOptions());
        services.AddSingleton(configuration.GetSection("OpxFlatUi:DeviceNotification")
            .Get<FlatDeviceNotificationOptions>() ?? new FlatDeviceNotificationOptions());
        services.AddSingleton(configuration.GetSection("OpxFlatUi:Grid")
            .Get<FlatGridOptions>() ?? new FlatGridOptions());
        services.AddSingleton(configuration.GetSection("OpxFlatUi:Loading")
            .Get<FlatLoadingOptions>() ?? new FlatLoadingOptions());
        services.AddSingleton(configuration.GetSection("OpxFlatUi:Assets")
            .Get<FlatAssetOptions>() ?? new FlatAssetOptions());
        services.AddSingleton(configuration.GetSection("OpxFlatUi:Snackbar")
            .Get<FlatSnackbarOptions>() ?? new FlatSnackbarOptions());
        services.AddSingleton(configuration.GetSection("OpxFlatUi:Localization")
            .Get<FlatLocalizationOptions>() ?? new FlatLocalizationOptions());
        services.AddSingleton(serviceProvider =>
            new FlatValueFormatter(serviceProvider.GetRequiredService<FlatLocalizationOptions>()));
    }
}
