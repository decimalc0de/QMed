package com.example.med_report.alarm;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.Toast;

import androidx.core.app.NotificationManagerCompat;

public class _Dismiss extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        Toast.makeText(context, "Alarm dismissed", Toast.LENGTH_LONG).show();
        NotificationManagerCompat.from(context).cancel(_VersionImpl.getNotificationId());
    }
}
