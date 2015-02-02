package com.latenebre.snake.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by luke on 24.01.15.
 */
public class Snake {

    List<Segment> segments;

    private Segment redHead;

    public Snake() {
        segments = new ArrayList<>();
        segments.add(new Segment(1, 1));
    }

    public Segment getRedHead() {
        return redHead;
    }

    public void setRedHead(Segment redHead) {
        this.redHead = redHead;
    }

    public Segment getNext(Direction direction) {
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
        return Segment.move(getFirstSegment(), dx, dy);
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

    public boolean collides(Point point) {
        for (Segment segment : segments) {
            if (segment.equals(point)) {
                return true;
            }
        }
        return false;
    }

    public boolean eaten(Collectable collectable) {
        return getFirstSegment().equals(collectable);
    }

    public Segment getFirstSegment() {
        return segments.get(0);
    }

    public void move(Segment head) {
        segments.remove(segments.size() - 1);
        segments.add(0, head);
    }
}