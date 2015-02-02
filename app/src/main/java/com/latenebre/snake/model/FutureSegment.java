package com.latenebre.snake.model;

/**
 * Created by luke on 25.01.15.
 */
public class FutureSegment {

    Collectable collectable;

    int position;

    int snakeSize;

    public FutureSegment(Collectable collectable, int snakeSize) {
        this.collectable = collectable;
        this.position = 0;
        this.snakeSize = snakeSize;
    }

    public Collectable getCollectable() {
        return collectable;
    }

    public void step() {
        position += 1;
    }

    public boolean readyToAdd() {
        return position == snakeSize;
    }

}