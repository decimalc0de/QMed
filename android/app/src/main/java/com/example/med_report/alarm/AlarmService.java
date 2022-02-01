package com.example.med_report.alarm;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import com.example.med_report.Main;
import com.example.med_report.R;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.os.IBinder;

public class AlarmService extends Service {
    /*
     *
     */
    public static final int requestFlag = 0;
    /*
     *
     */
    public static final int notificationId = 9;
    /*
     *
     */
    public static final String CHANNEL_NAME = "Treatment Notification";

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        /*
         * Intent
         */
        Intent notificationIntent = new Intent(this, Main.class);

        /*
         * Pending-Intent
         */
        PendingIntent pendingIntent = PendingIntent.getActivity(
            this,
            notificationId,
            notificationIntent,
            requestFlag
        );

        /*
         * For Build.VERSION.SDK_INT >= Build.VERSION_CODES.O
         */
        createNotificationChannel();

        /*
         * Init Notification
         */
        NotificationCompat.Builder notification = new NotificationCompat.Builder(this, CHANNEL_NAME);
        notification.setSmallIcon(R.drawable.app_icon);
        notification.setContentIntent(pendingIntent);

        /*
         * Start foreground-service
         */
        startForeground(1, notification.build());

        /*
         * do heavy work on a background thread
         */

        AlarmWorker alarm = new AlarmWorker(getApplicationContext());
        /*
         * Get interval in minutes
         */
        int interval = intent.getIntExtra("interval", 0);
        /*
         * Start alarm
         */
        alarm.startAlarmScheduler(interval);

        return START_STICKY;
    }

    /*
     * For Build.VERSION.SDK_INT >= Build.VERSION_CODES.O
     */
    private void createNotificationChannel() {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            NotificationManagerCompat notificationManager = NotificationManagerCompat.from(this);
            if(notificationManager.getNotificationChannel(CHANNEL_NAME) == null) {
                NotificationChannel notificationChannel = new NotificationChannel(
                    CHANNEL_NAME,
                    CHANNEL_NAME,
                    NotificationManager.IMPORTANCE_DEFAULT
                );
                notificationManager.createNotificationChannel(notificationChannel);
            }
        }
    }

    @Nullable @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

}