//
//  SldierFromUIKit.swift
//  NewTry
//
//  Created by Станислав Климов on 01.08.2020.
//  Copyright © 2020 Stanislav Klimov. All rights reserved.
//

import SwiftUI

struct SliderFromUIKit: UIViewRepresentable {
    
    @Binding var sliderValue: Float
    @Binding var targetValue: Float
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        let alpha = CGFloat(1 - (targetValue - sliderValue)/100)
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = sliderValue
        slider.alpha = alpha
        slider.thumbTintColor = .blue
        slider.addTarget(context.coordinator,
                         action: #selector(Coordinator.valueChanging),
                         for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = sliderValue
        uiView.alpha = CGFloat(1-abs(targetValue-sliderValue)/100)
    }
    
    func makeCoordinator() -> SliderFromUIKit.Coordinator {
        Coordinator(value: $sliderValue, targetValue: $targetValue)
    }
}

extension SliderFromUIKit {
    class Coordinator: NSObject {
        @Binding var value: Float
        @Binding var targetValue: Float
        init(value: Binding<Float>, targetValue: Binding<Float>) {
            self._value = value
            self._targetValue = targetValue
        }
        
        @objc func valueChanging(_ sender: UISlider) {
            value = sender.value
        }
    }
}

struct SliderFromUIKit_Previews: PreviewProvider {
    static var previews: some View {
        SliderFromUIKit(sliderValue: .constant(50 ), targetValue: .constant(100))
    }
}
