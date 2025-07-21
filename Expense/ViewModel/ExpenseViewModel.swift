import Foundation

class ExpenseViewModel: ObservableObject {
    @Published var personalExpenses: [Expense] = []
    @Published var businessExpenses: [Expense] = []
    
    func addExpense(_ expense: Expense) {
        switch expense.type {
        case .Personal:
            personalExpenses.append(expense)
        case .Business:
            businessExpenses.append(expense)
        }
    }
    
    func deletePersonalExpense(at offsets: IndexSet) {
        personalExpenses.remove(atOffsets: offsets)
    }
    
    func deleteBusinessExpense(at offsets: IndexSet) {
        businessExpenses.remove(atOffsets: offsets)
    }
}
