//
//  ContentView.swift
//  DunyaGezgini
//
//  Created by Gulfem ALBAYRAK on 5.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var fahrenheitValue: String = ""
    @State var isVisible = false
    
    let numberFormatter: NumberFormatter = {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        numberFormater.minimumFractionDigits = 0
        numberFormater.maximumFractionDigits = 2
        return numberFormater
    }()
    
    func convertToCelsius() -> String {
        
        if let value = Double(fahrenheitValue) {
            let fahrenheit = Measurement<UnitTemperature>(value: value, unit: .fahrenheit)
            
            let celciusValue = fahrenheit.converted(to: .celsius)
            return numberFormatter.string(from: NSNumber(value: celciusValue.value)) ?? "???"
        } else {
            return "???"
        }
    }

    var body: some View {
        VStack {
            TextField("CONVERSION_TEXT_FIELD_PLACEHOLDER", text: $fahrenheitValue)
                .keyboardType(.decimalPad)
                .font(Font.system(size: 64.0))
                .multilineTextAlignment(.center)
            Text("CONVERSION_FAHRENHEIT")
            Text("CONVERSİON_IS_ACTUALLY")
                .foregroundStyle(.gray)
            Text(convertToCelsius())
                .font(Font.system(size: 64.0))
            Text("CONVERSION_DEGREES_CELCIUS")
            Spacer()
        }
        .font(.title)
        .foregroundColor(.orange)
        .opacity(isVisible ? 1.0 : 0.0)
        .offset(x: 0, y: isVisible ? 0 : 20)
        .animation(.easeIn(duration: 1.0))
        .onAppear {
            self.isVisible = true
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
