package com.latenebre.snake.model;

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
        x = segment.getX() + dx;
        y = segment.getY() + dy;
    }
}