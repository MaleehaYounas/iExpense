import SwiftUI


enum ExpenseType : CaseIterable, Codable{
    case Personal
    case Business
    
    func getString() -> String{
        switch self{
        case .Personal:
            return "Personal"
        case .Business:
            return "Business"
        }
    }
}

enum ExpenseCurrency: CaseIterable, Codable {
    case USD
    case PKR
    case EUR
    
    func getString() -> String{
        switch self{
        case .USD:
            return "USD"
        case .PKR:
            return "PKR"
        case .EUR:
            return "EUR"
        }
    }
    
    func getSymbol() -> String{
        switch self{
        case .USD:
            return "$"
        case .PKR:
            return "Rs"
        case .EUR:
            return "€"
        }
    }
}

struct Expense : Identifiable, Codable{
    var id:UUID = UUID()
    var name: String = ""
    var type: ExpenseType = .Personal
    var currency: ExpenseCurrency = .USD
    var amount: String = ""
}

enum SortOption {
    case name
    case price
}

extension String {
    func toDouble() -> Double {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return Double(trimmed) ?? 0.0
    }
}

