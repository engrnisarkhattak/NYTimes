//
//  PeriodsSheet.swift
//  NYTimes
//
//  Created by Nisar Ahmad on 09/08/2023.
//

import SwiftUI

struct PeriodsSheet: View {
    
    var onSelection: (Period) -> ()
    
    var body: some View {
        VStack(alignment: .center) {
            ForEach(Period.allCases, id: \.self) { item in
                Text(item.value)
                    .onTapGesture {
                        onSelection(item)
                    }
                Divider()
            }
        }
    }
}

struct PeriodsSheet_Previews: PreviewProvider {
    static var previews: some View {
        PeriodsSheet { _ in
            
        }
    }
}
