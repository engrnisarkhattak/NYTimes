//
//  ArticleDetailView.swift
//  NYTimes
//
//  Created by Nisar Ahmad on 09/08/2023.
//

import SwiftUI

struct ArticleDetailView: View {
    
    var article: Article?
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(article?.title ?? "")
                    .font(.system(.largeTitle, design: .rounded, weight: .heavy))
                    .padding(.bottom, 20)
                
                SubTitleView(articleBy: article?.byline ?? "", publishDate: article?.published_date ?? "")
                
                Text(article?.adx_keywords ?? "")
                    .font(.system(.subheadline, design: .rounded))
                
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.white)
                            Text("Articles")
                                .foregroundColor(.white)
                        }
                    }
                    
                }
            }
        }
        
    }
}

// MARK: - SubViews

struct SubTitleView: View {
    
    var articleBy: String
    var publishDate: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(articleBy.uppercased() )
                .font(.system(.headline, design: .default, weight: .bold))
                .foregroundColor(.secondary)
                .padding(.bottom, 8)
            
            HStack {
                Image(systemName: "calendar")
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
                
                Text(publishDate)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
            }
        }
        .padding(.bottom, 30)
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView()
    }
}


