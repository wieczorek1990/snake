package com.latenebre.snake.model;

import com.latenebre.snake.util.U;

/**
 * Created by luke on 24.01.15.
 */
public class Segment extends Point {
    public Segment(int x, int y) {
        super(x, y);
    }

    public Segment(FutureSegment point) {
        super(point);
    }

    public void moveToNext(Segment segment, int dx, int dy) {
        U.d("dx: " + dx + " dy: " + dy);
        U.d("before x: " + x + " y: " + y);
        x = segment.getX() + dx;
        y = segment.getY() + dy;
        U.d("after x: " + x + " y: " + y);
    }
}