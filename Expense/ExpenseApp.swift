//
//  ExpenseApp.swift
//  Expense
//
//  Created by MAC on 17/07/2025.
//

import SwiftUI
class ExpenseData: ObservableObject {
    @Published var personalExpense: [Expense] = []
    @Published var businessExpense: [Expense] = []
}

@main
struct ExpenseApp: App {
    var body: some Scene {
        
        @StateObject var expenseData = ExpenseData()
        WindowGroup {
            ContentView()
            .environmentObject(expenseData)

        }
    }
}
