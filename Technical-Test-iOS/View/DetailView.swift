//
//  DetailView.swift
//  Technical-Test-iOS
//
//  Created by Eduardo Herrera on 20/2/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var scheme
    
    
    let beer: Beer
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            ScrollView {
                VStack {
                    GeometryReader { proxy in
                        let width = proxy.frame(in: .global).width
                        let offset = proxy.frame(in: .global).minY
                        
                        if let urlString = beer.imageURL {
                            AsyncImage(url: URL(string: urlString)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Image(systemName: "photo.fill")
                            }
                            .padding(60)
                            .frame(width: width, height:  offset > 0 ? width+offset : width)
                            .background(RadialGradient(colors: [.clear, .gray] , center: .center, startRadius: 45, endRadius: 180))
                            .cornerRadius(30, antialiased: true)
                            .shadow(radius: 6)
                            .offset(y: -offset)
                            
                            
                        } else {
                            Image(systemName: "photo")
                                .frame(width: width, height: width)
                                .background(Color.gray.opacity(0.5))
                        }
                        
                    }
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text(beer.name)
                                .font(.system(size: 23))
                            
                            
                            Text(beer.description)
                                .font(.caption)
                            
                            
                        }
                        .padding()
                        
                        Text("Ingredientes")
                            .font(.title)
                            .padding()
                        
                        Divider()
                        
                        GroupBox("Malta") {
                            ForEach(Array(beer.ingredients.malt.enumerated()), id: \.offset) {index, malt in
                                HStack {
                                    Text(String(index+1)+" ")
                                    Text(malt.name ?? "desconocido")
                                    
                                    Spacer()
                                    Text(String(malt.amount?.value ?? 0.0)) +
                                    Text( malt.amount?.unit ?? "--")
                                        .font(.caption)
                                }
                            }
                        }
                        
                        
                        GroupBox("Lupúlo") {
                            ForEach(Array(beer.ingredients.hops.enumerated()), id: \.offset) {index, hop in
                                HStack {
                                    Text(String(index+1)+" ")
                                    Text(hop.name ?? "desconocido")
                                    Spacer()
                                
                                    Text(String(hop.amount?.value ?? 0.0)) +
                                    Text( hop.amount?.unit ?? "--")
                                        .font(.caption)
                                }
                            }
                        }
                        
                        Divider()
                        
                        Text("Alimentos")
                            .font(.title)
                            .padding()
                        
                        GroupBox {
                            VStack(alignment:.leading) {
                                ForEach(Array(beer.foodPairing.enumerated()), id: \.offset) {_, food in
                                    HStack {
                                        Text(food)
                                        
                                    }
                                }

                            }
                        }
                        
                        
                    }
                    .padding([.bottom, .horizontal])
                    .background(scheme == .dark ? .black : .white)
                    .cornerRadius(10)
                    .padding(.top, UIScreen.main.bounds.width )
                    
                }
                
                
                Spacer(minLength: 100)
                
            }
            
            Button {
                dismiss.callAsFunction()
            } label: {
                Image(systemName: "arrow.backward.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .shadow(radius: 8)
                    .tint(.primary)
            }.padding(30)
            
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        
    }
}

