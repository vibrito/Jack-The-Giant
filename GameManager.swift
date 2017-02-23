import Foundation
import SpriteKit

class GameManager
{
    static let instance = GameManager()
    
    private init()
    {
        
    }
    
    private var gameData: GameData?
    
    var gameStartedFromMainMenu = false
    var gameRestaredPlayerDied = false
    
    func setEasyDifficultyScore(easyDifficultyScore: Int32)
    {
         gameData?.setEasyDifficultyScore(easyDifficultyScore: easyDifficultyScore)
    }
    
    func getEasyDifficultyScore() -> Int32
    {
        return (self.gameData?.getEasyDifficultyScore())!
    }
}
