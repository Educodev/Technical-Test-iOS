//
//  HomeView.swift
//  Technical-Test-iOS
//
//  Created by Eduardo Herrera on 20/2/23.
//

import SwiftUI

struct HomeView: View {
    //viewModel reference
    @EnvironmentObject var viewModel: ViewModelApp
    
    var body: some View {
        
        NavigationView {
            //I use the ternary operator to reuse the progressview and only change the position depending on whether the beers array is empty or loaded
            ZStack(alignment: viewModel.refreshPosition == 0 ? .center : .bottom) {
                List (!viewModel.searchText.isEmpty ? viewModel.beersByName : viewModel.beers) { beer in
                    Text(String(beer.id)+" "+beer.name)
                        .onAppear {
                            //When I scroll through the list and the last element of the beers array appears, then the method will be loaded again but with one more page
                            if beer.id == viewModel.beers.count {
                                //so as not to call the method while it is making a request to the server and this generates problems, then I tell it with a conditional that the method should not be called until the call that we have previously made stops loading
                                if !viewModel.isLoad {
                                    viewModel.loadBeers(.none)
                                }
                            }
                        }
                }
                //This is so that when it is loading it makes a small jump and you can see the progressview
                .offset(y: viewModel.isLoad ? -5 : 0)
                .onAppear {
                    withAnimation {
                        viewModel.loadBeers(.none)
                    }
                }
                .searchable(text: $viewModel.searchText)
                .onChange(of: viewModel.searchText) { newValue in
                    if !viewModel.searchText.isEmpty {
                        withAnimation {
                            viewModel.loadBeers(.beerName(newValue))
                        }
                    }
                }
                
                if viewModel.beers.isEmpty || viewModel.isLoad  {
                    ProgressView()
                }
            }
            .navigationTitle("Cervezas")
        }
    }
}

