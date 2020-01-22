//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Uzo on 1/18/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var SuitAndValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction func drawCardButtonTapped(_ sender: UIButton) {
        // result of hitting DrawCardButton
        CardController.fetchCard { (result) in
            
            // go back to the main thread to update the UI
            DispatchQueue.main.async {
                //do different things depending on waht is inside the result
                switch result {
                    
                    //if we get a card back
                    case .success(let card):
                        self.fetchImageAndUpdateUI(for: card)
                    
                    case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    // MARK:- Custom Methods
    func fetchImageAndUpdateUI(for card: Card) {
        CardController.fetchCardImage(for: card) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                    case .success(let image):
                        self.SuitAndValueLabel.text = card.suit + " " + card.value
                        self.cardImageView.image = image
                    
                    case .failure(let error):
                        print(error, error.localizedDescription)
                }
            }
        }
    }
}
