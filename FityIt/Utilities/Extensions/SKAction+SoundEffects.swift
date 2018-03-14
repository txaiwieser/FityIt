//
//  SKAction+SoundEffects.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit
import TWSpriteKitUtils

var userWantEffects: Bool? = nil

extension SKAction {
    class var soundEffectsString: String { return "USER_SETTINGS_FX_DISABLE" }
    
    class func playSoundFileIfEnabled(_ soundFile: String, waitForCompletion wait: Bool) -> SKAction? {
        if shouldPlaySound() {
            return self.playSoundFileNamed(soundFile, waitForCompletion: wait)
        } else {
            return nil
        }
    }

    class func shouldPlaySound() -> Bool {
        return userWantEffects ?? reloadSoundEffectsSettings()
    }
    
    class func reloadSoundEffectsSettings(_ newValue: Bool? = nil) -> Bool {
        let newBool = newValue ?? !(UserDefaults.standard.bool(forKey: soundEffectsString))
        userWantEffects = newBool
        TWControl.defaultSoundEffectsEnabled = newBool
        AppCache.instance.resetSounds(initializeAfter: newBool)
        return newBool
    }
    
    class func saveNewSoundEffectsSettings(_ newBool:Bool) {
        UserDefaults.standard.set(!newBool, forKey: soundEffectsString)
        UserDefaults.standard.synchronize()
        _ = reloadSoundEffectsSettings(newBool)
    }
}
