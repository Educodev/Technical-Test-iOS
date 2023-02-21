//
//  Networking.swift
//  Technical-Test-iOS
//
//  Created by Eduardo Herrera on 20/2/23.
//

import Foundation

//MARK: list with possible errors
enum ServicesError: Error {
    case none
    case urlError
    case decodeJsonError
}

enum Parameters {
    case none
    case beerName(_: String)
    case foodName(_: String)
    
}

func getBeers(_ page: Int = 1, perPage: Int = 20, otherParameters: Parameters) async throws -> Beers {
    print(setupUrl(page, perPage, otherParameters))
    let baseUrl = setupUrl(page, perPage, otherParameters)
    guard let url = URL(string: baseUrl) else { throw ServicesError.urlError }
    let (data, _) = try await URLSession.shared.data(from: url)
    
    do {
        let randomBears = try JSONDecoder().decode(Beers.self, from: data)
        return randomBears
        
    } catch {
        //TODO: - remove this line of code after debugging
        //fatalError(error.localizedDescription)
        throw ServicesError.decodeJsonError
        
    }
}

fileprivate func setupUrl(_ page: Int, _ perPage: Int, _ otherParameters: Parameters) -> String {
    var urlString = "https://api.punkapi.com/v2/beers?page=\(page)&per_page=\(perPage)"
    switch otherParameters {
    case .none:
        return urlString
    case .beerName(let name):
        urlString+="&beer_name=\(name)"
    case .foodName(let name):
        urlString+="&food=\(name)"
    }
    return urlString
}

