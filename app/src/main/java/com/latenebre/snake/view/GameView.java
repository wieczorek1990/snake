package com.latenebre.snake.view;

import com.latenebre.snake.controller.GameController;
import com.latenebre.snake.model.Direction;

import android.app.Activity;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.DashPathEffect;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.view.MotionEvent;
import android.view.View;

import java.util.List;

/**
 * Created by luke on 24.01.15.
 */
public class GameView extends View {

    static final int FPS = 3;

    private static final float STROKE_WIDTH = 8f;

    private final Rect textBounds = new Rect();

    GameController gameController;

    Paint paintDefault;

    Paint paintSecondary;

    Paint paintSecondaryBold;

    Paint paintText;

    long lastOnDrawTime;

    int screenWidth;

    int screenHeight;

    boolean isEnded;

    boolean isEndedTouchDownSetUp;

    public GameView(Context context, int width, int height) {
        super(context);
        this.setLayerType(View.LAYER_TYPE_SOFTWARE, null);
        this.screenWidth = width;
        this.screenHeight = height;
        this.gameController = new GameController(width, height);
        this.setOnTouchListener(new OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                if (event.getAction() == MotionEvent.ACTION_DOWN) {
                    float x = event.getX();
                    float y = event.getY();
                    gameController.touchDown(x, y);
                }
                return true;
            }
        });
        this.paintDefault = new Paint();
        this.paintDefault.setColor(Color.BLACK);
        this.paintSecondary = new Paint();
        this.paintSecondary.setStrokeWidth(STROKE_WIDTH);
        this.paintSecondary.setColor(Color.RED);
        this.paintSecondary.setPathEffect(new DashPathEffect(new float[]{32, 32}, 5));
        this.paintSecondaryBold = new Paint(paintSecondary);
        this.paintSecondaryBold.setStrokeWidth(paintSecondaryBold.getStrokeWidth() * 2f);
        this.paintText = new Paint();
        this.paintText.setColor(Color.BLACK);
        this.paintText.setStyle(Paint.Style.FILL);
        this.paintText.setTextSize(256);
        this.lastOnDrawTime = -1;
        this.isEnded = false;
        this.isEndedTouchDownSetUp = false;
    }

    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);

        long elapsedTime, nowTime;
        nowTime = System.currentTimeMillis();
        if (lastOnDrawTime != -1) {
            elapsedTime = nowTime - lastOnDrawTime;
        } else {
            elapsedTime = 0;
            lastOnDrawTime = nowTime;
        }
        if (elapsedTime > 1000f / FPS) {
            lastOnDrawTime = nowTime;
            isEnded = gameController.step();
        }

        // Border
        canvas.drawLine(0f, 0f, screenWidth, 0f, paintSecondaryBold);
        canvas.drawLine(screenWidth, 0f, screenWidth, screenHeight, paintSecondaryBold);
        canvas.drawLine(screenWidth, screenHeight, 0f, screenHeight, paintSecondaryBold);
        canvas.drawLine(0f, screenHeight, 0f, 0f, paintSecondaryBold);

        // Direction help lines
        Direction direction = gameController.getDirection();
        switch (direction) {
            case UP:
            case DOWN:
                float x = screenWidth / 2f;
                canvas.drawLine(x, 0f, x, screenHeight, paintSecondary);
                break;
            case LEFT:
            case RIGHT:
                float y = screenHeight / 2f;
                canvas.drawLine(0f, y, screenWidth, y, paintSecondary);
                break;
            default:
                throw new IllegalArgumentException("Wrong direction");
        }

        // Snake
        List<RectF> rectangles = gameController.getRectangles();
        for (RectF rectF : rectangles) {
            canvas.drawRect(rectF, paintDefault);
        }

        if (isEnded) {
            String end = "End.";
            String points = "Score: " + gameController.getPoints();
            int width = screenWidth / 2;
            int height = screenHeight / 2;
            float lineHeight = getLineHeight(paintText);
            drawTextCentred(canvas, end, width, height - lineHeight / 2);
            drawTextCentred(canvas, points, width, height + lineHeight / 2);
            if (!isEndedTouchDownSetUp) {
                isEndedTouchDownSetUp = true;
                this.setOnTouchListener(new OnTouchListener() {
                    @Override
                    public boolean onTouch(View v, MotionEvent event) {
                        ((Activity) getContext()).finish();
                        return true;
                    }
                });
            }
        }

        invalidate();
    }

    private float getLineHeight(Paint paint) {
        return paint.descent() - paint.ascent();
    }

    public void drawTextCentred(Canvas canvas, String text, float cx, float cy) {
        paintText.getTextBounds(text, 0, text.length(), textBounds);
        canvas.drawText(text, cx - textBounds.exactCenterX(), cy - textBounds.exactCenterY(),
                paintText);
    }
}