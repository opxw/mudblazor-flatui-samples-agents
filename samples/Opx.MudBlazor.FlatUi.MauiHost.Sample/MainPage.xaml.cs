// Copyright (c) 2026 opx. All rights reserved.

#if ANDROID
using Android.Views;
using AndroidX.Core.View;
using AndroidX.SwipeRefreshLayout.Widget;
using CommunityToolkit.Maui.Behaviors;
using CommunityToolkit.Maui.Core;
#endif

using Opx.MudBlazor.FlatUi.Services;
using Microsoft.JSInterop;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample;

public partial class MainPage : ContentPage
{
#if ANDROID
    private const double AppBarHeightDip = 60d;
    private const double RefreshIndicatorGapDip = 8d;
#endif
    private readonly FlatNativePullToRefreshState _nativePullToRefreshState;
    private readonly Command _nativeRefreshCommand;
    private IDisposable? _backgroundRefreshLease;
    internal bool HasSuspendedOverlay => _nativePullToRefreshState.IsSuspended;
    internal void SuspendRefreshForBackground() => _backgroundRefreshLease ??= _nativePullToRefreshState.Suspend();
    internal void ResumeRefreshFromBackground() { _backgroundRefreshLease?.Dispose(); _backgroundRefreshLease = null; }
#if ANDROID
    private readonly StatusBarBehavior _statusBarBehavior = new();
    private NativeRefreshGestureGate? _refreshGestureGate;
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
        Loaded += ConfigureAndroidHost;
        SizeChanged += RepositionAndroidRefreshIndicator;
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
#if ANDROID
        (Platform.CurrentActivity as MainActivity)?.EnsureModalBackPriority();
#endif
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
                modalBackTask = DispatchOverlayBackAsync(services);
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

    private static async Task<bool> DispatchOverlayBackAsync(IServiceProvider services)
    {
        // JS-invokable modal callbacks run on the Blazor renderer dispatcher.
        // Native TryDispatchAsync supplies scoped services, not a component dispatcher.
        if (await services.GetRequiredService<IJSRuntime>()
            .InvokeAsync<bool>("opxFlatModalHistory.tryHandleBack")) return true;
        var overlays = services.GetService<FlatOverlayCoordinator>();
        if (overlays?.HasActiveOverlay == true)
        {
            await overlays.TryHandleBackAsync();
            // Rejected dismissal still consumes Back; it must never exit the app.
            return true;
        }
        return false;
    }

#if ANDROID
    internal bool TryNavigateBack()
    {
        // Activity fallback does not invoke BlazorAndroidWebView.OnKeyDown.
        // Consult the actual WebView history rather than guessing a parent URL.
        if (blazorWebView.Handler?.PlatformView is Android.Webkit.WebView webView
            && webView.CanGoBack())
        {
            webView.GoBack();
            return true;
        }
        return false;
    }

    private void ConfigureAndroidHost(object? sender, EventArgs e)
    {
        (Platform.CurrentActivity as MainActivity)?.EnsureModalBackPriority();
        if (blazorWebView.Handler?.PlatformView is Android.Webkit.WebView webView)
        {
            webView.OverScrollMode = OverScrollMode.Never;
        }

        ApplyAndroidRefreshIndicatorOffset();
        if (nativeRefreshView.Handler?.PlatformView is GatedMauiSwipeRefreshLayout refreshLayout)
        {
            _refreshGestureGate ??= new NativeRefreshGestureGate(_nativePullToRefreshState);
            refreshLayout.GestureGate = _refreshGestureGate;
        }
    }

    internal void BeforeNativeTouch(MotionEvent e)
    {
        if (blazorWebView.Handler?.PlatformView is Android.Webkit.WebView webView)
            _refreshGestureGate?.BeforeDispatch(e, webView);
    }

    internal void AfterNativeTouch(MotionEvent e) => _refreshGestureGate?.AfterDispatch(e);

    private void RepositionAndroidRefreshIndicator(object? sender, EventArgs e) =>
        ApplyAndroidRefreshIndicatorOffset();

    private void ApplyAndroidRefreshIndicatorOffset()
    {
        if (nativeRefreshView.Handler?.PlatformView is not SwipeRefreshLayout refreshLayout)
        {
            return;
        }

        var density = Platform.CurrentActivity?.Resources?.DisplayMetrics?.Density ?? 1f;
        var insets = ViewCompat.GetRootWindowInsets(refreshLayout);
        var statusBarInsetPx = insets?.GetInsets(WindowInsetsCompat.Type.StatusBars())?.Top ?? 0;
        var navigationInsetPx = insets?.GetInsets(WindowInsetsCompat.Type.NavigationBars())?.Bottom ?? 0;
        if (blazorWebView.Handler?.PlatformView is Android.Webkit.WebView webView)
        {
            var bottomDip = Math.Clamp(navigationInsetPx / Math.Max(density, 1f), 0, 96)
                .ToString(System.Globalization.CultureInfo.InvariantCulture);
            webView.EvaluateJavascript($"document.documentElement.style.setProperty('--opx-native-navigationbar-height','{bottomDip}px')", null);
        }
        var appBarHeightPx = (int)Math.Round(AppBarHeightDip * density);
        var indicatorGapPx = (int)Math.Round(RefreshIndicatorGapDip * density);
        var startOffsetPx = statusBarInsetPx + appBarHeightPx - refreshLayout.ProgressCircleDiameter;
        var endOffsetPx = statusBarInsetPx + appBarHeightPx + indicatorGapPx;

        refreshLayout.SetProgressViewOffset(false, startOffsetPx, endOffsetPx);
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
            ApplyAndroidRefreshIndicatorOffset();
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
