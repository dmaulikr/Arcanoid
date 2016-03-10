//
//  Bola.swift
//  Arcanoid
//
//  Created by pucpr on 26/09/15.
//  Copyright (c) 2015 pucpr. All rights reserved.
//

import Foundation
import SpriteKit

class Bola : SKSpriteNode{
    
    var Velocidade: CGFloat = 200.0
    var velocidadeMinimaDimensao: CGFloat = 15.0
    var impulso: CGFloat = 80.0
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.setScale(0.2)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        //self.physicsBody?.density = 1.0
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.mass = 1
        self.physicsBody?.velocity = CGVector(dx: 100.0, dy: 100.0)
        
        self.physicsBody?.categoryBitMask = collision_bola
        self.physicsBody?.contactTestBitMask = collision_all
        self.physicsBody?.collisionBitMask = collision_all
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: NSTimeInterval)
    {
        self.physicsBody?.velocity.setLength(Velocidade)
        
        
        var vX = self.physicsBody?.velocity.dx
        var vY = self.physicsBody?.velocity.dy
        if (abs(vX!) < velocidadeMinimaDimensao){
            self.physicsBody?.applyImpulse(CGVector(dx: impulso * (vX! / abs(vX!)), dy: 0.0))
//            self.physicsBody?.velocity.dx = velocidadeMinimaDimensao * (vX! / abs(vX!))
        }
        
        if (abs(vY!) < velocidadeMinimaDimensao)
        {
            self.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: impulso * (vY! / abs(vY!))))
            //self.physicsBody?.velocity.dy = velocidadeMinimaDimensao * (vY! / abs(vY!))
        }
        
    }
}