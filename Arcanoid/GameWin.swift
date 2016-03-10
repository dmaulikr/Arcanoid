//
//  GameScene.swift
//  Arcanoid
//
//  Created by pucpr on 12/09/15.
//  Copyright (c) 2015 pucpr. All rights reserved.
//

import SpriteKit

class GameWin: SKScene {
    private var text: SKLabelNode!
    private var tempoFaltando: Double = 0
    private var tempoTotal: Double = 3
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        /* Setup your scene here */
        text = SKLabelNode(fontNamed: "KenPixel Mini")
        text.fontSize = 36;
        text.position.y = frame.size.height/2
        text.position.x = frame.size.width/2
        text.text = "Congratulations"
        text.fontColor = UIColor.greenColor()
        addChild(text)
        
        tempoFaltando = tempoTotal
        
    }
    var previous: NSTimeInterval!
    override func update(currentTime: NSTimeInterval) {
        if (previous != nil) {
            tempoFaltando = tempoFaltando - (currentTime - previous)
            if (tempoFaltando <= 0)
            {
                self.view?.presentScene(GameScene(size: self.size))
            }
        }
        previous = currentTime
    }
    
}
