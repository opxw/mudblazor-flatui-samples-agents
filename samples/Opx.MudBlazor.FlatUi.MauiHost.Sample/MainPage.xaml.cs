// Copyright (c) 2026 opx. All rights reserved.

#if ANDROID
using Android.Views;
using AndroidX.Core.View;
using CommunityToolkit.Maui.Behaviors;
using CommunityToolkit.Maui.Core;
#endif

using Opx.MudBlazor.FlatUi.Services;
using Microsoft.JSInterop;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample;

public partial class MainPage : ContentPage
{
    private readonly FlatNativePullToRefreshState _nativePullToRefreshState;
    private readonly Command _nativeRefreshCommand;
#if ANDROID
    private readonly StatusBarBehavior _statusBarBehavior = new();
#endif

    public MainPage(FlatNativePullToRefreshState nativePullToRefreshState)
    {
        _nativePullToRefreshState = nativePullToRefreshState;
        _nativeRefreshCommand = new Command(
            ExecuteNativeRefresh,
            () => _nativePullToRefreshState.IsEnabled && !_nativePullToRefreshState.IsRefreshing);

        InitializeComponent();
        nativeRefreshView.Command = _nativeRefreshCommand;
        _nativePullToRefreshState.Changed += HandleNativePullToRefreshChanged;
        ApplyNativePullToRefreshState();
#if ANDROID
        Behaviors.Add(_statusBarBehavior);
        Loaded += DisableAndroidWebViewBounce;
#endif
    }

    private async void ExecuteNativeRefresh()
    {
        Task<bool>? refreshTask = null;

        try
        {
            var dispatched = await blazorWebView.TryDispatchAsync(_ =>
                refreshTask = _nativePullToRefreshState.TryRefreshAsync());

            if (dispatched && refreshTask is not null)
            {
                await refreshTask;
            }
        }
        catch (OperationCanceledException)
        {
        }
        catch (Exception exception)
        {
            System.Diagnostics.Debug.WriteLine(
                $"Native pull-to-refresh failed: {exception.GetType().Name}");
        }
        finally
        {
            await Dispatcher.DispatchAsync(() =>
            {
                nativeRefreshView.IsRefreshing = false;
                ApplyNativePullToRefreshState();
            });
        }
    }

    private void HandleNativePullToRefreshChanged(object? sender, EventArgs e) =>
        Dispatcher.Dispatch(ApplyNativePullToRefreshState);

    private void ApplyNativePullToRefreshState()
    {
        nativeRefreshView.IsRefreshEnabled = _nativePullToRefreshState.IsEnabled;
        if (!_nativePullToRefreshState.IsRefreshing)
        {
            nativeRefreshView.IsRefreshing = false;
        }

        _nativeRefreshCommand.ChangeCanExecute();
    }

    public async Task<bool> TryHandleModalBackAsync()
    {
        Task<bool>? modalBackTask = null;

        try
        {
            var dispatched = await blazorWebView.TryDispatchAsync(services =>
            {
                var js = services.GetRequiredService<IJSRuntime>();
                modalBackTask = js.InvokeAsync<bool>("opxFlatModalHistory.tryHandleBack").AsTask();
            });

            return dispatched
                && modalBackTask is not null
                && await modalBackTask;
        }
        catch (JSDisconnectedException)
        {
            return false;
        }
        catch (InvalidOperationException)
        {
            return false;
        }
    }

#if ANDROID
    private void DisableAndroidWebViewBounce(object? sender, EventArgs e)
    {
        if (blazorWebView.Handler?.PlatformView is Android.Webkit.WebView webView)
        {
            webView.OverScrollMode = OverScrollMode.Never;
        }
    }
#endif

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
