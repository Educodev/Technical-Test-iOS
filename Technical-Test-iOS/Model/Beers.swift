//
//  Beer.swift
//  Technical-Test-iOS
//
//  Created by Eduardo Herrera on 20/2/23.
//
//   let beers = try? JSONDecoder().decode(Beers.self, from: jsonData)

import Foundation

// MARK: - Beer
struct Beer: Codable, Identifiable {
    let id: Int
    let name: String
    //let tagline: String
    //let firstBrewed: String
    //let description: String
    //let imageURL: String
    //let abv: Double
    //let ibu: Double?
    //let targetFg: Int
    //let targetOg: Double
    //let ebc: Int?
    //let srm: Double?
    //let ph: Double?
    //let attenuationLevel: Double
    //let volume: BoilVolume
    //let boilVolume: BoilVolume
    //let method: Method
    //let ingredients: Ingredients
    //let foodPairing: [String]
    //let brewersTips: String
    //let contributedBy: ContributedBy

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
       //case tagline = "tagline"
       //case firstBrewed = "first_brewed"
       //case description = "description"
       //case imageURL = "image_url"
       //case abv = "abv"
       //case ibu = "ibu"
       //case targetFg = "target_fg"
       //case targetOg = "target_og"
       //case ebc = "ebc"
       //case srm = "srm"
       //case ph = "ph"
       //case attenuationLevel = "attenuation_level"
       //case volume = "volume"
       //case boilVolume = "boil_volume"
       //case method = "method"
       //case ingredients = "ingredients"
       //case foodPairing = "food_pairing"
       //case brewersTips = "brewers_tips"
       //case contributedBy = "contributed_by"
    }
}

// MARK: - BoilVolume
struct BoilVolume: Codable {
    let value: Double
    let unit: Unit

    enum CodingKeys: String, CodingKey {
        case value = "value"
        case unit = "unit"
    }
}

enum Unit: String, Codable {
    case celsius = "celsius"
    case grams = "grams"
    case kilograms = "kilograms"
    case litres = "litres"
}

enum ContributedBy: String, Codable {
    case aliSkinnerAliSkinner = "Ali Skinner <AliSkinner>"
    case samMasonSamjbmason = "Sam Mason <samjbmason>"
}

// MARK: - Ingredients
struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String

    enum CodingKeys: String, CodingKey {
        case malt = "malt"
        case hops = "hops"
        case yeast = "yeast"
    }
}

// MARK: - Hop
struct Hop: Codable {
    let name: String
    let amount: BoilVolume
    let add: Add
    let attribute: Attribute

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case amount = "amount"
        case add = "add"
        case attribute = "attribute"
    }
}

enum Add: String, Codable {
    case dryHop = "dry hop"
    case end = "end"
    case middle = "middle"
    case start = "start"
}

enum Attribute: String, Codable {
    case aroma = "aroma"
    case attributeFlavour = "Flavour"
    case bitter = "bitter"
    case flavour = "flavour"
}

// MARK: - Malt
struct Malt: Codable {
    let name: String
    let amount: BoilVolume

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case amount = "amount"
    }
}

// MARK: - Method
struct Method: Codable {
    let mashTemp: [MashTemp]
    let fermentation: Fermentation
    let twist: String?

    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation = "fermentation"
        case twist = "twist"
    }
}

// MARK: - Fermentation
struct Fermentation: Codable {
    let temp: BoilVolume

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
    }
}

// MARK: - MashTemp
struct MashTemp: Codable {
    let temp: BoilVolume
    let duration: Int?

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case duration = "duration"
    }
}

typealias Beers = [Beer]
