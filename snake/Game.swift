// Game.swift
import Foundation

final class Game {
    // Example state
    var running: Bool = true
    private var accumulator: TimeInterval = 0
    private let fixedStep: TimeInterval = 0.12 // 120 ms per game step (tune as needed)

    // Your existing references
    public var snake: Snake
    public var apple: Apple
    public var border: Border

    init(_ snake: Snake, _ apple: Apple, _ border: Border) {
        self.snake = snake
        self.apple = apple
        self.border = border
    }

    func setDirection(_ direction: Direction) {
        // Update the snake’s intended direction, with your own rules about reversals
        snake.direction = direction
    }

    // Call this from your view each tick, passing the elapsed time since last tick.
    func run(deltaTime dt: TimeInterval) {
        guard running else { return }

        // Clamp dt to avoid “teleporting” after stalls (e.g., 100ms max)
        let clampedDT = min(dt, 0.1)

        // Option A: Fixed-step simulation using an accumulator for consistent speed
        accumulator += clampedDT
        while accumulator >= fixedStep {
            stepOnce()
            accumulator -= fixedStep
        }

        // Option B (alternative): Variable-step simulation
        // stepVariable(dt: clampedDT)
    }

    // One fixed simulation step (advance the game by exactly fixedStep)
    private func stepOnce() {
        // Advance snake one cell, check collisions, maybe move apple, etc.
        snake.advance()
        if snake.headIntersects(apple) {
            snake.grow()
            apple.respawn(avoiding: snake, within: border)
        }
        if border.containsCollision(with: snake) || snake.selfCollision() {
            running = false
        }
    }

    // If you prefer variable-step movement (not typical for grid games):
    private func stepVariable(dt: TimeInterval) {
        // Move based on dt (e.g., accumulate distance and move when >= 1 cell)
        // This is usually less ideal for grid-based games like Snake.
    }
}
