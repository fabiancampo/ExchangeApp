//
//  ContentView.swift
//  ExchangeApp
//
//  Created by Fabián Gómez Campo on 20/10/23.
//

import SwiftUI




struct ContentView: View {

    
    @ObservedObject var viewModel = CurrencyViewModel.shared
    private let currencies = ["USD", "EUR", "JPY", "CAD"]

    @State private var animateGradient: Bool = false
    
    var body: some View {
        
        
        NavigationStack {
            ZStack {
                LinearGradient(colors:[Color.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                     
                
                Form {
                    Group {
                        Section(header: Text("Cantidad")) {
                            HStack {
                                switch(viewModel.baseCurrency) {
                                case "USD": Image(systemName: "dollarsign.circle")
                                case "EUR": Image(systemName: "eurosign.circle")
                                case "CAD": Text("C").padding(.trailing, -5); Image(systemName: "dollarsign.circle")
                                case "YEN": Image(systemName: "yensign.circle")
                                default:
                                    Image(systemName: "eurosign.circle")
                                }
                                TextField("Introduce la cantidad", text: $viewModel.amount).keyboardType(.numberPad).onChange(of: viewModel.amount) {
                                    viewModel.fetchRate()
                                }
                                
                            }
                            
                            Picker("Select a Currency", selection: $viewModel.baseCurrency) {
                                ForEach(currencies, id: \.self) { currency in
                                    Text(currency)
                                }
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: viewModel.baseCurrency) {
                                viewModel.fetchRate()
                            }
                            
                        }
                        
                        Section(header: Text("Convertir a")) {
                            Picker("Selecciona Moneda", selection: $viewModel.targetCurrency) {
                                ForEach(currencies, id: \.self) { currency in
                                    Text(currency)
                                }
                            }
                            
                            .onChange(of: viewModel.targetCurrency) {
                                print(viewModel.targetCurrency)
                                viewModel.fetchRate()
                            }
                        }
                        
                        Section(header: Text("Conversión")) {
                            
                            HStack {
                                switch(viewModel.targetCurrency) {
                                case "USD": Image(systemName: "dollarsign.circle")
                                case "EUR": Image(systemName: "eurosign.circle")
                                case "CAD": Text("C").padding(.trailing, -5); Image(systemName: "dollarsign.circle")
                                case "YEN": Image(systemName: "yensign.circle")
                                default:
                                    Image(systemName: "eurosign.circle")
                                }
                                
                                
                                Text(viewModel.result)
                                
                            }
                            
                        }
                    } // Group
                    .listRowBackground(Rectangle()
                        .background(Color.clear)
                        .opacity(0.3)
                        )
                    
                }
                
                .background(.ultraThinMaterial)
                .scrollContentBackground(.hidden)
                
                .navigationTitle("Conversor")
            }
        }
    }

    
 
}

#Preview {
    ContentView()
}
