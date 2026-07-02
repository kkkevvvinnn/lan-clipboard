import Foundation
import Combine

final class AppState: ObservableObject {
    @Published var clipboardText = ""
    @Published var clipboardCounter: Int = 0
    @Published var clipboardAlive = false
    
    private let clipboardMonitor = ClipboardMonitor()
    
    init() {
        clipboardMonitor.onTextChange = { [weak self] text in
            self?.clipboardText = text
            self?.clipboardCounter += 1
        }
        clipboardMonitor.onAliveChange = { [weak self] alive in
            self?.clipboardAlive = alive
        }
        clipboardMonitor.start()
    }
}
