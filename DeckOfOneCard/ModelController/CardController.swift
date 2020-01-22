//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Uzo on 1/18/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class CardController {
    
    // expect a result of type Card or CardError
    /// Globally accessible function for fetching a Card object
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        // the gas station is the internet and it is giving us a card
        // 1 - URL
        // checking to see that that is gas station - main thread
        guard let finalURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1") else { return
            // at this point this signifies wrong URL
            completion(.failure(.invalidURL))}
        
        // 2 - Go to Internet
        // method signature is
        // URLSession.shared.dataTask(with: finalURL) {}.resume()
        // the main thread sees the method signature
        // the thing in the {}.resume is a closure
        // withut .resume() it won't get sent to the internet
        URLSession.shared.dataTask(with: finalURL) {
            // URLSession.shared.dataTask => activates a background thread
            // everything from this point on is the background thread
            // the result of this is sent to the main thread which uses
            // the result to update the UI
            
            // data = data from server
            // _ = URLResponse from server (i.e 404)
            // erro =
            (data, _, error) in
            
            // 3 - handle error
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - unwrap and decode our data
            // if we get data keep running if not do continue running - just do noData
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                // 5 - decode our data
                let decoder = JSONDecoder()
                let deck = try decoder.decode(Deck.self, from: data)
                guard let card = deck.cards.first else {
                    return completion(.failure(.noCards))
                }
                // if card is found
                return completion(.success(card))
            } catch {
                // 6 - handle errors
                print(error, error.localizedDescription)
                return completion(.failure(.unableToDecodeData))
            }
        }.resume()
    }
    
    
    // fetch image
    static func fetchCardImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        
        // Step 1 - get the URL
        let cardImageURL = card.image
        
        // Step 2 - go the internet
        URLSession.shared.dataTask(with: cardImageURL) {  (data, _, error) in
            
            // step 3: - handle errors
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            // step 4: - unwrap the data
            // if no data, return with failure
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            // step 5 - use get the image
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecodeData)) }
            
            // step 6 - complete successfully with image
            completion(.success(image))
            
            
        }.resume()
    }
}
