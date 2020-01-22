//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Uzo on 1/21/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    case invalidURL
    case noData
    case unableToDecodeData
    case thrownError(Error)
    case noCards
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server"
        case .noData:
            return "The Server responded with no data"
        case .unableToDecodeData:
            return "The server responded with bad data"
        case .thrownError(let error):
            return "\(error.localizedDescription)"
        case .noCards:
            return "The Server responsed with no cards"
        }
    }
}
