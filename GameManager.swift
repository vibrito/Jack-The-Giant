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
    
    func initializeGameData()
    {
        if !FileManager.default.fileExists(atPath: getFilePath() as String)
        {
            // setup our game with initial values
            gameData = GameData();
            
            gameData?.setEasyDifficultyScore(easyDifficultyScore: 0);
            gameData?.setEasyDifficultyCoinScore(easyDifficultyCoinScore: 0);
            
            gameData?.setMediumDifficultyScore(mediumDifficultyScore: 0);
            gameData?.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: 0);
            
            gameData?.setHardDifficultyScore(hardDifficultyScore: 0);
            gameData?.setHardDifficultyCoinScore(hardDifficultyCoinScore: 0);
            
            gameData?.setEasyDifficulty(easyDiffyculty:  false);
            gameData?.setMediumDifficulty(mediumDifficulty:  true);
            gameData?.setHardDifficulty(hardDifficulty: false);
            
            gameData?.setIsMusicOn(isMusicOn: true);
            
            saveData();
        }
        
        loadData();
        
    }
    
    func loadData()
    {
        gameData = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath() as String) as? GameData!
    }
    
    func saveData()
    {
        if gameData != nil
        {
            NSKeyedArchiver.archiveRootObject(gameData!, toFile: getFilePath() as String);
        }
    }
    
    fileprivate func getFilePath() -> String
    {
        let manager = FileManager.default;
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as URL!;
        return url!.appendingPathComponent("Game Data").path;
    }
    
    func setEasyDifficultyScore(easyDifficultyScore: Int32)
    {
         gameData?.setEasyDifficultyScore(easyDifficultyScore: easyDifficultyScore)
    }
    func setEasyDifficultyCoinScore(easyDifficultyScore: Int32)
    {
        gameData?.setEasyDifficultyCoinScore(easyDifficultyCoinScore: easyDifficultyScore)
    }
    func getEasyDifficultyScore() -> Int32
    {
        return (self.gameData?.getEasyDifficultyScore())!
    }
    func getEasyDifficultyCoinScore() -> Int32
    {
        return (self.gameData?.getEasyDifficultyCoinScore())!
    }
    
    func setMediumDifficultyScore(mediumDifficultyScore: Int32)
    {
        gameData?.setMediumDifficultyScore(mediumDifficultyScore: mediumDifficultyScore)
    }
    func setMediumDifficultyCoinScore(mediumCoinDifficultyScore: Int32)
    {
        gameData?.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: mediumCoinDifficultyScore)
    }
    func getMediumDifficultyScore() -> Int32
    {
        return (self.gameData?.getMediumDifficultyScore())!
    }
    func getMediumDifficultyCoinScore() -> Int32
    {
        return (self.gameData?.getMediumDifficultyCoinScore())!
    }
    
    func setHardDifficultyScore(hardDifficultyScore: Int32)
    {
        gameData?.setHardDifficultyScore(hardDifficultyScore: hardDifficultyScore)
    }
    func setHardDifficultyCoinScore(hardCoinDifficultyScore: Int32)
    {
        gameData?.setHardDifficultyCoinScore(hardDifficultyCoinScore: hardCoinDifficultyScore)
    }
    func getHardDifficultyScore() -> Int32
    {
        return (self.gameData?.getHardDifficultyScore())!
    }
    func getHardDifficultyCoinScore() -> Int32
    {
        return (self.gameData?.getHardDifficultyCoinScore())!
    }
    
    func setEasyDifficulty(easyDifficulty: Bool)
    {
        gameData!.setEasyDifficulty(easyDiffyculty: easyDifficulty)
    }
    func getEasyDifficulty() -> Bool
    {
        return gameData!.getEasyDifficulty()
    }
    
    func setMediumDifficulty(mediumDifficulty: Bool)
    {
        gameData!.setMediumDifficulty(mediumDifficulty: mediumDifficulty)
    }
    func getMediumDifficulty() -> Bool
    {
        return gameData!.getMediumDifficulty()
    }
    
    func setHardDifficulty(hardDiffyculty: Bool)
    {
        gameData!.setHardDifficulty(hardDifficulty: hardDiffyculty)
    }
    func getHardDifficulty() -> Bool
    {
        return gameData!.getHardDifficulty()
    }
    
    func setIsMusicOn(isMusicOn: Bool)
    {
        gameData!.setIsMusicOn(isMusicOn: isMusicOn)
    }
    func getMusicOn() -> Bool
    {
        return gameData!.getIsMusciOn()
    }
    
}
