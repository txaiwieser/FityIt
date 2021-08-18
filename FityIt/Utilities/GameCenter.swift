import GameKit

public class GameCenter: NSObject, GKGameCenterControllerDelegate {
    public static let shared: GameCenter = GameCenter()
    
    private weak var presentingViewController: UIViewController!
    
    public func authenticateLocalUser() {
        print("Authenticating local user...")
        
        if GKLocalPlayer.local.isAuthenticated == false {
            GKLocalPlayer.local.authenticateHandler = { (view, error) in
                guard error == nil else {
                    print("Authentication error: \(String(describing: error?.localizedDescription))")
                    return
                }
            }
        } else {
            print("Already authenticated")
        }
    }
    
    public func reportAchievementIdentifier(_ identifier: String, percent: Double, showsCompletionBanner banner: Bool = true) {
        let achievement = GKAchievement(identifier: identifier)
        
        achievement.percentComplete = percent
        achievement.showsCompletionBanner = banner
            
        GKAchievement.report([achievement]) { (error) in
            guard error == nil else {
                print("Error in reporting achievements: \(String(describing: error))")
                return
            }
        }
    }

    public func resetAllAchievements() {
        GKAchievement.resetAchievements { (error) in
            guard error == nil else {
                print("Error resetting achievements: \(String(describing: error))")
                return
            }
        }
    }
    
    public func reportLeaderboardIdentifier(_ identifier: String, score: Int) {
        let scoreObject = GKScore(leaderboardIdentifier: identifier)
        scoreObject.value = Int64(score)
        GKScore.report([scoreObject]) { (error) in
            guard error == nil else {
                print("Error in reporting leaderboard scores: \(String(describing: error))")
                return
            }
        }
    }
    
    public func showGameCenter(_ viewController: UIViewController, viewState: GKGameCenterViewControllerState) {
        presentingViewController = viewController
        
        let gcvc = GKGameCenterViewController()
        gcvc.viewState = viewState
        gcvc.gameCenterDelegate = self
        presentingViewController.present(gcvc, animated: true, completion: nil)
    }
    
    // MARK: GKGameCenterControllerDelegate
    
    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}
