using Android.App;
using Android.Content.PM;
using Android.OS;
using AndroidX.Activity;

namespace Opx.MudBlazor.FlatUi.Maui.Template;

[Activity(Theme = "@style/Maui.SplashTheme", MainLauncher = true, LaunchMode = LaunchMode.SingleTop,
    ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation | ConfigChanges.UiMode |
                           ConfigChanges.ScreenLayout | ConfigChanges.SmallestScreenSize | ConfigChanges.Density)]
public class MainActivity : MauiAppCompatActivity
{
    private LayeredBackPressedCallback? _layeredBackPressedCallback;

    protected override void OnCreate(Bundle? savedInstanceState)
    {
        base.OnCreate(savedInstanceState);
        _layeredBackPressedCallback = new LayeredBackPressedCallback(this);
        OnBackPressedDispatcher.AddCallback(this, _layeredBackPressedCallback);
    }

    private sealed class LayeredBackPressedCallback(MainActivity activity)
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
