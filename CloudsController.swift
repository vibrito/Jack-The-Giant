import SpriteKit

class CloudsController
{
    var lastCloudPositionY = CGFloat()
    
    func shuffle(cloudsArray: [SKSpriteNode]) -> [SKSpriteNode]
    {
        var shuffledArray = cloudsArray
        for i in 0..<shuffledArray.count
        {
            let j = Int(arc4random_uniform(UInt32(shuffledArray.count - i))) + i
            if i == j {continue}
            swap(&shuffledArray[i], &shuffledArray[j])
        }
        
        return shuffledArray
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat
    {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func createClouds() -> [SKSpriteNode]
    {
        var clouds = [SKSpriteNode]()
        
        for _ in 0..<2
        {
            let cloud1 = SKSpriteNode(imageNamed: "Cloud 1")
            cloud1.name = "1"
            let cloud2 = SKSpriteNode(imageNamed: "Cloud 2")
            cloud2.name = "2"
            let cloud3 = SKSpriteNode(imageNamed: "Cloud 3")
            cloud3.name = "3"
            let darkCloud = SKSpriteNode(imageNamed: "Dark Cloud")
            darkCloud.name = "Dark Cloud"
            
            darkCloud.xScale = 0.9
            darkCloud.yScale = 0.9
            
            // add physics bodies to the clouds
            
            darkCloud.physicsBody = SKPhysicsBody(rectangleOf:darkCloud.size)
            darkCloud.physicsBody?.affectedByGravity = false
            darkCloud.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectables
            darkCloud.physicsBody?.collisionBitMask = ColliderType.Player
            
            clouds.append(self.createPhysicsBody(cloud: cloud1))
            clouds.append(self.createPhysicsBody(cloud: cloud2))
            clouds.append(self.createPhysicsBody(cloud: cloud3))
            clouds.append(darkCloud)
        }
        
        clouds = shuffle(cloudsArray: clouds)
        return clouds
    }
    
    func createPhysicsBody(cloud : SKSpriteNode) -> SKSpriteNode
    {
        cloud.xScale = 0.9
        cloud.yScale = 0.9
        
        cloud.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud.size.width - 5, height: cloud.size.height - 6))
        cloud.physicsBody?.affectedByGravity = false
        cloud.physicsBody?.restitution = 0
        cloud.physicsBody?.contactTestBitMask = ColliderType.Cloud
        cloud.physicsBody?.collisionBitMask = ColliderType.Player
        
        return cloud
    }
    
    func arrangeCloudsInScene(scene: SKScene, distanceBetweenClouds: CGFloat, center: CGFloat, minX: CGFloat, maxX: CGFloat, initialClouds:Bool)
    {
        var clouds = createClouds()
        
        if initialClouds
        {
            while (clouds[0].name == "Dark Cloud")
            {
                //shuffle the cloud array
                clouds = shuffle(cloudsArray: clouds)
            }
        }
        
        var positionY = CGFloat()
        
        if initialClouds
        {
            positionY = center - 100
        }
        else
        {
            positionY = lastCloudPositionY
        }
        
        var random = 0
        
        for i in 0...clouds.count - 1
        {
            var randomX = CGFloat()
            
            if random == 0
            {
                randomX = randomBetweenNumbers(firstNum: center + 90, secondNum: maxX)
                random = 1
            }
            else if random == 1
            {
                randomX = randomBetweenNumbers(firstNum: center - 90, secondNum: minX)
                random = 0
            }
            
            clouds[i].position = CGPoint(x: randomX, y: positionY)
            clouds[i].zPosition = 3
            
            scene.addChild(clouds[i])
            positionY -= distanceBetweenClouds
            lastCloudPositionY = positionY
        }
    }
}
