//
//  ExpenseInputSheet.swift
//  Expense
//
//  Created by MAC on 17/07/2025.
//

import SwiftUI
struct ExpenseInputSheet: View {
    
    @Binding var isPresented:Bool
    @State var expense:Expense = Expense()
    @FocusState var isInputActive : Bool
    @EnvironmentObject var viewModel: ExpenseViewModel
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
            viewModel.addExpense(expense)
            isPresented.toggle()
            isInputActive = false
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

