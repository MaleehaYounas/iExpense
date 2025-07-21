//
//  ContentView.swift
//  Expense
//
//  Created by MAC on 17/07/2025.
//
import SwiftUI

struct ContentView: View {
    
    @State var isPresented: Bool = false
    @EnvironmentObject var viewModel: ExpenseViewModel
    let backgroundColor = Color(UIColor.systemGray6)
    
    var body: some View {
      VStack(alignment: .leading, spacing:0){

            ToolBar
                List{
                    if !viewModel.personalExpenses.isEmpty{
                        personalExpenseSection
                    }
                    if !viewModel.businessExpenses.isEmpty{
                        businessExpenseSection
                    }
                }
            Spacer()
        }
    }

    var addButton: some View {
        Button(action: {
            isPresented.toggle()
        }) {
            Image(systemName: "plus")
                .imageScale(.large)
        }
        .sheet(isPresented: $isPresented) {
            print("Sheet dismissed!")
        } content: {
           
            ExpenseInputSheet(isPresented: $isPresented)
                .environmentObject(viewModel)
            }
        }
    
    var ToolBar:some View{
        NavigationStack{
            HStack {
                Text("iExpense")
                    .font(.title)
                    .padding(.leading)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    addButton
                     
                }
               
            }.background(backgroundColor)
        }
        .frame(height: 70)
    }
var personalExpenseSection:some View{
    Section {
        ForEach(viewModel.personalExpenses, id: \.id) {
            expenseObj in
            HStack{
                VStack(alignment: .leading){
                    Text("\(expenseObj.name)")
                        .fontWeight(.bold)
                    Text("\(expenseObj.type.getString())")
                }
                Spacer()
                Text("\(expenseObj.currency.getSymbol())\(expenseObj.amount)")
               
            }.padding(6)
        }.onDelete(perform: { indexSet in
            viewModel.deleteBusinessExpense(at: indexSet)
        })
    } header: {
        Text("PERSONAL EXPENSES")
            
    }
}
    
    var businessExpenseSection:some View{
            Section {
                ForEach(viewModel.businessExpenses, id: \.id) {
                    expenseObj in
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(expenseObj.name)")
                                .fontWeight(.bold)
                            Text("\(expenseObj.type.getString())")
                        }
                        Spacer()
                        Text("\(expenseObj.currency.getSymbol())\(expenseObj.amount)")
                       
                    }.padding(6)
                }.onDelete(perform: { indexSet in
                    viewModel.deletePersonalExpense(at: indexSet)
                })
            } header: {
                Text("BUSINESS EXPENSES")
            }

        
    }
    
  }
    
    



