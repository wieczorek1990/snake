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
        // Zapamiętaj kierunki PRZED zmianą
        let previousDirections = parts.map { $0.lastDirection }

        // Głowa przyjmuje nowy kierunek
        head.lastDirection = direction

        // Każda część ciała przejmuje kierunek swojego poprzednika
        // (część o indeksie i przejmuje kierunek części i-1 z poprzedniego kroku)
        for i in 1..<parts.count {
            parts[i].lastDirection = previousDirections[i - 1]
        }

        // Przesuń wszystkie części zgodnie z ich kierunkiem
        for part in parts {
            part.advancePlain()
        }
    }

    func append() {
        let back = parts.last!
        let part = SnakeTail(
            x: back.x,
            y: back.y,
            lastDirection: back.lastDirection
        )
        parts.append(part)
    }

    func advance() {
        move(direction)
    }

    func grow() {
        // Dodaj segment na końcu — pojawi się na pozycji ostatniego
        // segmentu przed ruchem, więc nie nakłada się na resztę ciała.
        append()
    }

    func selfCollision() -> Bool {
        // Sprawdzamy tylko głowę względem reszty ciała
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
