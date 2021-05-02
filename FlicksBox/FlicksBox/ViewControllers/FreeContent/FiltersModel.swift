//
//  FiltersModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 19.04.2021.
//

import Foundation

protocol Filter {
    var name: String { get }
}

struct Country: Filter {
    let id: Int?
    let name: String

    init(from country: APICountry) {
        self.init(id: country.id, name: country.name)
    }

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init(name: String) {
        self.name = name
        self.id = nil
    }
}

struct Genre: Filter {
    let id: Int?
    let name: String

    init(from genre: APIGenre) {
        self.init(id: genre.id, name: genre.name)
    }

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init(name: String) {
        self.name = name
        self.id = nil
    }
}

struct Year: Filter {
    let value: Int?
    let name: String

    init(_ value: Int) {
        self.value = value
        self.name = String(value)
    }

    init(name: String) {
        self.name = name
        self.value = nil
    }
}

final class FiltersModel: NSObject {
    private let genresInteractor = GenresInteractor()
    private let countriesInteractor = CountriesInteractor()

    func loadGenres(success: @escaping ([Genre]) -> Void, failure: @escaping (String) -> Void) {
        genresInteractor.allGenres() { response in
            success(self.trasformate(genres: response.body?.genres ?? []))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }

    func loadCountries(success: @escaping ([Country]) -> Void, failure: @escaping (String) -> Void) {
        countriesInteractor.allCountries() { response in
            success(self.trasformate(countries: response.body?.countries ?? []))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }

    private func trasformate(genres: [APIGenre]) -> [Genre] {
        genres.map { genre -> Genre in
            Genre(from: genre)
        }
    }

    private func trasformate(countries: [APICountry]) -> [Country] {
        countries.map { country -> Country in
            Country(from: country)
        }
    }
}
