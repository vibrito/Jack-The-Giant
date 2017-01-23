import SpriteKit

class BGClass: SKSpriteNode
{
    
    func moveBG(camera: SKCameraNode)
    {
        if self.position.y - self.size.height - 10 > camera.position.y
        {
            self.position.y -= self.size.height * 3
        }
    }
}
