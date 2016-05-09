//
//  EndScene.swift
//  Spaceshooter
//
//  Created by Panth Patel on 20/04/16.
//  Copyright © 2016 Panth Patel. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene : SKScene {
    
    var RestartBtn : UIButton!
    
    var ScoreLbl : UILabel!
    var scorelabel : UILabel!
    var HighScoreLbl : UILabel!
    var highscorelabel : UILabel!
    var gameover : UILabel!
    override func didMoveToView(view: SKView) {
        scene?.backgroundColor = UIColor.blackColor()
        
        SKSceneScaleMode.Fill
        
        
        RestartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 242, height: 69))
        RestartBtn.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 1.2
        )
        
        
        
        
        
        RestartBtn.setTitle("TRY AGAIN", forState: UIControlState.Normal)
        RestartBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        RestartBtn.addTarget(self, action: Selector("Restart"), forControlEvents: UIControlEvents.TouchUpInside)
        RestartBtn.titleLabel!.font = UIFont.systemFontOfSize(30.0)
        
        RestartBtn.titleLabel?.textColor = UIColor.blackColor()
        RestartBtn.titleLabel!.font = UIFont.boldSystemFontOfSize(30)
        RestartBtn.backgroundColor = UIColor.redColor()
        self.view?.addSubview(RestartBtn)
        
        
        let ScoreDefault = NSUserDefaults.standardUserDefaults()
        let Score = ScoreDefault.valueForKey("Score") as! NSInteger
        ScoreDefault.synchronize()
        NSLog("\(Score)")
        
        
            
            let SecondDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            var Highscore = SecondDefaults.valueForKey("Highscore")?.integerValue ?? 0
            SecondDefaults.synchronize()
        
        if(Score > Highscore)
        {
            Highscore = Score
        }
        
        scorelabel = UILabel(frame: CGRect(x: 0, y: 0, width: 275, height: 114))
        scorelabel.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 2)
        scorelabel.text = "SCORE"
        scorelabel.font = scorelabel.font.fontWithSize(30)
        
        scorelabel.textColor = UIColor.redColor()
        self.view?.addSubview(scorelabel)
        
      
    
        
        
        ScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 120))
        ScoreLbl.center = CGPoint(x: view.frame.size.width / 1.1, y: view.frame.size.width / 2)
        ScoreLbl.text = "\(Score)"
        ScoreLbl.font = ScoreLbl.font.fontWithSize(30)
        ScoreLbl.textColor = UIColor.redColor()
        self.view?.addSubview(ScoreLbl)
        
        highscorelabel = UILabel(frame: CGRect(x: 0, y: 0, width: 275, height: 114))
        highscorelabel.center = CGPoint(x: view.frame.size.width / 2
            , y: view.frame.size.width / 1.5)
        highscorelabel.text = "HIGHSCORE"
        highscorelabel.font = highscorelabel.font.fontWithSize(30)
        highscorelabel.textColor = UIColor.redColor()
        self.view?.addSubview(highscorelabel)
        
        HighScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 120))
        HighScoreLbl.center = CGPoint(x: view.frame.size.width
            / 1.1, y: view.frame.size.width / 1.5)
        HighScoreLbl.text = "\(Highscore)"
        HighScoreLbl.font = HighScoreLbl.font.fontWithSize(30)
        HighScoreLbl.textColor = UIColor.redColor()
        self.view?.addSubview(HighScoreLbl)
        
        gameover = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 52))
        gameover.center = CGPoint(x: view.frame.size.width / 1.58, y: view.frame.size.width / 6)
        gameover.text = "GAME OVER"
        gameover.font = gameover.font.fontWithSize(40)
        gameover.textColor = UIColor.redColor()
        
        gameover.font = UIFont.boldSystemFontOfSize(40)
        self.view?.addSubview(gameover)
        
        
        NSLog("\(Highscore)")
        
        if (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            
            RestartBtn.titleLabel!.font = UIFont.boldSystemFontOfSize(38)
            
            
            scorelabel.center = CGPoint(x: view.frame.size.width / 3.8, y: view.frame.size.width / 2.5)
            scorelabel.font = scorelabel.font.fontWithSize(40) //iPad
            
            
            ScoreLbl.center = CGPoint(x: view.frame.size.width / 1.1, y: view.frame.size.width / 2.5)
            ScoreLbl.font = ScoreLbl.font.fontWithSize(40)
            
            
            
            highscorelabel.center = CGPoint(x: view.frame.size.width / 3.8, y: view.frame.size.width / 1.8)
            highscorelabel.font = highscorelabel.font.fontWithSize(40)
            
            
            HighScoreLbl.center = CGPoint(x: view.frame.size.width / 1.1, y: view.frame.size.width / 1.8)
            HighScoreLbl.font = HighScoreLbl.font.fontWithSize(40)
            
            gameover.center = CGPoint(x: view.frame.size.width / 1.9, y: view.frame.size.width / 6)
            gameover.font = UIFont.boldSystemFontOfSize(56)
            
            
        }
        
    }
    
    func Restart(){
        self.view?.presentScene(GameScene(), transition: SKTransition.crossFadeWithDuration(0.3))
        RestartBtn.removeFromSuperview()
        HighScoreLbl.removeFromSuperview()
        ScoreLbl.removeFromSuperview()
        scorelabel.removeFromSuperview()
        highscorelabel.removeFromSuperview()
        gameover.removeFromSuperview()
        
        if (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            self.view?.presentScene(GameScene(), transition: SKTransition.crossFadeWithDuration(0.3))
            RestartBtn.removeFromSuperview()
            HighScoreLbl.removeFromSuperview()
            ScoreLbl.removeFromSuperview()
            scorelabel.removeFromSuperview()
            highscorelabel.removeFromSuperview()
            gameover.removeFromSuperview()
        }
        
    }
    
}
