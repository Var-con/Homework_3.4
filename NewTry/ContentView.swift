//
//  ContentView.swift
//  NewTry
//
//  Created by Станислав Климов on 01.08.2020.
//  Copyright © 2020 Stanislav Klimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var currentValue: Float = 50
    @State private var targetValue: Float = 0
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Подвинь слайдер, как можно ближе к: \(Int(targetValue))")
            HStack {
                Text("0")
                SliderFromUIKit(sliderValue: $currentValue,
                                targetValue: $targetValue)
                Text("100")
            }
            Button(action: {
                self.targetValue = self.startGame()
            }) { Text("Начать заново!")}
                .padding()
            Button(action: {
                self.showAlert = true
            }) { Text("Проверь меня!")}
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Congratulations!"),
                          message: Text("Ваш результат: \(self.computeScore())"))
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    private func computeScore() -> Int {
        let difference = abs(Int(targetValue) - Int(currentValue))
        return 100 - difference
    }
    
    private func startGame() -> Float {
        return Float.random(in: 1...100)
    }
}
