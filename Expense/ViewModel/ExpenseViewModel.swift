import Foundation

class ExpenseViewModel: ObservableObject {
    @Published var personalExpenses: [Expense] = [] {
        didSet {
            saveData()
        }
    }
    @Published var businessExpenses: [Expense] = [] {
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
        switch expense.type {
        case .Personal:
            if validateInputs(expense: expense){
                ShowErorr = false
                if isPersonalCurrConsistent(expense: expense)
                {
                    personalExpenses.append(expense)
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
        case .Business:
            if validateInputs(expense: expense){
                ShowErorr = false
                
                if isBusinessCurrConsistent(expense: expense)
                {
                    businessExpenses.append(expense)
                    showAlert = false
                }
                else{
                    showAlert = true
                }
            }
            else{
                ShowErorr = true
                
                
            }
        }
    }
    
    
    
    func deletePersonalExpense(at offsets: IndexSet) {
        personalExpenses.remove(atOffsets: offsets)
    }
    
    func deleteBusinessExpense(at offsets: IndexSet) {
        businessExpenses.remove(atOffsets: offsets)
    }
    
    func getSearchedResults(input:String) -> [Expense] {
        var searchResults:[Expense] = []
        for i in 0..<personalExpenses.count {
            if personalExpenses[i].name.contains(input)
            {
                searchResults.append(personalExpenses[i])
                
            }
        }
        for i in 0..<businessExpenses.count {
            if businessExpenses[i].name.contains(input)
            {
                searchResults.append(businessExpenses[i])
            
            }
        }
        return searchResults
    }
    
    private let allExpensesKey = "allExpenses"

    private func saveData() {
        let encoder = JSONEncoder()
        let allExpenses = personalExpenses + businessExpenses
        if let data = try? encoder.encode(allExpenses) {
            UserDefaults.standard.set(data, forKey: allExpensesKey)
        }
    }

    private func loadData() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: allExpensesKey),
           let allExpenses = try? decoder.decode([Expense].self, from: data) {
            self.personalExpenses = allExpenses.filter { $0.type == .Personal }
            self.businessExpenses = allExpenses.filter { $0.type == .Business }
        }
    }

    func sortExpenses(by option: SortOption) {
        switch option {
        case .name:
            personalExpenses.sort { $0.name.lowercased() < $1.name.lowercased() }
            businessExpenses.sort { $0.name.lowercased() < $1.name.lowercased() }
        case .price:
            personalExpenses.sort { ($0.amount.toDouble()) < ($1.amount.toDouble()) }
            businessExpenses.sort { ($0.amount.toDouble()) < ($1.amount.toDouble()) }
        }
    }
    
    func isPersonalCurrConsistent(expense: Expense) -> Bool {
        if personalExpenses.isEmpty {
            return true
        }
        return personalExpenses.allSatisfy { $0.currency == expense.currency }
    }
    
    func isBusinessCurrConsistent(expense: Expense) -> Bool {
        if businessExpenses.isEmpty {
            return true
        }
        return businessExpenses.allSatisfy { $0.currency == expense.currency }
    }
    
    func validateInputs(expense:Expense) -> Bool {
        if expense.name.isEmpty || expense.amount.isEmpty {
            return false
        }
        return true
    }
}
    
    
    


