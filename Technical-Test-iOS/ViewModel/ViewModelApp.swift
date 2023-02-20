//
//  ViewModel.swift
//  Technical-Test-iOS
//
//  Created by Eduardo Herrera on 20/2/23.
//

import Foundation
import Combine
@MainActor
public class ViewModelApp: ObservableObject {
    @Published var beers: Beers = []
    func loadBears() {
        Task {
            do {
                //We pass the beers received from the server
                self.beers = try await getBeers(otherParameters: .none)
            } catch let error {
                let servicesError = error as! ServicesError
                //Show error in a alertView
            }
        }
    }
}
