//
//  ButtonModel.swift
//  TicTacToe
//
//  Created by infra on 14/02/24.
//

import SwiftUI

struct ButtonModel: Hashable {
    var posX: CGFloat
    var posY: CGFloat
    var text: Turn
}

enum Turn: String {
    case none = ""
    case x = "X"
    case o = "O"
}
