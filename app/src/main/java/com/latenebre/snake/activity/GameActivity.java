package com.latenebre.snake.activity;

import com.latenebre.snake.util.U;
import com.latenebre.snake.view.GameView;

import android.app.Activity;
import android.graphics.Point;
import android.os.Bundle;
import android.view.Display;

/**
 * Created by luke on 24.01.15.
 */
public class GameActivity extends Activity {

    GameView gameView;

    private Point getDimension() {
        Display display = getWindowManager().getDefaultDisplay();
        Point size = new Point();
        display.getRealSize(size);
        return size;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Point dimension = getDimension();
        gameView = new GameView(this, dimension.x, dimension.y);
        setContentView(gameView);
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        U.setImmersive(hasFocus, this);
    }
}