//
//  ContentView.swift
//  TicTacToe
//
//  Created by infra on 14/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var buttons: [ButtonModel] = [
        ButtonModel(posX: -105, posY: -105, text: .none), ButtonModel(posX: 0, posY: -105, text: .none), ButtonModel(posX: 105, posY: -105, text: .none),
        ButtonModel(posX: -105, posY: 0, text: .none), ButtonModel(posX: 0, posY: 0, text: .none), ButtonModel(posX: 105, posY: 0, text: .none),
        ButtonModel(posX: -105, posY: 105, text: .none), ButtonModel(posX: 0, posY: 105, text: .none), ButtonModel(posX: 105, posY: 105, text: .none)
    ]
    
    @State var turn: Turn = .x
    
    @State var jogadasX: [Int] = []
    @State var jogadasO: [Int] = []
    
    @State var ganhou: Bool = false
    @State var ganhador: Turn = .none
    
    var body: some View {
        VStack {
            
            Text("TURN")
                .font(.system(size: 50))
            Text(turn.rawValue)
                .font(.system(size: 50))
                .bold()
            
            if ganhou {
                ZStack {
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill()
//                        .foregroundStyle(.green)
//                        .frame(width: 200, height: 40)
                    Text("WINNER: \(ganhador.rawValue)")
                        .font(.system(size: 32))
                        .foregroundStyle(.green)
                }
                
                Button(action: {
                    resetGame()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.green)
                            .frame(width: 200, height: 40)
                        Text("Restart")
                            .bold()
                            .font(.system(size: 32))
                            .foregroundStyle(.white)
                    }
                })
            }
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .fill(.black)
                    .frame(width: 300, height: 300)
                ForEach($buttons.indices, id: \.self) { index in
                    Button(action: {
                        if buttons[index].text == .none && !ganhou {
                            registraJogada(index: index)
                            if turn == .x {
                                jogadasX.append(index)
                            } else {
                                jogadasO.append(index)
                            }
                            ganhador = checkGanhador()
                            atualizaTurn()
                        }
                    }, label: {
                        ZStack {
                            Rectangle()
                                .fill(.white)
                            Text(buttons[index].text.rawValue)
                                .font(.system(size: 40))
                                .foregroundStyle(.gray)
                                .bold()
                        }
                    })
                    .frame(width: 100, height: 100)
                    .offset(x: buttons[index].posX, y: buttons[index].posY)
                }
            }
            Spacer()
        }
    }
    
    func atualizaTurn() {
        switch turn {
        case .x:
            turn = .o
        case .o:
            turn = .x
        case .none:
            break
        }
    }
    
    func registraJogada(index: Int) {
        buttons[index].text = turn
    }
    
    func checkGanhador() -> Turn {
        let gabaritos: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            [0, 4, 8], [2, 4, 6],
            [0, 3, 6], [1, 4, 7], [2, 5, 8]
        ]
        
        for gabarito in gabaritos {
            let ganhador = checkIndexes(gabarito: gabarito)
            if ganhador != .none {
                ganhou.toggle()
                return ganhador
            }
        }
        return .none
    }
    
    func checkIndexes(gabarito: [Int]) -> Turn {
        var xCounter = 0
        var oCounter = 0
        for indice in gabarito {
            if jogadasX.contains(indice) {
                xCounter += 1
            }
            else if jogadasO.contains(indice) {
                oCounter += 1
            }
        }
        if xCounter == 3 {
            return .x
        } else if oCounter == 3 {
            return .o
        }
        return .none
    }
    
    func resetGame() {
        buttons = [
            ButtonModel(posX: -105, posY: -105, text: .none), ButtonModel(posX: 0, posY: -105, text: .none), ButtonModel(posX: 105, posY: -105, text: .none),
            ButtonModel(posX: -105, posY: 0, text: .none), ButtonModel(posX: 0, posY: 0, text: .none), ButtonModel(posX: 105, posY: 0, text: .none),
            ButtonModel(posX: -105, posY: 105, text: .none), ButtonModel(posX: 0, posY: 105, text: .none), ButtonModel(posX: 105, posY: 105, text: .none)
        ]
        
        turn = .x
        
        jogadasO = []
        jogadasX = []
        
        ganhou = false
        
        ganhador = .none
    }
}

#Preview {
    ContentView()
}
