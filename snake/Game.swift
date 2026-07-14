import Foundation

final class Game {
    var running: Bool = true
    private var accumulator: TimeInterval = 0
    private let fixedStep: TimeInterval = 0.12

    public var snake: Snake
    public var apple: Apple
    public var border: Border
    public var filling: Filling

    init(_ snake: Snake, _ apple: Apple, _ border: Border) {
        self.snake = snake
        self.apple = apple
        self.border = border
        self.filling = Filling()
    }

    func setDirection(_ direction: Direction) {
        guard direction != snake.direction.opposite() else { return }

        snake.direction = direction
    }

    func run(deltaTime dt: TimeInterval) {
        let clampedDT = min(dt, 0.1)

        if !running {
            filling.update(deltaTime: clampedDT)
            
            return
        }

        accumulator += clampedDT
        while accumulator >= fixedStep {
            stepOnce()
            accumulator -= fixedStep
        }
    }

    private func stepOnce() {
        guard running else { return }

        let nextHead = Square.ahead(snake.head, snake.direction)

        for bs in border.borderSquares {
            if bs.x == nextHead.x && bs.y == nextHead.y {
                running = false
                return
            }
        }

        for part in snake.parts.dropLast() {
            if part.x == nextHead.x && part.y == nextHead.y {
                running = false
                return
            }
        }

        snake.advance()

        if snake.headIntersects(apple) {
            snake.grow()
            apple.respawn(avoiding: snake, within: border)
        }
    }
}
