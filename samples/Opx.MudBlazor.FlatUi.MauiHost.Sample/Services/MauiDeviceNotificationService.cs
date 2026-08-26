// Copyright (c) 2026 opx. All rights reserved.

using Opx.MudBlazor.FlatUi.Models;
using Opx.MudBlazor.FlatUi.Services;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;

public sealed class MauiDeviceNotificationService : IDeviceNotificationService
{
    public async ValueTask<FlatDeviceNotificationStatus> ShowAsync(
        FlatDeviceNotificationRequest notification,
        CancellationToken cancellationToken = default)
    {
        cancellationToken.ThrowIfCancellationRequested();

#if ANDROID
        try
        {
            var permission = await Permissions.CheckStatusAsync<Permissions.PostNotifications>();
            if (permission != PermissionStatus.Granted)
                permission = await Permissions.RequestAsync<Permissions.PostNotifications>();

            if (permission != PermissionStatus.Granted)
                return FlatDeviceNotificationStatus.PermissionDenied;

            cancellationToken.ThrowIfCancellationRequested();
            return ShowAndroidNotification(notification);
        }
        catch (OperationCanceledException)
        {
            throw;
        }
        catch
        {
            return FlatDeviceNotificationStatus.Failed;
        }
#else
        await Task.CompletedTask;
        return FlatDeviceNotificationStatus.Unsupported;
#endif
    }

#if ANDROID
    private static FlatDeviceNotificationStatus ShowAndroidNotification(FlatDeviceNotificationRequest notification)
    {
        const string channelId = "opx-flat-ui-local";
        const string channelName = "OPX Flat UI local notifications";
        var context = global::Android.App.Application.Context;
        var manager = global::AndroidX.Core.App.NotificationManagerCompat.From(context);
        if (manager is null)
            return FlatDeviceNotificationStatus.Failed;

        if (!manager.AreNotificationsEnabled())
            return FlatDeviceNotificationStatus.PermissionDenied;

        if (OperatingSystem.IsAndroidVersionAtLeast(26))
        {
            var channel = new global::Android.App.NotificationChannel(
                channelId,
                channelName,
                global::Android.App.NotificationImportance.Default)
            {
                Description = "Local notifications initiated by the OPX Flat UI MAUI host."
            };
            manager.CreateNotificationChannel(channel);

            var platformManager = context.GetSystemService(global::Android.Content.Context.NotificationService)
                as global::Android.App.NotificationManager;
            if (platformManager?.GetNotificationChannel(channelId)?.Importance
                == global::Android.App.NotificationImportance.None)
            {
                return FlatDeviceNotificationStatus.PermissionDenied;
            }
        }

        var builder = new global::AndroidX.Core.App.NotificationCompat.Builder(context, channelId);
        builder.SetSmallIcon(Resource.Drawable.opx_notification);
        builder.SetContentTitle(notification.Title);
        builder.SetContentText(notification.Message);
        var expandedText = new global::AndroidX.Core.App.NotificationCompat.BigTextStyle();
        expandedText.BigText(notification.Message);
        builder.SetStyle(expandedText);
        builder.SetPriority(global::AndroidX.Core.App.NotificationCompat.PriorityDefault);
        builder.SetAutoCancel(true);

        var notificationId = string.IsNullOrWhiteSpace(notification.Tag)
            ? Environment.TickCount & int.MaxValue
            : StringComparer.Ordinal.GetHashCode(notification.Tag) & int.MaxValue;
        var builtNotification = builder.Build();
        if (builtNotification is null)
            return FlatDeviceNotificationStatus.Failed;

        manager.Notify(notificationId, builtNotification);
        return FlatDeviceNotificationStatus.Shown;
    }
#endif
}
