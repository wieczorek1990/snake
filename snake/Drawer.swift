import SwiftUI

class Drawer {
    var game: Game

    let snakeColor: Color = .blue
    let snakeBorderColor: Color = .black
    let appleColor: Color = .green
    let borderSquareColor: Color = .gray
    let fillingSquareColor: Color = .brown

    let squareBorderLineWidth: CGFloat = 1.0

    init(_ game: Game) {
        self.game = game
    }

    func draw(context: GraphicsContext, size: CGSize) {
        for square in game.snake.parts {
            drawSquare(
                context: context,
                size: size,
                square: square,
                color: snakeColor
            )
        }

        drawSquare(
            context: context,
            size: size,
            square: game.apple,
            color: appleColor
        )

        for borderSquare in game.border.borderSquares {
            drawSquare(
                context: context,
                size: size,
                square: borderSquare,
                color: borderSquareColor
            )
        }

        for fillingSquare in game.filling.fillingSquares {
            drawSquare(
                context: context,
                size: size,
                square: fillingSquare,
                color: fillingSquareColor
            )
        }
    }

    func drawSquare(
        context: GraphicsContext,
        size: CGSize,
        square: Square,
        color: Color
    ) {
        let x = square.x * SQUARE_SIDE_SIZE
        let y = square.y * SQUARE_SIDE_SIZE
        let origin = CGPoint(x: CGFloat(x), y: CGFloat(y))
        let width = SQUARE_SIDE_SIZE
        let height = SQUARE_SIDE_SIZE
        let size = CGSize(width: width, height: height)
        let rect = CGRect(origin: origin, size: size)
        let path = Path(rect)

        context.fill(path, with: .color(color))
        context.stroke(
            path,
            with: .color(snakeBorderColor),
            lineWidth: squareBorderLineWidth
        )
    }
}
