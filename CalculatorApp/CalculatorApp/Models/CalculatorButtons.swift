//
//  CalculatorButtons.swift
//  CalculatorApp
//
//  Created by infra on 13/02/24.
//

import SwiftUI

enum CalculatorButtons: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case subtract = "-"
    case add = "+"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .divide, .multiply, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1))
        }
    }
    
    var textColor: Color {
        switch self {
        case .clear, .negative, .percent:
            return Color.black
        default:
            return Color.white
        }
    }
}

enum Operations {
    case add, subtract, divide, multiply, none
}
