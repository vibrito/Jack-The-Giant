import SpriteKit

class CollectableController
{
    func getCollectable() -> SKSpriteNode
    {
        var collectable = SKSpriteNode()
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 7)) >= 4
        {
            
        }
        return collectable
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat
    {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
