import SwiftUI

struct ContentView: View {
    let height: Int = SQUARE_COUNT * SQUARE_SIDE_SIZE
    let width: Int = SQUARE_COUNT * SQUARE_SIDE_SIZE * X_TO_Y_RATIO

    @State var game: Game
    @State private var lastTick: Date?
    @State private var timer: Timer?
    @State private var tickCount: Int = 0
    @FocusState private var isFocused: Bool

    private let gameUpdateInterval: TimeInterval = 1.0 / 30.0

    init() {
        _game = State(initialValue: Game(Snake(), Apple(), Border()))
    }

    var body: some View {
        Canvas { context, size in
            let drawer = Drawer(game)
            drawer.draw(context: context, size: size)
        }
        .id(tickCount)
        .frame(width: CGFloat(width), height: CGFloat(height))
        .padding()
        .focusable()
        .focused($isFocused)
        .onAppear {
            isFocused = true
            startGameLoop()
        }
        .onDisappear {
            stopGameLoop()
        }
        .onKeyPress(.upArrow) { game.setDirection(.up); return .handled }
        .onKeyPress(.downArrow) { game.setDirection(.down); return .handled }
        .onKeyPress(.leftArrow) { game.setDirection(.left); return .handled }
        .onKeyPress(.rightArrow) { game.setDirection(.right); return .handled }
        .onKeyPress(.space) {
            if game.running {
                game.running.toggle()
            } else {
                game = Game(Snake(), Apple(), Border())
            }
            return .handled
        }
    }

    private func startGameLoop() {
        let timer = Timer(timeInterval: gameUpdateInterval, repeats: true) { _ in
            updateGame()
        }
        RunLoop.current.add(timer, forMode: .common)
        self.timer = timer
    }

    private func stopGameLoop() {
        timer?.invalidate()
        timer = nil
    }

    private func updateGame() {
        let now = Date.now
        let dt = lastTick.map { now.timeIntervalSince($0) } ?? gameUpdateInterval
        lastTick = now
        let clampedDT = min(dt, 0.1)
        game.run(deltaTime: clampedDT)
        tickCount += 1
    }
}

#Preview {
    ContentView()
}
