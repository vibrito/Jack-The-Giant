import SpriteKit

class Player: SKSpriteNode
{
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animetePlayerAction = SKAction()
    
    func initializePlayerAnimation()
    {
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        for i in 2...textureAtlas.textureNames.count
        {
            let name = "Player \(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        animetePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
    }
    
    func animatePlayer(moveLeft: Bool)
    {
        if moveLeft
        {
            self.xScale = -fabs(self.xScale)
        }
        else
        {
            self.xScale = fabs(self.xScale)
        }
        
        self.run(SKAction.repeatForever(animetePlayerAction), withKey: "Animate")
    }
    
    func stopPlayerAnimation()
    {
        self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = (self.texture?.size())!
    }
    
    func movePlayer(moveLeft: Bool)
    {
        if moveLeft
        {
            self.position.x = self.position.x - 10
        }
        else
        {
            self.position.x = self.position.x + 10
        }
    }
    
}




