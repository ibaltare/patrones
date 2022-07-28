//
//  HeroModel.swift
//  DesignPatterns
//
//  Created by Nicolas on 25/07/22.
//

import UIKit

struct HeroModel: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let favorite: Bool?
}
