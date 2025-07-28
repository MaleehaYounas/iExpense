import Foundation

class ExpenseViewModel: ObservableObject {
    
        @Published var Expenses: [Expense] = [] {
            didSet {
                saveData()
            }
        }
    
    @Published var showAlert:Bool = false
    @Published var ShowErorr:Bool = false

    
    init() {
        loadData()
    }

    func addExpense(_ expense: Expense) {
        
            if validateInputs(expense: expense){
                ShowErorr = false
                if isCurrConsistent(expense: expense)
                {
                    Expenses.append(expense)
                    showAlert = false
                }
                else
                {
                    showAlert = true
                }
            }
            else{
                ShowErorr = true
            }
       
    }
    

    func deleteExpenses(at offsets: IndexSet) {
        Expenses.remove(atOffsets: offsets)
        saveData()
    }
    

    func getSearchedResults(input:String) -> [Expense] {
        var searchResults:[Expense] = []
        for i in 0..<Expenses.count {
            if Expenses[i].name.contains(input)
            {
                searchResults.append(Expenses[i])
                
            }
        }
        return searchResults
    }
    
    private let allExpensesKey = "allExpenses"

    private func saveData() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(Expenses) {
            UserDefaults.standard.set(data, forKey: allExpensesKey)
        }
    }

    private func loadData() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: allExpensesKey),
           let decodedExpenses = try? decoder.decode([Expense].self, from: data) {
            self.Expenses = decodedExpenses
        }
    }

    
    func sortExpenses(by option: SortOption) {
        switch option {
        case .name:
            Expenses.sort { $0.name.lowercased() < $1.name.lowercased() }
        case .price:
            Expenses.sort { ($0.amount.toDouble()) < ($1.amount.toDouble()) }
        }
    }

    
    func isCurrConsistent(expense: Expense) -> Bool {
        if Expenses.isEmpty {
            return true
        }
        return Expenses.allSatisfy { $0.currency == expense.currency }
    }
    
    func validateInputs(expense:Expense) -> Bool {
        if expense.name.isEmpty || expense.amount.isEmpty {
            return false
        }
        return true
    }
}
    
    
    


