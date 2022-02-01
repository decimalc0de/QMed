package com.example.med_report.alarm;

import java.util.List;
import java.util.Calendar;
import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;

import static android.app.PendingIntent.FLAG_UPDATE_CURRENT;
import static android.content.Context.ALARM_SERVICE;

public class AlarmWorker {
    /*
     * Application Context
     */
    private final Context context;

    /*
     * Init Alarm Manager
     */
    private final AlarmManager alarmManager;

    /*
     * Pending-Intent Request code
     */
    private static final int REQUEST_CODE = 234324243;

    public AlarmWorker(Context context) {
        this.context = context;
        alarmManager = getManager();
    }

    /*
     * Start alarm schedule
     */
    public void startAlarmScheduler(int interval) {
        //
        int runAlarmAtInterval = 60 * 1000 * interval;

        //
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MILLISECOND, runAlarmAtInterval);

        //
        long startAlarmAt = cal.getTimeInMillis();

        //
        Intent intent = new Intent(context, AlarmReceiver.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);

        //
        PendingIntent pendingIntent = PendingIntent.getBroadcast(
            context, REQUEST_CODE, intent, FLAG_UPDATE_CURRENT
        );

        //
        alarmManager.setRepeating(
            AlarmManager.RTC_WAKEUP, startAlarmAt, runAlarmAtInterval, pendingIntent
        );

    }

    public AlarmWorker setAllAlarms(List<String> alarmClocks) {
        return this;
    }

    private AlarmManager getManager(){
        return (AlarmManager) context.getSystemService(ALARM_SERVICE);
    }

}