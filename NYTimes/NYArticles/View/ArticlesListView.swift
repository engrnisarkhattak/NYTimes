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
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 3.0, x: 0, y: 0)
                    
                    ProgressView()
                }
               
            }
            else {
                NavigationStack {
                    
                    VStack {
                        if showSearch {
                            EmptyView()
                                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search articles ...")
                        }
                        
                        List(viewModel.filterdArticles.indices, id: \.self) { index in
                            let article = viewModel.articles[index]
                            
                            NavigationLink {
                                ArticleDetailView(article: article)
                            } label: {
                                ArticleCellView(article: article)
                            }
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
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
                    
                    .task {
                        await self.fetchArticleData()
                    }
                    .alert("", isPresented: $viewModel.hasError) {} message: {
                        Text(viewModel.errorMessage)
                    }
                    
                    .navigationTitle("NY Times Most Popular")
                    .navigationBarTitleDisplayMode(.inline)
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
                                        .foregroundColor(.gray)
                                }
                                
                                Button {
                                    // periods button clicked
                                    self.showPeriods.toggle()
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .rotationEffect(Angle(degrees: 90))
                                        .foregroundColor(.primary)
                                }
                            }
                            .padding(.leading)
                            
                            
                        }
                    })
                }
            }
            
        }
    }
    
    
    private func fetchArticleData() async {
        await viewModel.fetchArticleData()
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesListView()
    }
}
