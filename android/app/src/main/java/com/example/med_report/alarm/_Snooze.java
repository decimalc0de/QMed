package com.example.med_report.alarm;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.Toast;

import androidx.core.app.NotificationManagerCompat;

public class _Snooze extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        Toast.makeText(context, "Alarm Snoozed", Toast.LENGTH_LONG).show();
        /*
         * TODO: snooze Impl
         */
        NotificationManagerCompat.from(context).cancel(_VersionImpl.getNotificationId());
    }
}
