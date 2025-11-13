import SwiftUI

struct ContentView: View {
    // Window size.
    let height: Int = SQUARE_COUNT * SQUARE_SIDE_SIZE
    let width: Int = SQUARE_COUNT * SQUARE_SIDE_SIZE * X_TO_Y_RATIO

    // Time ticks.
    let startDate: Date = Date.now
    var schedule: PeriodicTimelineSchedule {
        .periodic(from: startDate, by: (1.0 / 60.0) * 16.0)
    }

    // Game logic.
    var game: Game

    init() {
        let initialSnake: Snake = Snake()
        let initialApple: Apple = Apple()
        let initialBorder: Border = Border()

        game = Game(initialSnake, initialApple, initialBorder)
    }

    @MainActor
    private func tick() {
        game.run()
    }

    @ViewBuilder
    private func timelineContent(context: TimelineViewDefaultContext)
        -> some View
    {
        ZStack {
            Canvas { (gc: inout GraphicsContext, size: CGSize) in
                let drawer = Drawer(game)
                drawer.draw(context: gc, size: size)
            }
            .frame(width: CGFloat(width), height: CGFloat(height))
            .padding()
            .onChange(of: context.date) { _, _ in
                tick()
            }
        }
        // Keyboard key presses.
        .focusable()
        .onKeyPress(.upArrow) {
            game.setDirection(Direction.up)
            return .handled
        }
        .onKeyPress(.downArrow) {
            game.setDirection(Direction.down)
            return .handled
        }
        .onKeyPress(.leftArrow) {
            game.setDirection(Direction.left)
            return .handled
        }
        .onKeyPress(.rightArrow) {
            game.setDirection(Direction.right)
            return .handled
        }
        .onKeyPress(.space) {
            game.running.toggle()
            return .handled
        }
    }

    var body: some View {
        TimelineView(schedule) { context in
            timelineContent(context: context)
        }
    }
}

#Preview {
    ContentView()
}
