//
//  PokemonDetailView.swift
//  pokedexApp
//
//  Created by infra on 09/02/24.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            PokemonView(pokemon: pokemon)
            
            VStack(spacing: 10) {
                Text("**ID**: \(vm.pokemonDetails?.id ?? 0)")
                Text("**Weight**: \(vm.formatHW(value: vm.pokemonDetails?.weight ?? 0)) Kg")
                Text("**Height**: \(vm.formatHW(value: vm.pokemonDetails?.height ?? 0)) M")
            }
        }
        .onAppear {
            vm.getDetails(pokemon: pokemon)
        }
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon.samplePokemon)
        .environmentObject(ViewModel())
}
