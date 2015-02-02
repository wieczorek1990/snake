package com.latenebre.snake.model;

/**
 * Created by luke on 25.01.15.
 */
public class Point {

    int x;

    int y;

    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public Point(Point point) {
        this.x = point.x;
        this.y = point.y;
    }

    public Point(FutureSegment futureSegment) {
        this.x = futureSegment.getCollectable().getX();
        this.y = futureSegment.getCollectable().getY();
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    @Override
    public boolean equals(Object o) {
        return x == ((Point) o).x && y == ((Point) o).y;
    }

    @Override
    public String toString() {
        return "(" + x + ", " + y + ")";
    }
}