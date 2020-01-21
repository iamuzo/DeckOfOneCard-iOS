//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Uzo on 1/18/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

struct Card: Codable {
    var suit: String
    var value: String
    var image: URL
}
