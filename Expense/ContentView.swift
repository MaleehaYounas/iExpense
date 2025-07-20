//
//  ContentView.swift
//  Expense
//
//  Created by MAC on 17/07/2025.
//
import SwiftUI




struct ContentView: View {
    
    @State var isPresented: Bool = false
    @EnvironmentObject var expenseData: ExpenseData
    let backgroundColor = Color(UIColor.systemGray6)
    
    var body: some View {
        VStack(alignment: .leading, spacing:0){

            ToolBar
                List{
                    if !expenseData.personalExpense.isEmpty{
                        personalExpenseSection
                    }
                    if !expenseData.businessExpense.isEmpty{
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
                .environmentObject(expenseData)
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
        ForEach(expenseData.personalExpense, id: \.id) {
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
            self.expenseData.personalExpense.remove(atOffsets: indexSet)
        })
    } header: {
        Text("PERSONAL EXPENSES")
            
    }
}
    
    var businessExpenseSection:some View{
            Section {
                ForEach(expenseData.businessExpense, id: \.id) {
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
                    self.expenseData.businessExpense.remove(atOffsets: indexSet)
                })
            } header: {
                Text("BUSINESS EXPENSES")
            }

        
    }
    
  }
    
    

