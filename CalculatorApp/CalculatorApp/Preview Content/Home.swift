//
//  Home.swift
//  CalculatorApp
//
//  Created by infra on 13/02/24.
//

import SwiftUI

struct Home: View {
    
    @State var displayValue: String = "0"
    @State var computeValue = 0
    @State var currentOperator: Operations = .none
    @State var putFirstNumber: Bool = false
    
    let buttons: [[CalculatorButtons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                // Display
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(displayValue)
                            .font(.system(size: 100))
                            .foregroundStyle(.white)
                            .lineLimit(1)
                    }
                    .padding()
                }
                .gesture(DragGesture()
                            .onEnded { gesture in
                                if gesture.translation.width > 0 {
                                    // Handle left swipe (delete)
                                    deleteLastDigit()
                                }
                            }
                )
                
                // Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) {botao in
                            Button(action: {
                                didTap(button: botao)
                            }, label: {
                                if botao.rawValue == "0" {
                                    Text(botao.rawValue)
                                        .padding(.leading, 20)
                                    Spacer()
                                } else {
                                    Text(botao.rawValue)
                                }
                            })
                            .bold()
                            .font(.system(size: 32))
                            .frame(width: buttonWidth(item: botao), height: buttonHeight())
                            .background(botao.buttonColor)
                            .clipShape(.rect(cornerRadius: buttonHeight()/2))
                            .foregroundStyle(botao.textColor)
                        }
                    }.padding(.bottom, 3)
                }
            }
        }
    }
    
    func deleteLastDigit() {
        displayValue.removeLast()
    }
    
    func buttonWidth(item: CalculatorButtons) -> CGFloat {
        if item == .zero {
            return (UIScreen.main.bounds.width - (4 * 12)) / 4 * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func didTap(button: CalculatorButtons) {
        switch button {
        // Da pra melhorar muito esse case
        case .add, .subtract, .divide, .multiply, .equal:
            if button == .add {
                currentOperator = .add
                computeValue = Int(displayValue) ?? 0
            } else if button == .subtract {
                currentOperator = .subtract
                computeValue = Int(displayValue) ?? 0
            } else if button == .divide {
                currentOperator = .divide
                computeValue = Int(displayValue) ?? 0
            } else if button == .multiply {
                currentOperator = .multiply
                computeValue = Int(displayValue) ?? 0
            } else if button == .equal {
                let runningValue = computeValue
                let currentValue = Int(displayValue) ?? 0
                switch currentOperator {
                case .add:
                    displayValue = "\(runningValue + currentValue)"
                case .subtract:
                    displayValue = "\(runningValue - currentValue)"
                case .divide:
                    displayValue = "\(runningValue / currentValue)"
                case .multiply:
                    displayValue = "\(runningValue * currentValue)"
                case .none:
                    break
                }
            }
            
            if button != .equal {
//                displayValue = "0"
                putFirstNumber.toggle()
            }
        case .clear:
            displayValue = "0"
        case .decimal, .negative, .percent:
            break
        default:
            if putFirstNumber {
                displayValue = "0"
                putFirstNumber.toggle()
            }
            let number = Int(button.rawValue) ?? 0
            if Int(displayValue) == 0 {
                displayValue = "\(number)"
                print("Entrou")
            } else {
                displayValue = displayValue + "\(number)"
            }
        }
    }
}

#Preview {
    Home()
}
