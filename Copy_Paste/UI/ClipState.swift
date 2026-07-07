import SwiftUI
import Foundation

struct ClipState: View {
    @EnvironmentObject private var appState: AppState
    @State private var showCopied = false
    @State private var isCopied = false
    private var changeCounter = -1
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if(isCopied && appState.clipboardAlive == true){
                HStack{
                    Image(systemName: "checkmark.circle")
                        .foregroundStyle(showCopied ? .green : .secondary)
                    Text("Copied")
                        .foregroundStyle(showCopied ? .green : .secondary)
                }
            }else if(appState.clipboardAlive == false || !isCopied) {
                HStack{
                    Image(systemName:  "xmark.circle")
                        .foregroundStyle(.secondary)
                    Text("Press Cmd + C to use")
                        .foregroundStyle(.secondary)
                }
                
            }
            if(isCopied){
                Text("Content")
                    .fontWeight(.bold)
                Text(appState.clipboardText)
                    .textSelection(.enabled)
            }
        }
        .padding()
        .frame(width: 360, height: 200, alignment: .topLeading)
        .onChange(of: appState.clipboardCounter) {
            let currentCounter = appState.clipboardCounter
            isCopied = true
            showCopied = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if appState.clipboardCounter == currentCounter {
                    showCopied = false
                }
            }
        }
    }
}
#Preview {
    ClipState()
        .environmentObject(AppState())
}
