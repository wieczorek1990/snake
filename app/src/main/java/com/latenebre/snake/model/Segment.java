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

    public static Segment move(Segment segment, int dx, int dy) {
        return new Segment(segment.getX() + dx, segment.getY() + dy);
    }
}