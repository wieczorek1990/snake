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

        for index in parts.indices.dropFirst() {
            parts[index].lastDirection = previousDirections[index - 1]
        }

        for part in parts {
            part.advancePlain()
        }
    }

    func append() {
        let back = Square.backward(parts.last!, parts.last!.lastDirection)
        let part = SnakeTail(
            x: back.x,
            y: back.y,
            lastDirection: parts.last!.lastDirection
        )
        parts.append(part)
    }

    func touchedBorder(_ border: Border, _ direction: Direction) -> Bool {
        let ahead = Square.ahead(head, direction)

        if ahead.x == 0 {
            return true
        }
        if ahead.y == 0 {
            return true
        }
        if ahead.x == SQUARE_COUNT * X_TO_Y_RATIO - 1 {
            return true
        }
        if ahead.y == SQUARE_COUNT - 1 {
            return true
        }

        return false
    }

    func touchedSelf() -> Bool {
        for part in parts {
            if part !== parts.first {
                if part.x == head.x, part.y == head.y {
                    return true
                }
            }
        }
        return false
    }

    func advance() {
        move(direction)
    }

    func grow() {
        append()
    }

    func selfCollision() -> Bool {
        return touchedSelf()
    }

    func headIntersects(_ apple: Apple) -> Bool {
        return head.x == apple.x && head.y == apple.y
    }
}
