package com.latenebre.snake.controller;

import android.graphics.RectF;

import com.latenebre.snake.model.Direction;
import com.latenebre.snake.model.Game;
import com.latenebre.snake.model.Point;
import com.latenebre.snake.model.Segment;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by luke on 24.01.15.
 */
public class GameController {
    Game game;
    float screenWidth;
    float screenHeight;
    float squareSize;

    public GameController(int screenWidth, int screenHeight) {
        this.screenWidth = screenWidth;
        this.screenHeight = screenHeight;
        this.squareSize = screenWidth > screenHeight ? screenWidth / 16f : screenHeight / 16f;
        this.game = new Game((int) (screenWidth / squareSize), (int) (screenHeight / squareSize));
    }

    public void touchDown(float x, float y) {
        Direction currentDirection = game.getDirection();
        Direction newDirection;
        switch (currentDirection) {
            case UP:
            case DOWN:
                if (x < screenWidth / 2f) {
                    newDirection = Direction.LEFT;
                } else {
                    newDirection = Direction.RIGHT;
                }
                break;
            case LEFT:
            case RIGHT:
                if (y < screenHeight / 2f) {
                    newDirection = Direction.DOWN;
                } else {
                    newDirection = Direction.UP;
                }
                break;
            default:
                throw new IllegalArgumentException("Wrong direction");
        }
        game.setDirection(newDirection);
    }

    public List<RectF> getRectangles() {
        List<RectF> rectangles = new ArrayList<RectF>();

        List<Point> points = new ArrayList<Point>();
        points.addAll(game.getSegments());
        points.add(game.getCollectable());
        for (Point point : points) {
            float left, top, right, bottom;
            left = point.getX() * squareSize;
            top = point.getY() * squareSize;
            right = left + squareSize;
            bottom = top + squareSize;
            rectangles.add(new RectF(left, top, right, bottom));
        }

        return rectangles;
    }

    public void step() {
        game.step();
    }

    public Direction getDirection() {
        return game.getDirection();
    }
}