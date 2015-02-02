package com.latenebre.snake.activity;

import com.latenebre.snake.R;
import com.latenebre.snake.model.Highscores;
import com.latenebre.snake.util.U;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class HighscoresActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_highscores);
        findViewById(R.id.highscores_ll_highscores).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        Highscores highscores = new Highscores();
//        highscores.clear(this);
        highscores.load(this);
        TextView textView = (TextView) findViewById(R.id.highscores_tv_highscores);
        textView.setText(highscores.toString());
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        U.setImmersive(hasFocus, this);
    }
}