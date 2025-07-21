import SwiftUI


enum ExpenseType : CaseIterable{
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

enum ExpenseCurrency: CaseIterable {
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

struct Expense : Identifiable{
    var id:UUID = UUID()
    var name: String = ""
    var type: ExpenseType = .Personal
    var currency: ExpenseCurrency = .USD
    var amount: String = " "
}

