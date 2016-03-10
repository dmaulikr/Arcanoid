//
//  BarraJogador.swift
//  Arcanoid
//
//  Created by pucpr on 26/09/15.
//  Copyright (c) 2015 pucpr. All rights reserved.
//

import Foundation
import SpriteKit

class BarraJogador : SKSpriteNode
{
    private var velocidade: CGFloat = 150.0
    var direcao : CGFloat = 0
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.density = 1.0
        physicsBody?.mass = 10000000000
        physicsBody?.restitution = 1.0
        physicsBody?.categoryBitMask       = collision_jogador
        physicsBody?.contactTestBitMask  	= collision_bola
        physicsBody?.collisionBitMask = collision_all
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: NSTimeInterval)
    {        
        self.physicsBody?.velocity.dx = (velocidade) * direcao;
    }
    
}

