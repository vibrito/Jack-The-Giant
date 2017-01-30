import Foundation
import SpriteKit

class GameplayController
{
    static let instance = GameplayController()

    var scoreText: SKLabelNode?
    var coinText: SKLabelNode?
    var lifeText: SKLabelNode?
    
    var score: Int?
    var coin: Int?
    var life: Int?
    
    private init()
    {
        
    }
    
    func initializeVariables()
    {
        if GameManager.instance.gameStartedFromMainMenu
        {
            GameManager.instance.gameStartedFromMainMenu = false
            
            score = 0
            coin = 0
            life = 2
            
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coin!)"
            lifeText?.text = "x\(life!)"
        }
        else if GameManager.instance.gameRestaredPlayerDied
        {
            GameManager.instance.gameRestaredPlayerDied = false
            
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coin!)"
            lifeText?.text = "x\(life!)"
        }
    }
}
