// Copyright (c) 2026 opx. All rights reserved.

using Android.App;
using Android.Content.PM;
using Android.OS;
using AndroidX.Activity;
using AndroidX.Core.View;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample;

[Activity(
    Theme = "@style/Maui.SplashTheme",
    MainLauncher = true,
    LaunchMode = LaunchMode.SingleTop,
    ConfigurationChanges = ConfigChanges.ScreenSize
        | ConfigChanges.Orientation
        | ConfigChanges.UiMode
        | ConfigChanges.ScreenLayout
        | ConfigChanges.SmallestScreenSize
        | ConfigChanges.Density)]
public class MainActivity : MauiAppCompatActivity
{
    private ModalAwareBackPressedCallback? _modalAwareBackPressedCallback;
    private bool _modalBackKeyConsumed;

    public override bool DispatchKeyEvent(Android.Views.KeyEvent? e)
    {
        if (e?.KeyCode == Android.Views.Keycode.Back)
        {
            if (e.Action == Android.Views.KeyEventActions.Up && _modalBackKeyConsumed)
            {
                _modalBackKeyConsumed = false;
                return true;
            }
            var page = Microsoft.Maui.Controls.Application.Current?.Windows.FirstOrDefault()?.Page as MainPage;
            if (e.Action == Android.Views.KeyEventActions.Down &&
                (_modalBackKeyConsumed || page is not null))
            {
                // MAUI 10.0.20 WebView.OnKeyDown calls GoBack before Activity callbacks.
                // One dispatch owns IME, overlays, WebView history and finally root.
                // Consume the paired key-up so MAUI cannot perform a second Back.
                if (!_modalBackKeyConsumed)
                {
                    _modalBackKeyConsumed = true;
                    _modalAwareBackPressedCallback?.HandleOnBackPressed();
                }
                return true;
            }
        }
        return base.DispatchKeyEvent(e);
    }

    public override bool DispatchTouchEvent(Android.Views.MotionEvent? e)
    {
        if (e is null) return base.DispatchTouchEvent(e);
        var page = Microsoft.Maui.Controls.Application.Current?.Windows.FirstOrDefault()?.Page as MainPage;
        page?.BeforeNativeTouch(e);
        try { return base.DispatchTouchEvent(e); }
        finally { page?.AfterNativeTouch(e); }
    }

    protected override void OnCreate(Bundle? savedInstanceState)
    {
        base.OnCreate(savedInstanceState);
        WindowCompat.SetDecorFitsSystemWindows(Window, false);

        EnsureModalBackPriority();
    }

    internal void EnsureModalBackPriority()
    {
        // MAUI may register its WebView history callback after Activity.OnCreate.
        // Reattach after handler/overlay changes so modal handling wins on non-root routes too.
        _modalAwareBackPressedCallback ??= new ModalAwareBackPressedCallback(this);
        _modalAwareBackPressedCallback.Remove();
        OnBackPressedDispatcher.AddCallback(this, _modalAwareBackPressedCallback);
    }

    private sealed class ModalAwareBackPressedCallback(MainActivity activity)
        : OnBackPressedCallback(true)
    {
        private bool _handlingBack;

        public override async void HandleOnBackPressed()
        {
            if (_handlingBack)
            {
                return;
            }

            _handlingBack = true;

            try
            {
                var decor = activity.Window?.DecorView;
                if (decor is not null && ViewCompat.GetRootWindowInsets(decor)?
                    .IsVisible(WindowInsetsCompat.Type.Ime()) == true)
                {
                    WindowCompat.GetInsetsController(activity.Window!, decor)?
                        .Hide(WindowInsetsCompat.Type.Ime());
                    return;
                }

                var page = Microsoft.Maui.Controls.Application.Current?
                    .Windows
                    .FirstOrDefault()?
                    .Page as MainPage;

                if (page is not null && await page.TryHandleModalBackAsync())
                {
                    return;
                }

                if (page?.TryNavigateBack() == true)
                {
                    return;
                }

                Enabled = false;
                activity.OnBackPressedDispatcher.OnBackPressed();
            }
            finally
            {
                Enabled = true;
                _handlingBack = false;
            }
        }
    }
}
