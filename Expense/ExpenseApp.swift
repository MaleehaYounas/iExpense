import SwiftUI

@main
struct ExpenseApp: App {
    @StateObject var viewModel = ExpenseViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
