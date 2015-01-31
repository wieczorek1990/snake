package com.latenebre.snake.model;

import com.latenebre.snake.util.U;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by luke on 24.01.15.
 */
public class Snake {
    List<Segment> segments;

    public Snake() {
        segments = new ArrayList<>();
        segments.add(new Segment(1, 1));
    }

    public void moveToNext(Direction direction) {
        U.d("move to next");
        int dx = 0, dy = 0;
        switch (direction) {
            case UP:
                dy = 1;
                break;
            case DOWN:
                dy = -1;
                break;
            case LEFT:
                dx = -1;
                break;
            case RIGHT:
                dx = 1;
                break;
            default:
                throw new IllegalArgumentException("Wrong direction");
        }
        Segment firstSegment = segments.get(0);
        Segment lastSegment = segments.get(segments.size() - 1);
        U.d("first, x: " + firstSegment.getX() + " y: " + firstSegment.getY());
        U.d("last, x: " + lastSegment.getX() + " y: " + lastSegment.getY());
        lastSegment.moveToNext(firstSegment, dx, dy);
        U.d("first, x: " + firstSegment.getX() + " y: " + firstSegment.getY());
        U.d("last, x: " + lastSegment.getX() + " y: " + lastSegment.getY());
    }

    public List<Segment> getSegments() {
        return segments;
    }

    public void addSegment(FutureSegment futureSegment) {
        segments.add(new Segment(futureSegment));
    }

    public int size() {
        return segments.size();
    }
}