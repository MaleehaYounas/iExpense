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
    private let personalKey = "personalExpenses"
    private let businessKey = "businessExpenses"
    
    
    init() {
        loadData()
    }
    
    func addExpense(_ expense: Expense) {
        switch expense.type {
        case .Personal:
            if isPersonalCurrConsistent(expense: expense)
            {
                personalExpenses.append(expense)
                showAlert = false
            }
            else
            {
                showAlert = true
            }
        case .Business:
            if isBusinessCurrConsistent(expense: expense)
            {
                businessExpenses.append(expense)
                showAlert = false
            }
            else{
                showAlert = true
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
                print("\(personalExpenses[i].name)")
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
    
    private func saveData() {
        let encoder = JSONEncoder()
        if let personalData = try? encoder.encode(personalExpenses) {
            UserDefaults.standard.set(personalData, forKey: personalKey)
            print("Saved personalExpenses")

        }
        if let businessData = try? encoder.encode(businessExpenses) {
            UserDefaults.standard.set(businessData, forKey: businessKey)
            print("Saved businessExpenses")
        }
    }
    
    private func loadData() {
        let decoder = JSONDecoder()
        
        if let personalData = UserDefaults.standard.data(forKey: personalKey),
           let savedPersonal = try? decoder.decode([Expense].self, from: personalData) {
            self.personalExpenses = savedPersonal

        }
        if let businessData = UserDefaults.standard.data(forKey: businessKey),
           let savedBusiness = try? decoder.decode([Expense].self, from: businessData) {
            self.businessExpenses = savedBusiness
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
}

