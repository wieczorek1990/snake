class Snake {
    var parts: [SnakePart]
    var head: SnakeHead { parts[0] as! SnakeHead }
    var direction: Direction = .right

    init() {
        parts = [
            SnakeHead(x: 3, y: 1, lastDirection: .right),
            SnakeTail(x: 2, y: 1, lastDirection: .right),
            SnakeTail(x: 1, y: 1, lastDirection: .right),
        ]
    }

    func move(_ direction: Direction) {
        let previousDirections = parts.map { $0.lastDirection }

        head.lastDirection = direction

        for i in 1..<parts.count {
            parts[i].lastDirection = previousDirections[i - 1]
        }

        for part in parts {
            part.advancePlain()
        }
    }

    func append() {
        let tail = parts.last!
        let back = Square.backward(tail, tail.lastDirection)
        let part = SnakeTail(
            x: back.x,
            y: back.y,
            lastDirection: tail.lastDirection
        )
        parts.append(part)
    }

    func advance() {
        move(direction)
    }

    func grow() {
        append()
    }

    func selfCollision() -> Bool {
        for part in parts.dropFirst() {
            if part.x == head.x, part.y == head.y {
                return true
            }
        }
        return false
    }

    func headIntersects(_ apple: Apple) -> Bool {
        return head.x == apple.x && head.y == apple.y
    }
}
