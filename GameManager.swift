import Foundation
import SpriteKit

class GameManager
{
    static let instance = GameManager()
    
    private init()
    {
        
    }
    
    var gameStartedFromMainMenu = false
    var gameRestaredPlayerDied = false
}
