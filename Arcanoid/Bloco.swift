//
//  Bloco.swift
//  Arcanoid
//
//  Created by pucpr on 03/10/15.
//  Copyright (c) 2015 pucpr. All rights reserved.
//

import Foundation
import SpriteKit

public enum TiposBlocos {
    case UmaPancada
    case DuasPancadas
    case TresPancadas
}
class Bloco : SKSpriteNode{
    var Vidas: UInt32 = 0
    
    init(tipo: TiposBlocos, location: CGPoint){
        var texture: SKTexture!
        switch (tipo)
        {
        case TiposBlocos.TresPancadas:
            Vidas = 3
            texture = SKTexture(imageNamed: "brickWall")
        case TiposBlocos.UmaPancada:
            Vidas = 1
            texture = SKTexture(imageNamed: "boxEmpty")
        case TiposBlocos.DuasPancadas:
            Vidas = 2
            texture = SKTexture(imageNamed: "boxExplosive")
        }
        super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
        name = "bloco"
        setScale(0.5)
        position = location
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.dynamic = false
        physicsBody?.categoryBitMask = collision_blocos
        physicsBody?.contactTestBitMask = collision_all
        physicsBody?.collisionBitMask = collision_all
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
