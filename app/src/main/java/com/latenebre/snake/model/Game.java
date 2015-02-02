package com.latenebre.snake.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

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

    boolean isEnded;

    int points;

    public Game(int maxX, int maxY) {
        this.maxX = maxX;
        this.maxY = maxY;
        this.snake = new Snake();
        this.direction = Direction.UP;
        this.futureDirection = Direction.UP;
        this.random = new Random();
        this.futureSegments = new ArrayList<>();
        this.isEnded = false;
        this.points = 0;

        generateRandomCollectable();
    }

    public int getPoints() {
        return points;
    }

    public Direction getDirection() {
        return direction;
    }

    public void scheduleDirectionChange(Direction direction) {
        this.futureDirection = direction;
    }

    public boolean step() {
        if (isEnded) {
            return true;
        }
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
        Segment head = snake.getFirstSegment();
        if (head.getX() < 0 || head.getX() > maxX || head.getY() < 0 || head.getY() > maxY) {
            isEnded = true;
        }
        if (snake.eaten(collectable)) {
            points += 1;
            futureSegments.add(new FutureSegment(collectable, snake.size()));
            generateRandomCollectable();
        }
        return false;
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