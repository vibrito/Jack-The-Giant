import SpriteKit

class MainMenuScene: SKScene
{
    var startGameButton: SKSpriteNode?
    var highscoreButton: SKSpriteNode?
    var optionButton: SKSpriteNode?
    var quitButton: SKSpriteNode?
    
    override func didMove(to view: SKView)
    {
        startGameButton = self.childNode(withName: "Start Game") as? SKSpriteNode!
        highscoreButton = self.childNode(withName: "Highscore") as? SKSpriteNode!
        optionButton = self.childNode(withName: "Options") as? SKSpriteNode!
        quitButton = self.childNode(withName: "Quit") as? SKSpriteNode!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            if atPoint(location) == startGameButton
            {
                GameManager.instance.gameStartedFromMainMenu = true
                
                let scene = GameplayScene(fileNamed: "GameplayScene")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
            else if atPoint(location) == highscoreButton
            {
                let scene = HighscoreScene(fileNamed: "HighscoreScene")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
            else if atPoint(location) == optionButton
            {
                let scene = OptionScene(fileNamed: "OptionScene")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
            else if atPoint(location) == quitButton
            {
                print("The quit button is pressed")
            }
        }
    }
}
