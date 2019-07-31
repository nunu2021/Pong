//
//  MenuVC.swift
//  Pong
//
//  Created by Labdhi Jain on 7/30/19.
//  Copyright © 2019 Labdhi Jain. All rights reserved.
//

import Foundation
import UIKit

enum gameType{
    case easy
    case medium
    case hard
    case player
}

class MenuVC : UIViewController {
    
    
    @IBAction func player(_ sender: Any) {
    moveToGame(game: .player)
    }
    
    @IBAction func easy(_ sender: Any) {
        
        print("easy actually worked")
        moveToGame(game: .easy)
    }
    
    @IBAction func medium(_ sender: Any) {
        moveToGame(game: .medium)
    }
    
    @IBAction func hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game : gameType){
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
        
        print("this is frustrating")
        
        
    }
}
