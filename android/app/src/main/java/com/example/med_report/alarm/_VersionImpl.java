package com.example.med_report.alarm;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.media.AudioAttributes;
import android.net.Uri;
import android.os.Build;
import android.widget.RemoteViews;

import androidx.annotation.RequiresApi;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;

import com.example.med_report.Main;
import com.example.med_report.R;

import static android.content.ContentResolver.SCHEME_ANDROID_RESOURCE;

@SuppressWarnings({"StatementWithEmptyBody", "FieldCanBeLocal"})
public class _VersionImpl implements _Version {
    /*
     *
     */
    private static final CharSequence notificationName = "Treatment Alarm";
    /*
     *
     */
    private final int requestFlag = PendingIntent.FLAG_UPDATE_CURRENT;
    /*
     *
     */
    private final int buildVersion = Build.VERSION.SDK_INT;
    /*
     *
     */
    private final String notificationId;
    /*
     *
     */
    private static final int requestId = 10;
    /*
     *.
     */
    private final Context context;
    /*
     *
     */
    private final Uri sound;

    public _VersionImpl(Context context, String notificationId) {
        this.context = context;
        this.notificationId = notificationId;
        sound = Uri.parse(SCHEME_ANDROID_RESOURCE +
                "://" + context.getPackageName() + "/" + R.raw.a_long_cold_sting);
    }

    public static _VersionImpl getInstance(Context context, String notificationId) {
        return new _VersionImpl(context, notificationId);
    }


    @Override
    public void from_v16() {
        /*
         *
         */
        int vMax = Build.VERSION_CODES.O;
        /*
         *
         */
        int v16 = Build.VERSION_CODES.JELLY_BEAN;
        /*
         *
         */
        if (buildVersion >= v16 && buildVersion < vMax) {

        }

    }

    @Override
    public void from_v26() {
        /*
         *
         */
        int vMax = Build.VERSION_CODES.Q;
        /*
         *
         */
        int v26 = Build.VERSION_CODES.O;
        /*
         *
         */
        if (buildVersion >= v26 && buildVersion < vMax) {
            Intent fullScreenIntent = new Intent(context, Main.class);
            fullScreenIntent.putExtra("route", "/alarm");
            context.startActivity(fullScreenIntent);
        }

    }

    @Override
    public void from_v29() {
        /*
         *
         */
        int v29 = Build.VERSION_CODES.Q;
        /*
         *
         */
        if (buildVersion >= v29) {
//            Intent fullScreenIntent = new Intent(context, Main.class);
//            fullScreenIntent.setFlags(
//                    Intent.FLAG_ACTIVITY_NEW_TASK |
//                            Intent.FLAG_ACTIVITY_NO_USER_ACTION |
//                            Intent.FLAG_ACTIVITY_SINGLE_TOP
//            );
//            fullScreenIntent.putExtra("route", "/alarm");

            /*
             *
             */
            PendingIntent fullScreenPendingIntent = PendingIntent.getActivity(
                context,
                requestId,
                new Intent(),
                requestFlag
            );

            /*
             *
             */
            createNotificationChannel();

            /*
             * Remote-View
             */
            RemoteViews notificationView = new RemoteViews(context.getPackageName(), R.layout.notification_layout);
            notificationView.setOnClickPendingIntent(R.id.dismiss, onDismiss());
            notificationView.setOnClickPendingIntent(R.id.snooze, onSnooze());
            /*
             *
             */
            NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(context, notificationId);
            notificationBuilder.setStyle(new NotificationCompat.DecoratedCustomViewStyle());
            notificationBuilder.setFullScreenIntent(fullScreenPendingIntent, true);
            notificationBuilder.setCategory(NotificationCompat.CATEGORY_ALARM);
            notificationBuilder.setPriority(NotificationCompat.PRIORITY_MAX);
            notificationBuilder.setCustomContentView(notificationView);
            notificationBuilder.setSmallIcon(R.drawable.app_icon);

            /*
             *
             */
            Notification alarmNotification = notificationBuilder.build();
            alarmNotification.flags |= Notification.FLAG_ONGOING_EVENT;
            alarmNotification.flags |= Notification.FLAG_INSISTENT;
            alarmNotification.flags |= Notification.FLAG_NO_CLEAR;

            /*
             *
             */
            NotificationManagerCompat.from(context).notify(requestId, alarmNotification);

        }

    }

    public static int getNotificationId() {
        return requestId;
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    private void createNotificationChannel() {
        NotificationManagerCompat notificationManager = NotificationManagerCompat.from(context);
        if (notificationManager.getNotificationChannel(notificationId) == null) {
            /*
             *
             */
            NotificationChannel notificationChannel = new NotificationChannel(
                    notificationId,
                    notificationName,
                    NotificationManager.IMPORTANCE_HIGH
            );

            /*
             *
             */
            AudioAttributes.Builder attributeBuilder = new AudioAttributes.Builder();
            attributeBuilder.setUsage(AudioAttributes.USAGE_NOTIFICATION);

            /*
             *
             */
            notificationChannel.shouldVibrate();
            notificationChannel.setSound(sound, attributeBuilder.build());
            notificationManager.createNotificationChannel(notificationChannel);

        }

    }

    private PendingIntent onSnooze() {
        Intent intent = new Intent(context, _Snooze.class);
        return PendingIntent.getBroadcast(context, 2, intent, 0);
    }

    private PendingIntent onDismiss() {
        Intent intent = new Intent(context, _Dismiss.class);
        return PendingIntent.getBroadcast(context, 1, intent, 0);
    }

}
