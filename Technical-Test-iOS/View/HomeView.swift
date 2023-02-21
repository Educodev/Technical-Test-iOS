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
    @State var sectionSegment = 0
    
    var body: some View {
        
        NavigationView {
            //I use the ternary operator to reuse the progressview and only change the position depending on whether the beers array is empty or loaded
            ZStack(alignment: viewModel.refreshPosition == 0 ? .center : .bottom) {
                List (!viewModel.searchText.isEmpty ? viewModel.beersByName : viewModel.beers) { beer in
                    NavigationLink(destination: {
                        DetailView(beer: beer)
                    }, label: {
                        HStack  {
                            if let urlString = beer.imageURL {
                                AsyncImage(url: URL(string: urlString)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                 ProgressView()
                                }
                                .padding(8)
                                .frame(width: 70, height: 70)
                                .background(RadialGradient(colors: [.clear, .gray.opacity(0.5)] , center: .center, startRadius: 14, endRadius: 60))
                                .cornerRadius(10, antialiased: true)
                                .shadow(radius: 6)
                            } else {
                                Image(systemName: "photo")
                                    .padding(8)
                                    .frame(width: 70, height: 70)
                                    .background(RadialGradient(colors: [.clear, .gray.opacity(0.5)] , center: .center, startRadius: 14, endRadius: 60))
                                    .cornerRadius(10, antialiased: true)
                                    .shadow(radius: 6)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(beer.name)
                                    .font(.system(size: 18, design: .rounded))
                                    .lineLimit(2)
                                Text(beer.tagline)
                                    .font(.caption)
                                
                                Divider()
                                
                                HStack {
                                    Text("Levadura: \(beer.ingredients.yeast)")
                                        .font(.caption2)
                                       
                                    Spacer()
                                   
                                    Text("Creado: \(beer.firstBrewed)")
                                        .font(.caption2)     
                                }
                                .foregroundColor(.gray)
                                
                            }
                                
                        }
                       
                    })
                    .listRowSeparator(.hidden)
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
                .listStyle(.plain)
                //This is so that when it is loading it makes a small jump and you can see the progressview
                .offset(y: viewModel.isLoad ? -5 : 0)
                .onAppear {
                    withAnimation {
                        //to charge only once
                        if viewModel.beers.isEmpty {
                            viewModel.loadBeers(.none)
                        }
                    }
                }
                .searchable(text: $viewModel.searchText)
                .onChange(of: viewModel.searchText) { newValue in
                    if !viewModel.searchText.isEmpty {
                        withAnimation {
                            viewModel.loadBeers(sectionSegment == 0 ? .foodName(newValue) : .beerName(newValue))
                        }
                    }
                }
                
                if viewModel.beers.isEmpty || viewModel.isLoad  {
                    ProgressView()
                }
            }
            .navigationTitle("Cervezas")
            .toolbar {
                Picker("Buscar por", selection: $sectionSegment) {
                               Text("Alimento").tag(0)
                               Text("Nombre").tag(1)
                               
                           }
                           .pickerStyle(.segmented)
            }
        }
    }
}

