//
//  ExpenseInputSheet.swift
//  Expense
//
//  Created by MAC on 17/07/2025.
//

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

struct ExpenseInputSheet: View {
    
    @Binding var isPresented:Bool
    @State var expense:Expense = Expense()
    @FocusState var isInputActive : Bool
    @EnvironmentObject var expenseData: ExpenseData
    let backgroundColor = Color(UIColor.systemGray6)
    
    var body: some View {
        VStack(spacing: 0) {
            
            ToolBar
            
            Form{
                Section{
                    TextField("Name", text: $expense.name)
                    
                    typePicker
                    currencyField
                }
                
            }
        }
    }
    
    var saveButton: some View {
        Button("Save") {
            AddExpenseToList()
            isPresented.toggle()
            isInputActive = false
          }
        }
    
    func AddExpenseToList() -> Void{
        if expense.type == .Personal{
            expenseData.personalExpense.append(expense)
        }
        else if expense.type == .Business{
            expenseData.businessExpense.append(expense)
        }
    }
    
    var typePicker: some View{
        Picker("Type", selection: $expense.type) {
            ForEach(ExpenseType.allCases, id: \.self) {
                expType in
                Text(expType.getString())
            }
           
        }.pickerStyle(.menu)
    }
    
    var currencyField:some View{
        HStack{
            Text("\(expense.currency.getSymbol())")
            TextField("0.00", text: $expense.amount)
                .keyboardType(.decimalPad)
                .focused($isInputActive)
            Picker(" ", selection: $expense.currency) {
                ForEach(ExpenseCurrency.allCases, id: \.self) {
                    expCurr in
                    Text(expCurr.getString())
                }
                
            }.pickerStyle(.menu)
        }
    }
    
    
    var ToolBar:some View{
        NavigationStack {
            HStack {
                Text("Add new expense")
                    .font(.title)
                    .padding(.leading)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    saveButton
                }
            }.background(backgroundColor)
        }
        .frame(height: 80)
    }
    
}
