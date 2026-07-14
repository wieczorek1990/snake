import Foundation

class Filling {
    public var fillingSquares: [FillingSquare] = []
    private var spawnTimer: TimeInterval = 0
    private let spawnInterval: TimeInterval = 0.001

    func update(deltaTime dt: TimeInterval) {
        spawnTimer += dt
        if spawnTimer >= spawnInterval {
            spawnTimer = 0

            let xMax = SQUARE_COUNT * X_TO_Y_RATIO
            let yMax = SQUARE_COUNT

            var occupied = Set<String>()
            for sq in fillingSquares {
                occupied.insert("\(sq.x),\(sq.y)")
            }

            var rng = RandomNumberGenerator.generator
            for _ in 0..<SQUARE_COUNT * SQUARE_SIDE_SIZE {
                let x = Int(rng.nextUnsignedInteger(xMax - 2)) + 1
                let y = Int(rng.nextUnsignedInteger(yMax - 2)) + 1
                let key = "\(x),\(y)"

                if !occupied.contains(key) {
                    fillingSquares.append(FillingSquare(x: x, y: y))
                    break
                }
            }
        }
    }
}
