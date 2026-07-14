import Foundation

class Filling {
    public var fillingSquares: [FillingSquare] = []
    private var frontier: [(x: Int, y: Int)] = []

    func start(at x: Int, y: Int) {
        fillingSquares = []
        frontier = []
        addSquare(x: x, y: y)
    }

    private func addSquare(x: Int, y: Int) {
        let xMax = SQUARE_COUNT * X_TO_Y_RATIO
        let yMax = SQUARE_COUNT

        guard x > 0 && x < xMax - 1 && y > 0 && y < yMax - 1 else { return }

        let alreadyFilled = fillingSquares.contains { $0.x == x && $0.y == y }
        guard !alreadyFilled else { return }

        fillingSquares.append(FillingSquare(x: x, y: y))
        frontier.append((x: x, y: y))
    }

    func update(deltaTime dt: TimeInterval) {
        guard !frontier.isEmpty else { return }

        let currentCount = frontier.count
        for i in 0..<currentCount {
            let cell = frontier[i]

            let neighbors = [
                (cell.x + 1, cell.y),
                (cell.x - 1, cell.y),
                (cell.x, cell.y + 1),
                (cell.x, cell.y - 1),
            ]

            for (nx, ny) in neighbors {
                addSquare(x: nx, y: ny)
            }
        }

        if frontier.count > currentCount {
            frontier = Array(frontier.dropFirst(currentCount))
        } else {
            frontier.removeAll()
        }
    }
}
