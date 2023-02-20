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
    @Published var beersByName: Beers = []
    @Published var page = 1
    @Published var refreshPosition = 0
    @Published var isLoad = false
    @Published var searchText = ""
    
    func loadBeers(_ parameters: Parameters) {
        
        Task {
            do {
                if searchText.isEmpty {
                    //indicates that the data is being loaded
                    isLoad.toggle()
                    //The service container will be incremented every time we make a call to the server
                    self.beers += try await getBeers(page, otherParameters: parameters)
                    
                    //page increment
                    page+=1
                    //I set the value so that the view knows where to position the progressview
                    refreshPosition = 1
                    //indicates that the data has already been loaded
                    isLoad.toggle()
                } else {
                    //displays 80 results related to the characters entered in the search bar
                    self.beersByName = try await getBeers(perPage: 80, otherParameters: parameters)
                }
            } catch let error {
                let servicesError = error as! ServicesError
                //Show error in a alertView
            }
        }
    }
    
}
