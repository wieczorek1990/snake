package com.latenebre.snake.util;

import android.app.Activity;
import android.util.Log;
import android.view.View;

/**
 * Created by luke on 25.01.15.
 */
public class U {

    public static void v(String message) {
        Log.v("luke", message);
    }

    public static void setImmersive(boolean hasFocus, Activity activity) {
        if (hasFocus) {
            activity.getWindow().getDecorView().setSystemUiVisibility(
                    View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                            | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                            | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                            | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                            | View.SYSTEM_UI_FLAG_FULLSCREEN
                            | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);
        }
    }
}