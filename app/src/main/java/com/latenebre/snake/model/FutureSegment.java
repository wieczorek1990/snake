package com.latenebre.snake.model;

/**
 * Created by luke on 25.01.15.
 */
public class FutureSegment {
    Collectable collectable;
    int position;

    public FutureSegment(Collectable collectable) {
        this.collectable = collectable;
        this.position = 0;
    }

    public Collectable getCollectable() {
        return collectable;
    }

    public int getPosition() {
        return position;
    }

    public void step() {
        position += 1;
    }
}