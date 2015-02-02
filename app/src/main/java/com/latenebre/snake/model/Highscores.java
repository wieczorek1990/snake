package com.latenebre.snake.model;

import com.latenebre.snake.util.U;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.Arrays;

/**
 * Created by luke on 02.02.15.
 */
public class Highscores {

    static final int COUNT = 3;

    public int[] array = new int[COUNT];

    public void update(int points) {
        int[] newArray = new int[COUNT + 1];
        for (int index = 0; index < COUNT; index++) {
            newArray[index] = array[index];
        }
        newArray[COUNT] = points;
        Arrays.sort(newArray);
        int oldIndex = 0;
        for (int index = COUNT; index > 0; index--) {
            array[oldIndex] = newArray[index];
            U.v("old: " + oldIndex + " new: " + index);
            oldIndex += 1;
        }
    }

    @Override
    public String toString() {
        String result = "";
        for (int index = 0; index < COUNT; index++) {
            result += array[index] + "\n";
        }
        return result;
    }

    public void clear(Context context) {
        SharedPreferences settings = context.getSharedPreferences("highscores", 0);
        SharedPreferences.Editor editor = settings.edit();
        editor.clear();
        editor.apply();
    }

    public void save(Context context) {
        SharedPreferences settings = context.getSharedPreferences("highscores", 0);
        SharedPreferences.Editor editor = settings.edit();
        String csv = this.toCSV();
        editor.putString("highscores", csv);
        editor.apply();
    }

    public void load(Context context) {
        SharedPreferences settings = context.getSharedPreferences("highscores", 0);
        String highscores = settings.getString("highscores", "0;0;0;");
        String[] split = highscores.split(";");
        for (int index = 0; index < split.length; index++) {
            array[index] = Integer.parseInt(split[index]);
        }
    }

    private String toCSV() {
        String result = "";
        for (int index = 0; index < COUNT; index++) {
            result += array[index] + ";";
        }
        return result;
    }
}