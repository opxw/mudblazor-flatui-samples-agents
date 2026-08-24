using System.ComponentModel;
using System.Runtime.CompilerServices;
using CommunityToolkit.Maui.Core;
using Microsoft.JSInterop;
using Opx.MudBlazor.FlatUi.Models;

namespace Opx.MudBlazor.FlatUi.Maui.Template;

public sealed class MobileThemeBridge : INotifyPropertyChanged
{
    private Color _appBarColor = Colors.White;
    private StatusBarStyle _statusBarStyle = StatusBarStyle.DarkContent;
    private bool _isDarkMode;

    public event PropertyChangedEventHandler? PropertyChanged;

    public Color AppBarColor
    {
        get => _appBarColor;
        private set => SetField(ref _appBarColor, value);
    }

    public StatusBarStyle StatusBarStyle
    {
        get => _statusBarStyle;
        private set => SetField(ref _statusBarStyle, value);
    }

    public bool IsDarkMode
    {
        get => _isDarkMode;
        private set => SetField(ref _isDarkMode, value);
    }

    public async ValueTask ApplyAsync(string themeMode, IJSRuntime js, bool? systemPrefersDark = null)
    {
        var normalized = FlatUiThemeMode.Normalize(themeMode);
        var prefersDark = systemPrefersDark
            ?? (normalized == FlatUiThemeMode.Auto
                && await js.InvokeAsync<bool>("opxFlatTheme.prefersDarkMode"));
        var dark = normalized == FlatUiThemeMode.Dark
            || (normalized == FlatUiThemeMode.Auto && prefersDark);

        await MainThread.InvokeOnMainThreadAsync(() =>
        {
            IsDarkMode = dark;
            AppBarColor = Color.FromArgb(dark ? "#111111" : "#FFFFFF");
            StatusBarStyle = dark ? StatusBarStyle.LightContent : StatusBarStyle.DarkContent;
            ReapplyNativeChrome();
        });
    }

    public void ReapplyNativeChrome()
    {
        OnPropertyChanged(nameof(AppBarColor));
        OnPropertyChanged(nameof(StatusBarStyle));
    }

    private void SetField<T>(ref T field, T value, [CallerMemberName] string? propertyName = null)
    {
        if (EqualityComparer<T>.Default.Equals(field, value)) return;
        field = value;
        OnPropertyChanged(propertyName);
    }

    private void OnPropertyChanged(string? propertyName) =>
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
}
