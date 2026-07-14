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
        // ❗ Blokada odwracania o 180°
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
        // Oblicz następną pozycję głowy
        let nextHead = Square.ahead(snake.head, snake.direction)

        // Sprawdź kolizję ze ścianą PRZED ruchem
        for bs in border.borderSquares {
            if bs.x == nextHead.x && bs.y == nextHead.y {
                running = false
                return
            }
        }

        // Sprawdź kolizję z ciałem PRZED ruchem
        // (pomijamy ostatni segment ogona — on przesunie się dalej)
        for part in snake.parts.dropLast() {
            if part.x == nextHead.x && part.y == nextHead.y {
                running = false
                return
            }
        }

        // Dopiero teraz wykonaj ruch
        snake.advance()

        if snake.headIntersects(apple) {
            snake.grow()
            apple.respawn(avoiding: snake, within: border)
        }
    }
}
