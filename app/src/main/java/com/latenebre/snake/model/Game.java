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
        random = new Random();
        futureSegments = new ArrayList<>();
        generateRandomCollectable();
    }

    public Direction getDirection() {
        return direction;
    }

    public void setDirection(Direction direction) {
        this.direction = direction;
    }

    // TODO
    public void step() {
        for (FutureSegment futureSegment : futureSegments) {
            futureSegment.step();
            U.d("x: " + futureSegment.getCollectable().getX() +
            " y: " + futureSegment.getCollectable().getY() +
            " pos: " + futureSegment.getPosition());
            if (futureSegment.getPosition() == snake.size()) {
                U.d("segment added");
                snake.addSegment(futureSegment);
                futureSegments.remove(futureSegment);
                break;
            }
        }
        snake.moveToNext(direction);
        if (snake.getSegments().get(0).equals(collectable)) {
            U.d("collectable");
            futureSegments.add(new FutureSegment(collectable));
            generateRandomCollectable();
        }
    }

    private void generateRandomCollectable() {
        int x = random.nextInt(maxX);
        int y = random.nextInt(maxY);
        collectable = new Collectable(x, y);
    }

    public List<Segment> getSegments() {
        return snake.getSegments();
    }

    public Collectable getCollectable() {
        return collectable;
    }
}