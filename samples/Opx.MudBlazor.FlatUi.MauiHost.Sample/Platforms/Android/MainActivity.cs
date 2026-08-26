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

    protected override void OnCreate(Bundle? savedInstanceState)
    {
        base.OnCreate(savedInstanceState);
        WindowCompat.SetDecorFitsSystemWindows(Window, false);

        _modalAwareBackPressedCallback = new ModalAwareBackPressedCallback(this);
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
                var page = Microsoft.Maui.Controls.Application.Current?
                    .Windows
                    .FirstOrDefault()?
                    .Page as MainPage;

                if (page is not null && await page.TryHandleModalBackAsync())
                {
                    return;
                }

                if (page is not null && await page.TryHandleBlazorBackAsync())
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
