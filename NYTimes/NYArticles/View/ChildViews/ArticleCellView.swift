//
//  ArticleCellView.swift
//  NYTimes
//
//  Created by Nisar Ahmad on 09/08/2023.
//

import SwiftUI

struct ArticleCellView: View {
    
    var article: Article?
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: article?.media?.first?.media_metadata?.first?.url ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
            }

            VStack(alignment: .leading) {
                Text(article?.title ?? "")
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .padding(.bottom, 10)
                
                HStack(alignment: .top) {
                    Text(article?.byline?.uppercased() ?? "")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "calendar")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                        
                        Text(article?.published_date ?? "")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.leading, 5)
            /*
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(.title2, design: .rounded))
                .foregroundColor(.gray)
                .padding(.leading, 5)*/
        }
    }
    
}

struct ArticleCellView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCellView()
    }
}
