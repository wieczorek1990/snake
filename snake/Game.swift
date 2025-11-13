class Game {
    var snake: Snake
    var apple: Apple
    var border: Border
    var running: Bool
    var direction: Direction

    init(
        _ snake: Snake,
        _ apple: Apple,
        _ border: Border,
        _ direction: Direction = .right
    ) {
        self.snake = snake
        self.apple = apple
        self.border = border
        self.running = true
        self.direction = direction
    }

    func setDirection(_ direction: Direction) {
        if direction != self.direction.opposite() {
            self.direction = direction
        }
    }

    func run() {
        if !running {
            return
        }
        let crashed = move(direction)
        if crashed {
            running = false
            return
        }
        eat()
    }

    func move(_ direction: Direction) -> Bool {
        if snake.touchedBorder(border, direction) {
            return true
        } else if snake.touchedSelf() {
            return true
        }

        snake.move(direction)

        return false
    }

    func eat() {
        if snake.head.x == apple.x && snake.head.y == apple.y {
            snake.append()
            apple = Apple()
        }
    }
}
