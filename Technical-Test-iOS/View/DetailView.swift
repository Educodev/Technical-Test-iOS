//
//  DetailView.swift
//  Technical-Test-iOS
//
//  Created by Eduardo Herrera on 20/2/23.
//

import SwiftUI

struct DetailView: View {
    let beer: Beer
    var body: some View {
        
        VStack {
            if let urlString = beer.imageURL {
                AsyncImage(url: URL(string: urlString)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(systemName: "photo.fill")
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .background(Color.gray.opacity(0.5))
                    
            } else {
                Image(systemName: "photo")
            }
            Text(beer.name)
        }
    }
}

