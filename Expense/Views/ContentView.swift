//
//import SwiftUI
//
//struct ContentView: View {
//    @StateObject var viewModel = ExpenseViewModel()
//    @State var searchInput:String = ""
//    @State var isPresented: Bool = false
//    @State var results:[Expense] = []
//    @FocusState var isInputActive:Bool
//    
//    let backgroundColor = Color(UIColor.systemGray6)
//    
//        var body: some View {
//            VStack(alignment: .leading, spacing: 0) {
//                ToolBar
//
//                if viewModel.personalExpenses.isEmpty && viewModel.businessExpenses.isEmpty && results.isEmpty {
//                    // No data
//                    VStack {
//                        ContentUnavailableView("Expenses not found!", systemImage: "doc.plaintext.fill")
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(backgroundColor)
//                }
//                else {
//                    searchTextField
//
//                    if !searchInput.isEmpty && results.isEmpty {
//                        // Show no search results
//                        VStack {
//                            ContentUnavailableView("No matching expenses found", systemImage: "magnifyingglass.circle")
//                        }
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(backgroundColor)
//                    } else {
//                        // Show all expenses
//                        List {
//                            if !results.isEmpty {
//                                searchResultsSection
//                            } else {
//                                if !viewModel.personalExpenses.isEmpty {
//                                    personalExpenseSection
//                                }
//                                if !viewModel.businessExpenses.isEmpty {
//                                    businessExpenseSection
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        
//            
//    }
//
//    var addButton: some View {
//        Button(action: {
//            isPresented.toggle()
//        }) {
//            Image(systemName: "plus")
//                .imageScale(.large)
//        }
//        .sheet(isPresented: $isPresented) {
//            print("Sheet dismissed!")
//        } content: {
//           
//            ExpenseInputSheet(isPresented: $isPresented)
//                .environmentObject(viewModel)
//            }
//        }
//
//    var ToolBar: some View {
//        NavigationStack {
//            HStack {
//                Text("iExpense")
//                    .font(.title)
//                    .padding(.leading)
//                    .padding(.vertical,10)
//                Spacer()
//            }
//            .toolbar {
//                ToolbarItemGroup(placement: .topBarTrailing) {
//                    sortMenu
//                    addButton
//                }
//            }
//            .background(backgroundColor)
//        }
//        .frame(height: 70)
//    }
//    
//    var noDataText:some View{
//        Text("There are no expenses!")
//            .font(.headline)
//            .font(.system(size: 30))
//            .padding()
//    }
//        var searchTextField: some View {
//        VStack{
//            HStack {
//                Image(systemName: "magnifyingglass")
//                    .foregroundColor(.gray)
//                
//                TextField("Search", text: $searchInput)
//                    .focused($isInputActive)
//                    .onChange(of: searchInput) {
//                        results = viewModel.getSearchedResults(input: searchInput)
//                    }
//                
//                if !searchInput.isEmpty {
//                    Button(action: {
//                        searchInput = ""
//                        results = []
//                        isInputActive = false
//                    }) {
//                        Image(systemName: "xmark.circle.fill")
//                            .foregroundColor(.gray)
//                    }
//                }
//            }
//            .padding(10)
//            .background(
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(Color(.systemGray5))
//            )
//            .padding(.horizontal, 20)
//            .padding(.vertical,20)
//            .toolbar {
//                ToolbarItemGroup(placement: .keyboard) {
//                    Spacer()
//                    Button("Done") {
//                        isInputActive = false
//                    }
//                }
//            }
//        }.background(backgroundColor)
//           
//    }
//
//    
//    var sortMenu: some View {
//        Menu {
//            Button("Sort by Name") {
//                viewModel.sortExpenses(by: .name)
//            }
//            Button("Sort by Price") {
//                viewModel.sortExpenses(by: .price)
//            }
//        } label: {
//            Image(systemName: "arrow.up.arrow.down.circle")
//                .imageScale(.large)
//                .padding(.trailing)
//        }
//    }
//
//    
//var searchResultsSection:some View{
//    
//    Section {
//        ForEach(results, id: \.id) {
//            expenseObj in
//            HStack{
//                VStack(alignment: .leading){
//                    Text("\(expenseObj.name)")
//                        .fontWeight(.bold)
//                    Text("\(expenseObj.type.getString())")
//                }
//                Spacer()
//                Text("\(expenseObj.currency.getSymbol())\(expenseObj.amount)")
//               
//            }.padding(6)
//        }.onDelete(perform: { indexSet in
//            viewModel.deleteBusinessExpense(at: indexSet)
//        })
//    } header: {
//        Text("Search Results")
//    }
//    
//    
//}
//    
//var personalExpenseSection:some View{
//    Section {
//        ForEach(viewModel.personalExpenses, id: \.id) {
//            expenseObj in
//            HStack{
//                VStack(alignment: .leading){
//                    Text("\(expenseObj.name)")
//                        .fontWeight(.bold)
//                    Text("\(expenseObj.type.getString())")
//                }
//                Spacer()
//                Text("\(expenseObj.currency.getSymbol())\(expenseObj.amount)")
//               
//            }.padding(6)
//        }.onDelete(perform: { indexSet in
//            viewModel.deletePersonalExpense(at: indexSet)
//        })
//    } header: {
//        Text("PERSONAL EXPENSES")
//    }
//}
//   
//    var businessExpenseSection:some View{
//            Section {
//                ForEach(viewModel.businessExpenses, id: \.id) {
//                    expenseObj in
//                    HStack{
//                        VStack(alignment: .leading){
//                            Text("\(expenseObj.name)")
//                                .fontWeight(.bold)
//                            Text("\(expenseObj.type.getString())")
//                        }
//                        Spacer()
//                        Text("\(expenseObj.currency.getSymbol())\(expenseObj.amount)")
//                       
//                    }.padding(6)
//                }.onDelete(perform: { indexSet in
//                    viewModel.deleteBusinessExpense(at: indexSet)
//                })
//            } header: {
//                Text("BUSINESS EXPENSES")
//            }
//    }
//    
//    
//    
//    
//  }




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
            
            if viewModel.Expenses.isEmpty && results.isEmpty {
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
                            if !viewModel.Expenses.isEmpty {
                                personalExpenseSection
                            }
                            if !viewModel.Expenses.isEmpty {
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
    
    
    var searchResultsSection: some View {
        // Map each result to its index in the original Expenses list
        let searchResultsWithOffsets = results.compactMap { result in
            viewModel.Expenses.firstIndex(where: { $0.id == result.id }).map { (offset: $0, expense: result) }
        }

        return Section(header: Text("Search Results")) {
            ForEach(searchResultsWithOffsets, id: \.expense.id) { index, expenseObj in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(expenseObj.name)")
                            .fontWeight(.bold)
                        Text("\(expenseObj.type.getString())")
                    }
                    Spacer()
                    Text("\(expenseObj.currency.getSymbol())\(expenseObj.amount)")
                }
                .padding(6)
            }
            .onDelete { indexSet in
                let originalIndices = indexSet.map { searchResultsWithOffsets[$0].offset }
                viewModel.deleteExpenses(at: IndexSet(originalIndices))
            }
        }
    }

    var businessExpenseSection: some View {
        let businessExpenses = viewModel.Expenses.enumerated().filter { $0.element.type == .Business }

        return Group {
            if !businessExpenses.isEmpty {
                Section(header: Text("BUSINESS EXPENSES")) {
                    ForEach(businessExpenses, id: \.element.id) { index, expenseObj in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expenseObj.name)
                                    .fontWeight(.bold)
                                Text(expenseObj.type.getString())
                            }
                            Spacer()
                            Text("\(expenseObj.currency.getSymbol())\(expenseObj.amount)")
                        }
                        .padding(6)
                    }
                    .onDelete { indexSet in
                        
                        let indicesToDelete = indexSet.map { businessExpenses[$0].offset }
                        viewModel.deleteExpenses(at: IndexSet(indicesToDelete))
                    }
                }
            }
        }
    }


        
    var personalExpenseSection: some View {
        let personalExpenses = viewModel.Expenses.enumerated().filter { $0.element.type == .Personal }

        return Group {
            if !personalExpenses.isEmpty {
                Section(header: Text("PERSONAL EXPENSES")) {
                    ForEach(personalExpenses, id: \.element.id) { index, expenseObj in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expenseObj.name)
                                    .fontWeight(.bold)
                                Text(expenseObj.type.getString())
                            }
                            Spacer()
                            Text("\(expenseObj.currency.getSymbol())\(expenseObj.amount)")
                        }
                        .padding(6)
                    }
                    .onDelete { indexSet in
                        let indicesToDelete = indexSet.map { personalExpenses[$0].offset }
                        viewModel.deleteExpenses(at: IndexSet(indicesToDelete))
                    }
                }
            }
        }
    }
}



