package com.latenebre.snake.model;

import com.latenebre.snake.util.U;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.Future;

/**
 * Created by luke on 24.01.15.
 */
public class Game {
    Direction direction;
    Direction futureDirection;
    Snake snake;
    Collectable collectable;
    List<FutureSegment> futureSegments;
    Random random;
    int maxX, maxY;

    public Game(int maxX, int maxY) {
        this.maxX = maxX;
        this.maxY = maxY;
        snake = new Snake();
        direction = Direction.UP;
        futureDirection = Direction.UP;
        random = new Random();
        futureSegments = new ArrayList<>();
        generateRandomCollectable();
    }

    public Direction getDirection() {
        return direction;
    }

    public void scheduleDirectionChange(Direction direction) {
        this.futureDirection = direction;
    }

    // TODO
    public void step() {
        for (FutureSegment futureSegment : futureSegments) {
            futureSegment.step();
            if (futureSegment.readyToAdd()) {
                snake.addSegment(futureSegment);
                futureSegments.remove(futureSegment);
                break;
            }
        }
        direction = futureDirection;
        snake.moveToNext(direction);
        if (snake.getSegments().get(0).equals(collectable)) {
            futureSegments.add(new FutureSegment(collectable, snake.size()));
            generateRandomCollectable();
        }
    }

    private void generateRandomCollectable() {
        do {
            int x = random.nextInt(maxX);
            int y = random.nextInt(maxY);
            collectable = new Collectable(x, y);
        } while (snake.collides(collectable));
    }

    public List<Segment> getSegments() {
        return snake.getSegments();
    }

    public Collectable getCollectable() {
        return collectable;
    }
}