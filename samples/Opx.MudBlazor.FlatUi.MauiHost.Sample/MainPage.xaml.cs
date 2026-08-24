// Copyright (c) 2026 opx. All rights reserved.

#if ANDROID
using AndroidX.Core.View;
using CommunityToolkit.Maui.Behaviors;
using CommunityToolkit.Maui.Core;
#endif

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample;

public partial class MainPage : ContentPage
{
#if ANDROID
    private readonly StatusBarBehavior _statusBarBehavior = new();
#endif

    public MainPage()
    {
        InitializeComponent();
#if ANDROID
        Behaviors.Add(_statusBarBehavior);
#endif
    }

    public Task ApplyStatusBarAsync(bool useLightContent)
    {
#if ANDROID
        return Dispatcher.DispatchAsync(() =>
        {
            _statusBarBehavior.StatusBarColor = Colors.Transparent;
            _statusBarBehavior.StatusBarStyle = useLightContent
                ? StatusBarStyle.LightContent
                : StatusBarStyle.DarkContent;
        });
#else
        return Task.CompletedTask;
#endif
    }

    public Task<double> GetStatusBarInsetAsync()
    {
#if ANDROID
        return Dispatcher.DispatchAsync(() =>
        {
            var activity = Platform.CurrentActivity;
            var decorView = activity?.Window?.DecorView;
            var insets = decorView is null ? null : ViewCompat.GetRootWindowInsets(decorView);
            var insetPixels = insets?.GetInsets(WindowInsetsCompat.Type.StatusBars())?.Top ?? 0;
            var density = DeviceDisplay.Current.MainDisplayInfo.Density;
            return density > 0 ? insetPixels / density : 0d;
        });
#else
        return Task.FromResult(0d);
#endif
    }
}
