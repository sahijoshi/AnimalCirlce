//
//  DataProvider.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 16.4.2021.
//

import Foundation

class DataProvider {
    static func dataTiger() -> [String: String] {
        var data = [String: String]()
        data["name"] = "Tiger"
        data["detail"] = """
Tigers generally gain independence at around two years of age and attain sexual maturity at age three or four for females and four or five years for males.

Juvenile mortality is high, however—about half of all cubs do not survive more than two years. Tigers have been known to reach up to 20 years of age in the wild.
"""
        data["status"] = "Endangered"
        data["classification"] = "Vertibrate"
        data["diet"] = "Carnivore"
        data["lifeSpan"] = "8 - 10 years"
        data["height"] = "70 - 120 cm (Adult)"
        data["weight"] = " Male: 90 - 310 kg (Adult), Female: 65 - 170 kg (Adult)"
        data["habitat"] = "Grasslands, savannas, temperate forests, mangrove swamps, evergreen forests, and Tropical rainforests"
        return data
    }
}
