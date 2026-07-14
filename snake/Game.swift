import Foundation

final class Game {
    var running: Bool = true
    private var accumulator: TimeInterval = 0
    private let fixedStep: TimeInterval = 0.12

    public var snake: Snake
    public var apple: Apple
    public var border: Border

    init(_ snake: Snake, _ apple: Apple, _ border: Border) {
        self.snake = snake
        self.apple = apple
        self.border = border
    }

    func setDirection(_ direction: Direction) {
        // ❗ Blokada odwracania o 180° — wąż nie może skręcić w stronę,
        //    z której właśnie nadjeżdża.
        guard direction != snake.direction.opposite() else { return }
        snake.direction = direction
    }

    func run(deltaTime dt: TimeInterval) {
        guard running else { return }

        let clampedDT = min(dt, 0.1)

        accumulator += clampedDT
        while accumulator >= fixedStep {
            stepOnce()
            accumulator -= fixedStep
        }
    }

    private func stepOnce() {
        snake.advance()

        if snake.headIntersects(apple) {
            snake.grow()
            apple.respawn(avoiding: snake, within: border)
        }

        if border.containsCollision(with: snake) || snake.selfCollision() {
            running = false
        }
    }
}
