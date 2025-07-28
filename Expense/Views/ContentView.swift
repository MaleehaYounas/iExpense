//
//  ContentView.swift
//  Expense
//
//  Created by MAC on 17/07/2025.
//
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ExpenseViewModel()
    @State var searchInput:String = ""
    @State var isPresented: Bool = false
    @State var results:[Expense] = []
    @FocusState var isInputActive:Bool
    
    let backgroundColor = Color(UIColor.systemGray6)
    
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                ToolBar

                if viewModel.personalExpenses.isEmpty && viewModel.businessExpenses.isEmpty && results.isEmpty {
                    // No data
                    VStack {
                        ContentUnavailableView("Expenses not found!", systemImage: "doc.plaintext.fill")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(backgroundColor)
                }
                else {
                    searchTextField

                    if !searchInput.isEmpty && results.isEmpty {
                        // Show no search results
                        VStack {
                            ContentUnavailableView("No matching expenses found", systemImage: "magnifyingglass.circle")
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(backgroundColor)
                    } else {
                        // Show all expenses
                        List {
                            if !results.isEmpty {
                                searchResultsSection
                            } else {
                                if !viewModel.personalExpenses.isEmpty {
                                    personalExpenseSection
                                }
                                if !viewModel.businessExpenses.isEmpty {
                                    businessExpenseSection
                                }
                            }
                        }
                    }
                }
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

    var ToolBar: some View {
        NavigationStack {
            HStack {
                Text("iExpense")
                    .font(.title)
                    .padding(.leading)
                    .padding(.vertical,10)
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    sortMenu
                    addButton
                }
            }
            .background(backgroundColor)
        }
        .frame(height: 70)
    }
    
    var noDataText:some View{
        Text("There are no expenses!")
            .font(.headline)
            .font(.system(size: 30))
            .padding()
    }
        var searchTextField: some View {
        VStack{
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search", text: $searchInput)
                    .focused($isInputActive)
                    .onChange(of: searchInput) {
                        results = viewModel.getSearchedResults(input: searchInput)
                    }
                
                if !searchInput.isEmpty {
                    Button(action: {
                        searchInput = ""
                        results = []
                        isInputActive = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray5))
            )
            .padding(.horizontal, 20)
            .padding(.vertical,20)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputActive = false
                    }
                }
            }
        }.background(backgroundColor)
           
    }

    
    var sortMenu: some View {
        Menu {
            Button("Sort by Name") {
                viewModel.sortExpenses(by: .name)
            }
            Button("Sort by Price") {
                viewModel.sortExpenses(by: .price)
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down.circle")
                .imageScale(.large)
                .padding(.trailing)
        }
    }

    
var searchResultsSection:some View{
    
    Section {
        ForEach(results, id: \.id) {
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
        Text("Search Results")
    }
    
    
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
            viewModel.deletePersonalExpense(at: indexSet)
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
                    viewModel.deleteBusinessExpense(at: indexSet)
                })
            } header: {
                Text("BUSINESS EXPENSES")
            }
    }
    
    
    
    
  }
    
    



