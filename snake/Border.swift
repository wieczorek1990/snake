class Border {
    var borderSquares: [BorderSquare]

    init() {
        let xMax = SQUARE_COUNT * X_TO_Y_RATIO
        let yMax = SQUARE_COUNT

        var initialBorderSquares: [BorderSquare] = []

        for x in 0...0 {
            for y in 0..<SQUARE_COUNT {
                let borderSquare = BorderSquare(x: x, y: y)

                initialBorderSquares.append(borderSquare)
            }
        }

        for x in xMax-1...xMax-1 {
            for y in 0..<SQUARE_COUNT {
                let borderSquare = BorderSquare(x: x, y: y)

                initialBorderSquares.append(borderSquare)
            }
        }

        for x in 0..<xMax - 1 {
            for y in 0...0 {
                let borderSquare = BorderSquare(x: x, y: y)

                initialBorderSquares.append(borderSquare)
            }
        }

        for x in 0..<xMax - 1 {
            for y in yMax-1...yMax-1 {
                let borderSquare = BorderSquare(x: x, y: y)

                initialBorderSquares.append(borderSquare)
            }
        }

        borderSquares = initialBorderSquares
    }
}
