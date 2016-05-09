//
//  GameScene.swift
//  Spaceshooter
//
//  Created by Panth Patel on 20/04/16.
//  Copyright (c) 2016 Panth Patel. All rights reserved.
//

import SpriteKit
import UIKit

struct PhysicsCatagory {
    static let Enemy : UInt32 = 1 //000000000000000000000000000001
    static let Bullet : UInt32 = 2 //00000000000000000000000000010
    static let Player : UInt32 = 3 //00000000000000000000000000100
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var Highscore = 0
    var Score = 0
    var Player = SKSpriteNode(imageNamed: "pmissile.png")
    var ScoreLbl = UILabel()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let HighscoreDefault = NSUserDefaults.standardUserDefaults()
        if (HighscoreDefault.valueForKey("Highscore") != nil){
            
            Highscore = HighscoreDefault.valueForKey("Highscore") as! NSInteger
        }
        else {
            
            Highscore = 0
            
        }
        
        
        physicsWorld.contactDelegate = self
        
        self.scene?.backgroundColor = UIColor.blackColor()
        
        self.scene?.size = CGSize(width: 640, height: 1136)
        

        
        
        Player.position = CGPointMake(self.size.width / 2, self.size.height / 5)
        Player.physicsBody = SKPhysicsBody(rectangleOfSize: Player.size)
        Player.physicsBody?.affectedByGravity = false
        Player.physicsBody?.categoryBitMask = PhysicsCatagory.Player
        Player.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemy
        Player.physicsBody?.dynamic = false
        
        var Timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("SpawnBullets"), userInfo: nil, repeats: true)
        
        var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.15, target: self, selector: Selector("SpawnEnemies"), userInfo: nil, repeats: true)
        
        self.addChild(Player)
        
        
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        
        
        let firstBody : SKPhysicsBody = contact.bodyA
        let secondBody : SKPhysicsBody = contact.bodyB
        
        if (((firstBody.categoryBitMask == PhysicsCatagory.Enemy) && (secondBody.categoryBitMask == PhysicsCatagory.Bullet)) ||
            ((firstBody.categoryBitMask == PhysicsCatagory.Bullet) && (secondBody.categoryBitMask == PhysicsCatagory.Enemy))){
            
            if (firstBody.node != nil && secondBody.node != nil)
            {
                CollisionWithBullet(firstBody.node as! SKSpriteNode, Bullet: secondBody.node as! SKSpriteNode)
            }
            
        }
        else if ((firstBody.categoryBitMask == PhysicsCatagory.Enemy) && (secondBody.categoryBitMask == PhysicsCatagory.Player) ||
            (firstBody.categoryBitMask == PhysicsCatagory.Player) && (secondBody.categoryBitMask == PhysicsCatagory.Enemy)){
            
            if (firstBody.node != nil && secondBody.node != nil)
            {
                CollisionWithPerson(firstBody.node as! SKSpriteNode, Person: secondBody.node as! SKSpriteNode)
            }
            
            
        }
        
    }
    
    func CollisionWithBullet(Enemy: SKSpriteNode, Bullet:SKSpriteNode){
        Enemy.removeFromParent()
        Bullet.removeFromParent()
        Score++
        
        ScoreLbl.text = "\(Score)"
    }
    
    func CollisionWithPerson(Enemy:SKSpriteNode, Person: SKSpriteNode){
        let ScoreDefault = NSUserDefaults.standardUserDefaults()
        ScoreDefault.setValue(Score, forKey: "Score")
        ScoreDefault.synchronize()
        
        
        if (Score > Highscore){
            
            Highscore = Score
            let HighscoreDefault = NSUserDefaults.standardUserDefaults()
            HighscoreDefault.setValue(Score, forKey: "Highscore")
            
        }
        
        Enemy.removeFromParent()
        Person.removeFromParent()
        self.view?.presentScene(EndScene())
        ScoreLbl.removeFromSuperview()
        
        
        
    }
    
    
    
    
    
    
    func SpawnBullets(){
        let Bullet = SKSpriteNode(imageNamed: "BulletGalaga.png")
        Bullet.zPosition = -5
        
        Bullet.position = CGPointMake(Player.position.x, Player.position.y)
        
        let action = SKAction.moveToY(self.size.height + 30, duration: 0.3)
        let actionDone = SKAction.removeFromParent()
        Bullet.runAction(SKAction.sequence([action, actionDone]))
        
        Bullet.physicsBody = SKPhysicsBody(rectangleOfSize: Bullet.size)
        Bullet.physicsBody?.categoryBitMask = PhysicsCatagory.Bullet
        Bullet.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemy
        Bullet.physicsBody?.affectedByGravity = false
        Bullet.physicsBody?.dynamic = false
        self.addChild(Bullet)
    }
    
    func SpawnEnemies(){
        let Enemy = SKSpriteNode(imageNamed: "emissile.png")
        let MinValue = self.size.width / 13
        let MaxValue = self.size.width - -50
        
        let SpawnPoint = UInt32(MaxValue - MinValue)
        Enemy.position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)
        Enemy.physicsBody = SKPhysicsBody(rectangleOfSize: Enemy.size)
        Enemy.physicsBody?.categoryBitMask = PhysicsCatagory.Enemy
        Enemy.physicsBody?.contactTestBitMask = PhysicsCatagory.Bullet
        Enemy.physicsBody?.affectedByGravity = false
        Enemy.physicsBody?.dynamic = true
        
        
        
        let action = SKAction.moveToY(-70, duration: 0.7)
        let actionDone = SKAction.removeFromParent()
        Enemy.runAction(SKAction.sequence([action, actionDone]))
        
        self.addChild(Enemy)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            Player.position.x = location.x
            
            
            
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            Player.position.x = location.x
            
            
            
            
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
