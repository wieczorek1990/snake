class Square {
    let STEP: Int = 1

    var x: Int
    var y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    func move(_ direction: Direction) {
        switch direction {
        case .up:
            y -= STEP
        case .down:
            y += STEP
        case .left:
            x -= STEP
        case .right:
            x += STEP
        }
    }

    func moveBackward(_ direction: Direction) {
        switch direction {
        case .up:
            y += STEP
        case .down:
            y -= STEP
        case .left:
            x += STEP
        case .right:
            x -= STEP
        }
    }

    static func ahead(_ square: Square, _ direction: Direction) -> Square {
        let newSquare: Square = Square(x: square.x, y: square.y)
        newSquare.move(direction)
        return newSquare
    }

    static func backward(_ square: Square, _ direction: Direction) -> Square {
        let newSquare: Square = Square(x: square.x, y: square.y)
        newSquare.moveBackward(direction)
        return newSquare
    }
}

class Apple: Square {
    init() {
        var rng = RandomNumberGenerator.generator

        let x = rng.nextUnsignedInteger(SQUARE_COUNT - 1) + 1
        let y = rng.nextUnsignedInteger(SQUARE_COUNT - 1) + 1

        super.init(x: x, y: y)
    }

    func respawn(avoiding snake: Snake, within border: Border) {
        var rng = RandomNumberGenerator.generator

        let xMax = SQUARE_COUNT * X_TO_Y_RATIO
        let yMax = SQUARE_COUNT

        var occupied = Set<String>()
        for part in snake.parts {
            occupied.insert("\(part.x),\(part.y)")
        }

        for _ in 0..<100 {
            let newX = Int(rng.nextUnsignedInteger(xMax - 2)) + 1
            let newY = Int(rng.nextUnsignedInteger(yMax - 2)) + 1
            let key = "\(newX),\(newY)"
            if !occupied.contains(key) {
                self.x = newX
                self.y = newY
                return
            }
        }

        for newX in 1..<(xMax - 1) {
            for newY in 1..<(yMax - 1) {
                let key = "\(newX),\(newY)"
                if !occupied.contains(key) {
                    self.x = newX
                    self.y = newY
                    return
                }
            }
        }
    }
}

class MovingSquare: Square {
    var lastDirection: Direction

    init(x: Int, y: Int, lastDirection: Direction) {
        self.lastDirection = lastDirection
        super.init(x: x, y: y)
    }

    func advance(_ direction: Direction) {}
    func advancePlain() {}
}

class SnakePart: MovingSquare {
    override func advance(_ direction: Direction) {
        move(direction)
        lastDirection = direction
    }

    override func advancePlain() {
        move(lastDirection)
    }
}

class SnakeTail: SnakePart {}

class SnakeHead: SnakePart {}

class BorderSquare: Square {}
