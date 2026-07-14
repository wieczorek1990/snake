class Border {
    var borderSquares: [BorderSquare]

    init() {
        let xMax = SQUARE_COUNT * X_TO_Y_RATIO
        let yMax = SQUARE_COUNT

        var squares: [BorderSquare] = []

        // Lewa ściana (x = 0)
        for y in 0..<yMax {
            squares.append(BorderSquare(x: 0, y: y))
        }

        // Prawa ściana (x = xMax - 1)
        for y in 0..<yMax {
            squares.append(BorderSquare(x: xMax - 1, y: y))
        }

        // Górna ściana (y = 0) — bez rogów (te już są z lewej i prawej)
        for x in 1..<(xMax - 1) {
            squares.append(BorderSquare(x: x, y: 0))
        }

        // Dolna ściana (y = yMax - 1) — bez rogów
        for x in 1..<(xMax - 1) {
            squares.append(BorderSquare(x: x, y: yMax - 1))
        }

        borderSquares = squares
    }

    func containsCollision(with snake: Snake) -> Bool {
        let hx = snake.head.x
        let hy = snake.head.y
        for bs in borderSquares {
            if bs.x == hx && bs.y == hy {
                return true
            }
        }
        return false
    }
}
