package com.example.med_report;

import android.os.Bundle;
import java.util.Objects;
import android.view.WindowManager;
import android.annotation.SuppressLint;
import android.content.SharedPreferences;
import com.example.med_report.alarm.AlarmChannel;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import androidx.core.view.accessibility.AccessibilityEventCompat;

public class Main extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(
            Objects.requireNonNull(getFlutterEngine())
        );

        /*
         *
         */
        getWindow().addFlags(
            WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED |
            WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON |
            WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON |
            AccessibilityEventCompat.TYPE_WINDOWS_CHANGED
        );

        /*
        * Register </flutter> Method Channel Handler
        */
        AlarmChannel.registerChannel(getApplicationContext(), getFlutterEngine());
    }

}
