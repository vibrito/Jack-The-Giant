import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate
{
    var cloudsController = CloudsController()
    
    var mainCamera: SKCameraNode?
    
    var bg1: BGClass?
    var bg2: BGClass?
    var bg3: BGClass?
    
    var player: Player?
    
    var canMove = false
    var moveLeft = false
    
    var center: CGFloat?
    
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    
    let distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(-158)
    let maxX = CGFloat(158)
    
    private var pausePanel: SKSpriteNode?
    
    override func didMove(to view: SKView)
    {
        initializeVariables()
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        createNewClouds()
        player?.setScore()
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player"
        {
            firstBody = contact.bodyA
            secondBody =  contact.bodyB
        }
        else
        {
            secondBody =  contact.bodyA
            firstBody = contact.bodyB
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Life"
        {
            // play the sound for the life
            GameplayController.instance.incrementLife()
            secondBody.node?.removeFromParent()
        }
        else if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin"
        {
            // play the sound for the coin
            GameplayController.instance.incrementCoin()
            secondBody.node?.removeFromParent()
        }
        else if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Clound"
        {
            // kill the player
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)

            if self.scene?.isPaused == false
            {
                if location.x > center!
                {
                    moveLeft = false
                    player?.animatePlayer(moveLeft: moveLeft)
                }
                else
                {
                    moveLeft = true
                    player?.animatePlayer(moveLeft: moveLeft)
                }
            }
            
            if atPoint(location).name == "Pause" && self.scene?.isPaused == false
            {
                self.scene?.isPaused = true
                createPausePanel()
            }
            
            if atPoint(location).name == "Resume"
            {
                pausePanel?.removeFromParent()
                self.scene?.isPaused = false
            }
            
            if atPoint(location).name == "Quit"
            {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1))
            }
        }
        
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    func initializeVariables()
    {
        physicsWorld.contactDelegate = self
        
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        player = self.childNode(withName: "Player") as! Player?
        player?.initializePlayerAnimation()
        
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode!
        
        getBackgrounds()
        getLabels()
        GameplayController.instance.initializeVariables()
        
        cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: true)
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
        
        //print("The random number is \(cloudsController.randomBetweenNumbers(firstNum: 2, secondNum: 5))")
    }
    
    func getBackgrounds()
    {
        bg1 = self.childNode(withName: "BG 1") as? BGClass!
        bg2 = self.childNode(withName: "BG 2") as? BGClass!
        bg3 = self.childNode(withName: "BG 3") as? BGClass!
    }
    
    func managePlayer()
    {
        if canMove
        {
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
    
    func moveCamera()
    {
        self.mainCamera?.position.y -= 3
    }
    
    func manageBackgrounds()
    {
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
    
    func createNewClouds()
    {
        if cameraDistanceBeforeCreatingNewClouds > (mainCamera?.position.y)!
        {
            cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
            
            cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: false)
        }
    }
    
    func getLabels()
    {
        GameplayController.instance.scoreText = self.mainCamera?.childNode(withName: "Score Text") as? SKLabelNode!
        GameplayController.instance.coinText = self.mainCamera?.childNode(withName: "Coin Score") as? SKLabelNode!
        GameplayController.instance.lifeText = self.mainCamera?.childNode(withName: "Life Score") as? SKLabelNode!
    }
    
    func createPausePanel()
    {
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        
        let resumeButton = SKSpriteNode(imageNamed: "Resume Button")
        let quitButton = SKSpriteNode(imageNamed: "Quit Button 2")
        
        pausePanel?.anchorPoint = CGPoint(x: 0.5, y:0.5)
        pausePanel?.xScale = 1.6
        pausePanel?.yScale = 1.6
        pausePanel?.zPosition = 5
        
        pausePanel?.position = CGPoint(x: (self.mainCamera?.frame.size.width)!, y: (self.mainCamera?.frame.size.height)!)
        
        resumeButton.name = "Resume"
        resumeButton.zPosition = 6
        resumeButton.anchorPoint = CGPoint(x: 0.5, y:0.5)
        resumeButton.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! + 25)
        
        quitButton.name = "Quit"
        quitButton.zPosition = 6
        quitButton.anchorPoint = CGPoint(x: 0.5, y:0.5)
        quitButton.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! - 45)
        
        pausePanel?.addChild(resumeButton)
        pausePanel?.addChild(quitButton)
        
        self.mainCamera?.addChild(pausePanel!)
    }
}
