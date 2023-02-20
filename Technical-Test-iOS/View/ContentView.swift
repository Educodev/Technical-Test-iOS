//
//  ContentView.swift
//  Technical-Test-iOS
//
//  Created by Eduardo Herrera on 20/2/23.
//

import SwiftUI

struct ContentView: View {
    //viewModel reference
    @EnvironmentObject var viewModel: ViewModelApp
    
    var body: some View {
        ZStack {
            List (viewModel.beers) { beer in
                Text(beer.name)
            }
            .onAppear {
                DispatchQueue.main.async {
                    viewModel.loadBears()
                }
                
        }
            
            if viewModel.beers.isEmpty {
                ProgressView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
