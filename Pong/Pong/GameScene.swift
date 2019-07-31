//
//  GameScene.swift
//  Pong
//
//  Created by Labdhi Jain on 7/30/19.
//  Copyright © 2019 Labdhi Jain. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var mainScore = SKLabelNode()
    var enemyScore = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        mainScore = self.childNode(withName: "mainScore") as! SKLabelNode
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
       
//        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
        
        
        
    }
    
    func startGame(){
        
        score = [0,0]
        mainScore.text = "\(score[0])"
        enemyScore.text = "\(score[1])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        
        
    }
    
    func addScore(playerWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if playerWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        } else if playerWon == enemy{
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        
        mainScore.text = "\(score[0])"
        enemyScore.text = "\(score[1])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x
                , duration: 0.2))
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
         for touch in touches{
            let location = touch.location(in: self)
            
            if currentGameType == .player {
                print("two Player worked")
                if  location.y > 0{
                    enemy.run(SKAction.moveTo(x: location.x
                        , duration: 0.2))
                }
                if location.y < 0{
                    main.run(SKAction.moveTo(x: location.x
                        , duration: 0.2))
                }
            }else {
                main.run(SKAction.moveTo(x: location.x
                    , duration: 0.2))
            }
            
        }
        
        
    }
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        switch currentGameType {
        case  .player : print("")
        case  .easy : enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
        case  .medium : enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.6))
                    case .hard : enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0))
            print("hard")
        
       
        }
        
        
//        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
        // the duration is in seconds
        
        if ball.position.y <= main.position.y - 30{
            addScore(playerWon: enemy)
        }else if ball.position.y >= enemy.position.y + 30{
           addScore(playerWon: main)
        }
    }
}
