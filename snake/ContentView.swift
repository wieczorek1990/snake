import SwiftUI

struct ContentView: View {
    // Window size.
    let height: Int = SQUARE_COUNT * SQUARE_SIDE_SIZE
    let width: Int = SQUARE_COUNT * SQUARE_SIDE_SIZE * X_TO_Y_RATIO

    // Time ticks.
    let startDate: Date = Date.now
    var schedule: PeriodicTimelineSchedule { .periodic(from: startDate, by: 1.0 / 60.0) }

    // Game logic.
    var game: Game

    @State private var lastTick: Date?
    @FocusState private var isFocused: Bool

    init() {
        let initialSnake = Snake()
        let initialApple = Apple()
        let initialBorder = Border()
        game = Game(initialSnake, initialApple, initialBorder)
    }

    @MainActor
    private func tick(now: Date) {
        let dt = lastTick.map { now.timeIntervalSince($0) } ?? (1.0 / 60.0)
        lastTick = now
        // Optionally clamp dt
        let clampedDT = min(dt, 0.1)
        game.run(deltaTime: clampedDT)
    }

    @ViewBuilder
    private func timelineContent(context: TimelineViewDefaultContext) -> some View {
        Canvas { context, size in
            let drawer = Drawer(game)
            drawer.draw(context: context, size: size)
        }
        .frame(width: CGFloat(width), height: CGFloat(height))
        .padding()
        .onChange(of: context.date) { _, newDate in
            tick(now: newDate)
        }
        .focusable()
        .focused($isFocused)
        .onKeyPress(.upArrow) { game.setDirection(.up); return .handled }
        .onKeyPress(.downArrow) { game.setDirection(.down); return .handled }
        .onKeyPress(.leftArrow) { game.setDirection(.left); return .handled }
        .onKeyPress(.rightArrow) { game.setDirection(.right); return .handled }
        .onKeyPress(.space) { game.running.toggle(); return .handled }
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
