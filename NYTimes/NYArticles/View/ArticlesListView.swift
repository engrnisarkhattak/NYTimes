//
//  ContentView.swift
//  NYTimes
//
//  Created by Nisar Ahmad on 09/08/2023.
//

import SwiftUI

struct ArticlesListView: View {
    
    @ObservedObject var viewModel = ArticleListViewModel()
    @State var showSearch: Bool = false
    @State var showPeriods: Bool = false
    
    var body: some View {
        
        ZStack {
            
            if viewModel.showLoader == true {
                LoaderView()
            }
            else {
                NavigationStack {
                    VStack {
                        if showSearch {
                            SearchView(search: $viewModel.searchText)
                        }
                        ListView(articles: viewModel.filterdArticles)
                    }
                    .sheet(isPresented: $showPeriods, content: {
                        PeriodsSheet(onSelection: { item in
                            self.viewModel.selectedPeriod = item
                            self.showPeriods = false
                            print(item.rawValue)
                            Task {
                                await self.fetchArticleData()
                            }
                        })
                        .presentationDetents([.height(200)])
                    })
                    .navigationTitle("NY Times Articles")
                    .navigationBarTitleDisplayMode(.automatic)
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack(spacing: 0) {
                                Button {
                                    // Search button clicked
                                    withAnimation {
                                        self.showSearch.toggle()
                                    }
                                } label: {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.white)
                                }
                                
                                Button {
                                    // periods button clicked
                                    self.showPeriods.toggle()
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .rotationEffect(Angle(degrees: 90))
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.leading)
                        }
                    })
                }
            }
            
        }
        .task {
            await self.fetchArticleData()
        }
        .alert("", isPresented: $viewModel.hasError) {} message: {
            Text(viewModel.errorMessage)
        }
    }
    
    
    
    init() {
        let navbarAppearence = UINavigationBarAppearance()
        navbarAppearence.largeTitleTextAttributes = [.foregroundColor : UIColor.white, .font: UIFont(name: "ArialRoundedMTBold", size: 35)]
        
        navbarAppearence.titleTextAttributes = [.foregroundColor : UIColor.white, .font : UIFont(name: "ArialRoundedMTBold", size: 20)]
        
        navbarAppearence.backgroundColor = .brown
        
        UINavigationBar.appearance().standardAppearance = navbarAppearence
        UINavigationBar.appearance().scrollEdgeAppearance = navbarAppearence
        UINavigationBar.appearance().compactAppearance = navbarAppearence
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
    }
    
    
    private func fetchArticleData() async {
        await viewModel.fetchArticleData()
        
    }
}


// MARK: - Loader view

struct LoaderView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 200, height: 150)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.5), radius: 3.0, x: 0, y: 0)
            
            ProgressView()
                .offset(x: 0, y: -20)
            
            Text("Loading...")
                .offset(x: 0, y: 40)
                .font(.system(.body))
        }
    }
}

// MARK: - Search View

struct SearchView: View {
    
    @Binding var search: String
    var body: some View {
        EmptyView()
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search articles ...")
    }
}

// MARK: - List View

struct ListView: View {
    
    var articles: [Article]
    
    var body: some View {
        List(articles.indices, id: \.self) { index in
            let article = articles[index]
            
            NavigationLink {
                ArticleDetailView(article: article)
            } label: {
                ArticleCellView(article: article)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesListView()
    }
}

