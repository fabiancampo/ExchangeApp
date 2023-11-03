//
//  HistoryView.swift
//  ExchangeApp
//
//  Created by Fabián Gómez Campo on 3/11/23.
//

import SwiftUI

struct HistoryView: View {
    
    var viewModel: CurrencyViewModel
    
    var body: some View {
        
        NavigationView {
            Group {
                if viewModel.history.isEmpty {
                    Text("Aquí se mostrará tu historial")
                        .font(.largeTitle)
                }
                List {
                    ForEach(viewModel.history, id: \.self) { history in
                        Text(history)
                    }
                }
            }
            .navigationTitle("Historial")

        }
    }
}

#Preview {
    
    HistoryView(viewModel: CurrencyViewModel())
}
