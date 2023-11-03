//
//  CurrencyViewModel.swift
//  ExchangeApp
//
//  Created by Fabián Gómez Campo on 20/10/23.
//

import Foundation

struct ExchangeRatesResponse: Codable {
    let conversion_rates: [String: Double]
    let base_code: String
    let time_last_update_utc: String
}

class CurrencyViewModel: ObservableObject {
    @Published var amount: String = ""
    @Published var baseCurrency: String = "USD"
    @Published var targetCurrency: String = "EUR"
    @Published var rate: Double = 0.9
    @Published var result: String = "Resultado de la conversión aparecerá aquí"
    @Published var history: [String] = []
    
    
    static let shared = CurrencyViewModel()
    
    let apiKey = "3864f5124fdcc3feaa3850c5"
    
    
    func fetchRate() {
        guard let url = URL(string:   "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/\(baseCurrency)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ExchangeRatesResponse.self, from: data)
                    DispatchQueue.main.async {
                        //print(response.conversion_rates)
                        self.rate = response.conversion_rates[self.targetCurrency] ?? 00
                        self.convert() // llama a aconvertir despues de actualizar la tasa
                    }
                } catch {
                    print("Error decoding json \(error)")
                }
            }
        }.resume()
    }
    
    
    func convert() {
        guard let amountValue = Double(amount) else {
            result = "Introduce una cantidad valida"
            return
        }
        
        let convertedAmount = amountValue * rate
       // result = "\(amountValue) \(baseCurrency) = \(convertedAmount) \(targetCurrency)"
        result = "\(convertedAmount) \(targetCurrency)"
    }
    
    
}

