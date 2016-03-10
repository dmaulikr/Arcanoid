//
//  GameScene.swift
//  Arcanoid
//
//  Created by pucpr on 12/09/15.
//  Copyright (c) 2015 pucpr. All rights reserved.
//

import SpriteKit

class About: SKScene {
    private var titulo: SKLabelNode!
    private var texto: SKLabelNode!
    private var texto1: SKLabelNode!
    private var voltar: SKLabelNode!
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        /* Setup your scene here */
        titulo = SKLabelNode(fontNamed: "KenPixel Mini")
        titulo.fontSize = 48;
        titulo.position.y = frame.size.height-40
        titulo.position.x = frame.size.width/2
        titulo.text = "About"
        titulo.fontColor = UIColor.blueColor()
        addChild(titulo)
        
        
        texto = SKLabelNode(fontNamed: "KenPixel Mini")
        texto.fontSize = 25;
        texto.position.y = frame.size.height - 100
        texto.position.x = frame.size.width/2
        texto.text = "Desenvolvido por"
        texto.fontColor = UIColor.greenColor()
        addChild(texto)
        
        texto1 = SKLabelNode(fontNamed: "KenPixel Mini")
        texto1.fontSize = 25;
        texto1.position.y = frame.size.height - 130
        texto1.position.x = frame.size.width/2
        texto1.text = "Renan Fagundes"
        texto1.fontColor = UIColor.greenColor()
        addChild(texto1)
        
        voltar = SKLabelNode(fontNamed: "KenPixel Mini")
        voltar.fontSize = 25
        voltar.position.y = 30
        voltar.position.x = 40
        voltar.text = "Back"
        voltar.fontColor = UIColor.blueColor()
        addChild(voltar)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            if voltar.containsPoint(location) {
                self.view?.presentScene(GameScene(size: self.size), transition: SKTransition.crossFadeWithDuration(0.5))
            }
        }
        
    }

    
}
