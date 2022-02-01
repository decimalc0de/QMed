package com.example.med_report.alarm;

import android.content.Context;
import android.content.Intent;
import android.content.BroadcastReceiver;


public class AlarmReceiver extends BroadcastReceiver {
    /*
     *
     */
    public static final String notificationId = "Treatment Alarm Ui";

    @Override
    public void onReceive(Context context, Intent _intent) {
        _VersionImpl.getInstance(context, notificationId).initImpl();
    }

}
