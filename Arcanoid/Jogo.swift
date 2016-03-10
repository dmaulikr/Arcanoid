//
//  Jogo.swift
//  Arcanoid
//
//  Created by pucpr on 12/09/15.
//  Copyright (c) 2015 pucpr. All rights reserved.
//

import SpriteKit
let collision_nothing:          UInt32 = 0
let collision_jogador:          UInt32 = 1
let collision_bola:             UInt32 = 2
let collision_blocos:           UInt32 = 4
let collision_fase:             UInt32 = 8
let collision_chao:             UInt32 = 16
let collision_all:              UInt32 = UInt32.max

class Jogo : SKScene, SKPhysicsContactDelegate {
    private var vidasLabel: SKLabelNode!
    private var reinicioLabel: SKLabelNode!
    private var sair: SKLabelNode!
    private var vidas: UInt32 = 5
    private var pontos: UInt32 = 0
    private var blocosDestruidos: Int = 0
    
    private var numBlocosX: Int = 8
    private var numBlocosY: Int = 5
    private var larguraBloco = CGFloat(35)
    private var espacoBlocos = CGFloat(5)
    private var espacoBordaY = CGFloat(90)
    private var espacoBordaX = CGFloat(50)
    
    private var firstTouch: UITouch!
    
    var blocos = [SKSpriteNode]()
    var jogador : BarraJogador!
    var bola : Bola!
    var paredeEsquerda: SKSpriteNode!
    var paredeDireita: SKSpriteNode!
    var chao: SKSpriteNode!
    var teto: SKSpriteNode!
    var reiniciarBola: Bool = false
    var tempoReinicio: Double = 3
    var tempoFaltando: Double = 0
    
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        self.physicsWorld.contactDelegate = self
        
        vidasLabel = SKLabelNode(fontNamed: "KenPixel Mini")
        vidasLabel.fontSize = 24;
        vidasLabel.position.y = frame.size.height - 30
        vidasLabel.position.x = 60
        vidasLabel.text = "Vidas: " + String(vidas)
        vidasLabel.fontColor = UIColor.greenColor()
        addChild(vidasLabel)
        
        reinicioLabel = SKLabelNode(fontNamed: "KenPixel Mini")
        reinicioLabel.fontSize = 24;
        reinicioLabel.position.y = frame.size.height/2
        reinicioLabel.position.x = frame.size.width/2
        reinicioLabel.text = String(UInt32(tempoFaltando))
        reinicioLabel.fontColor = UIColor.redColor()
        reinicioLabel.hidden = !reiniciarBola
        addChild(reinicioLabel)
        
        sair = SKLabelNode(fontNamed: "KenPixel Mini")
        sair.fontSize = 18
        sair.position.y = frame.size.height - 30
        sair.position.x = frame.size.width - 40
        sair.text = "Sair"
        sair.fontColor = UIColor.redColor()
        addChild(sair)
        
        
        jogador = BarraJogador(imageNamed: "bridge")
        jogador.position.y = 80
        jogador.position.x = self.frame.width / 2
        
        bola = Bola(imageNamed: "ball")
        bola.position.y = 150
        bola.position.x = self.frame.width / 2
        
        configuraCenario()
        
        addChild(jogador)
        addChild(bola)
        
        for var x = 0; x < numBlocosX; x++
        {
            for var y = 0; y < numBlocosY; y++
            {
                var xPosition:CGFloat = ((larguraBloco+espacoBlocos) * CGFloat(x)) + espacoBordaX
                var yPosition:CGFloat = self.frame.height - ((larguraBloco+espacoBlocos) * CGFloat(y)) - espacoBordaY
                if ((((x+1) % numBlocosX == 0) || x == 0)) {
                    let bloco = Bloco(tipo: TiposBlocos.DuasPancadas, location: CGPoint(x: xPosition, y: yPosition))
                    addChild(bloco)
                }
                else if ((((y+1) % numBlocosY == 0) || y == 0) && !((x+1) % numBlocosX == 0) && y+1 != numBlocosY){
                    let bloco = Bloco(tipo: TiposBlocos.TresPancadas, location: CGPoint(x: xPosition, y: yPosition))
                    addChild(bloco)
                }
                else {
                    let bloco = Bloco(tipo: TiposBlocos.UmaPancada, location: CGPoint(x: xPosition, y: yPosition))
                    addChild(bloco)
                }
            }
        }
        
    }
    
    func configuraCenario()
    {
        paredeEsquerda = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 10.0, height: self.frame.size.height))
        paredeEsquerda.position.x = 0
        paredeEsquerda.position.y = self.frame.size.height/2
        paredeEsquerda.physicsBody = SKPhysicsBody(rectangleOfSize: paredeEsquerda.size)
        paredeEsquerda.physicsBody?.dynamic = false
        paredeEsquerda.physicsBody?.categoryBitMask = collision_fase
        paredeEsquerda.physicsBody?.contactTestBitMask = collision_all
        paredeEsquerda.physicsBody?.collisionBitMask = collision_all
        
        paredeDireita = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 10.0, height: self.frame.size.height))
        paredeDireita.position.x = self.frame.size.width
        paredeDireita.position.y = self.frame.size.height/2
        paredeDireita.physicsBody = SKPhysicsBody(rectangleOfSize: paredeDireita.size)
        paredeDireita.physicsBody?.dynamic = false
        paredeDireita.physicsBody?.categoryBitMask = collision_fase
        paredeDireita.physicsBody?.contactTestBitMask = collision_all
        paredeDireita.physicsBody?.collisionBitMask = collision_all
        
        chao = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.frame.size.width, height: 10.0))
        chao.position.x = self.frame.size.width/2
        chao.position.y = 0
        chao.physicsBody = SKPhysicsBody(rectangleOfSize: chao.size)
        chao.physicsBody?.dynamic = false
        chao.physicsBody?.categoryBitMask = collision_chao
        chao.physicsBody?.contactTestBitMask = collision_all
        chao.physicsBody?.collisionBitMask = collision_all
        
        teto = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: self.frame.size.width, height: 10.0))
        teto.position.x = self.frame.size.width/2
        teto.position.y = self.frame.size.height
        teto.physicsBody = SKPhysicsBody(rectangleOfSize: teto.size)
        teto.physicsBody?.dynamic = false
        teto.physicsBody?.categoryBitMask = collision_fase
        teto.physicsBody?.contactTestBitMask = collision_all
        teto.physicsBody?.collisionBitMask = collision_all
        
        addChild(paredeDireita)
        addChild(paredeEsquerda)
        addChild(chao)
        addChild(teto)
    }
    
    var previous: NSTimeInterval!
    override func update(currentTime: NSTimeInterval) {
        println(blocos.count)
        jogador.update(currentTime)
        bola.update(currentTime)
        vidasLabel.text = "Vidas: " + String(vidas)
        
        
        
        if (reiniciarBola){
            tempoFaltando = tempoFaltando - (currentTime - previous)
            if (tempoFaltando <= 0)
            {
                bola = Bola(imageNamed: "ball")
                bola.position.y = 150
                bola.position.x = self.frame.width / 2
                addChild(bola)
                reiniciarBola = false
                reinicioLabel.hidden = true
            }
        }
        reinicioLabel.text = String(UInt32(tempoFaltando)+1)
        previous = currentTime
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            if sair.containsPoint(location) {
                self.view?.presentScene(GameScene(size: self.size), transition: SKTransition.crossFadeWithDuration(0.5))
            }
        }
        
        firstTouch = touches.first as!UITouch
        if (firstTouch.locationInNode(self).x > self.frame.width/2){
            jogador.direcao = 1
        }
        else
        {
            jogador.direcao = -1
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch = touches.first as!UITouch
        if (touch == firstTouch){
            jogador.direcao = 0
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if (contact.bodyA.categoryBitMask == collision_bola)
        {
            if (contact.bodyB.categoryBitMask == collision_blocos)
            {
                var bloco = contact.bodyB.node as? Bloco
                bloco!.Vidas--;
                if (bloco!.Vidas <= 0){
                    contact.bodyB.node?.removeFromParent()
                    blocosDestruidos++;
                    if (blocosDestruidos >= (numBlocosX * numBlocosY))
                    {
                        self.view?.presentScene(GameWin(size: self.size))
                    }
                }
            }
            if (contact.bodyB.categoryBitMask == collision_chao)
            {
                contact.bodyA.node?.removeFromParent()
                vidas--;
                if (vidas <= 0)
                {
                    self.view?.presentScene(GameOver(size: self.size))
                }
                tempoFaltando = tempoReinicio
                reiniciarBola = true
                reinicioLabel.hidden = false
            }
        }
        
        if (contact.bodyB.categoryBitMask == collision_bola){
            if (contact.bodyA.categoryBitMask == collision_blocos)
            {
                var bloco = contact.bodyA.node as? Bloco
                bloco!.Vidas--;
                if (bloco!.Vidas <= 0){
                    contact.bodyA.node?.removeFromParent()
                    blocosDestruidos++;
                    if (blocosDestruidos >= (numBlocosX * numBlocosY))
                    {
                        self.view?.presentScene(GameWin(size: self.size))
                    }
                }
            }
            
            if (contact.bodyA.categoryBitMask == collision_chao)
            {
                contact.bodyB.node?.removeFromParent()
                vidas--;
                if (vidas <= 0)
                {
                    self.view?.presentScene(GameOver(size: self.size))
                }
                tempoFaltando = tempoReinicio
                reiniciarBola = true
                reinicioLabel.hidden = false
            }
        }
    }
}
