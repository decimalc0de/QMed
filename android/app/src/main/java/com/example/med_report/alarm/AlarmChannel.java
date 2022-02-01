package com.example.med_report.alarm;

import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;

import org.jetbrains.annotations.NotNull;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

@SuppressWarnings({"FieldCanBeLocal"})
public class AlarmChannel implements MethodCallHandler {
    /*
     *
     */
    private final Context context;
    /*
     * Constructor
     */
    public AlarmChannel(Context _context) {
        context = _context;
    }

    /*
     *
     */
    @Override
    @SuppressWarnings({"ConstantConditions", "SwitchStatementWithTooFewBranches"})
    public void onMethodCall(@NonNull @NotNull MethodCall call, @NonNull @NotNull Result result) {
        switch (call.method) {
            case "scheduleAlarm": {
                scheduleAlarm(call.argument("interval"));
            }
            break;
        }
    }

    /*
     * Start foreground-service
     */
    private void scheduleAlarm(int interval){
        //
        Intent serviceIntent = new Intent(context, AlarmService.class);
        serviceIntent.putExtra("interval", interval);
        serviceIntent.setAction("START_SERVICE");

        //
        ContextCompat.startForegroundService(context, serviceIntent);
    }

    /*
     * Register Method-Channel
     */
    private static MethodChannel channelOne;
    private static final String CHANNEL = "flutter.native/alarmManager";
    public static MethodChannel getChannel(){
        return channelOne;
    }
    public static void registerChannel(Context context, FlutterEngine flutterEngine) {
        channelOne = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        channelOne.setMethodCallHandler( new AlarmChannel(context));
    }

}
