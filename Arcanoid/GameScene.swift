//
//  GameScene.swift
//  Arcanoid
//
//  Created by pucpr on 12/09/15.
//  Copyright (c) 2015 pucpr. All rights reserved.
//

import SpriteKit
import Darwin

class GameScene: SKScene {
    private var menuTitle: SKLabelNode!
    private var novoJogo: SKLabelNode!
    private var sobre: SKLabelNode!
    private var sair: SKLabelNode!
    
    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        /* Setup your scene here */
        menuTitle = SKLabelNode(fontNamed: "KenPixel Mini")
        menuTitle.fontSize = 36;
        menuTitle.position.y = frame.size.height - 50
        menuTitle.position.x = frame.size.width/2
        menuTitle.text = "Arcanoide"
        menuTitle.fontColor = UIColor.greenColor()
        addChild(menuTitle)
        
        novoJogo = SKLabelNode(fontNamed: "KenPixel Mini")
        novoJogo.fontSize = 25
        novoJogo.position.y = frame.size.height - 100
        novoJogo.position.x = frame.size.width/2
        novoJogo.text = "Novo jogo"
        addChild(novoJogo)
        
        sobre = SKLabelNode(fontNamed: "KenPixel Mini")
        sobre.fontSize = 25
        sobre.position.y = frame.size.height - 150
        sobre.position.x = frame.size.width/2
        sobre.text = "Sobre"
        addChild(sobre)
        
        sair = SKLabelNode(fontNamed: "KenPixel Mini")
        sair.fontSize = 25
        sair.position.y = frame.size.height - 200
        sair.position.x = frame.size.width/2
        sair.text = "Sair"
        addChild(sair)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            var newScene: SKScene?
            if novoJogo.containsPoint(location) {
                novoJogo.fontColor = UIColor.redColor()
                newScene = Jogo(size: self.size)
            } else if sobre.containsPoint(location) {
                sobre.fontColor = UIColor.redColor()
                newScene = About(size: self.size)
            } else if sair.containsPoint(location) {
                sair.fontColor = UIColor.redColor()
                exit(0)
                //newScene = Menu03(size: self.size)
            }
            if let scene = newScene {
                scene.scaleMode = .AspectFill
                self.view!.presentScene(scene, transition: SKTransition.crossFadeWithDuration(0.5))
//                self.view!.presentScene(scene)
            }
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
