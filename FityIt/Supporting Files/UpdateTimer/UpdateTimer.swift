//
//  UpdateTimer.swift
//  GameObjects
//
//  Created by bryn austin bellomy on 2014 Nov 27.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation


/**
 A timer object for tracking commonly-needed time variables in the scene loop of a game.  Also includes a lap timer (see `lap()`) that makes it trivial to track
 an arbitrary event (i.e., one that isn't necessarily tied to the `update()` cycle).  During your scene loop's `update()` method, `timeSinceLastLap` will be
 set to the number of seconds since the previous time `lap()` was called (or, if it has never been called, the number of seconds since the first call to
 `update()`).  Call `lap()` any time the event you're monitoring occurs, and `timeSinceLastLap` will reset to 0 and begin counting up again.
 */
public struct UpdateTimer
{
    public init() {}
    
    /** The number of seconds since `update()` was last called. */
    public private(set) var timeSinceLastUpdate = TimeInterval(0)
    
    /** The number of seconds since the first time `update()` was called. */
    public private(set) var timeSinceFirstUpdate = TimeInterval(0)
    
    /** The number of seconds since the last time `lap()` was called. */
    public private(set) var timeSinceLastLap = TimeInterval(0)
    
    /** The value of the `currentTime` argument passed to `update()` the last time `update()` was called. */
    public private(set) var previousUpdateTime = TimeInterval(0)
    
    /** The number of frames rendered since the start of the app. Useful if you need to lock your game's update
     cycle to the framerate. For example this allows you to perform certain actions n frames from now, instead
     of n seconds. */
    public private(set) var frameCount : Int = 0
    
    /** A flag to indicate whether `update()` has ever been called. */
    private var firstUpdate = true
    
    /** Call this function at the beginning your scene loop's `update()` method. */
    public mutating func update(currentTime:TimeInterval)
    {
        // "first update" setup stuff
        if firstUpdate {
            previousUpdateTime = currentTime
            firstUpdate = false
        }
        
        // update the basic timers
        timeSinceLastUpdate = currentTime - previousUpdateTime
        timeSinceFirstUpdate += timeSinceLastUpdate
        previousUpdateTime = currentTime
        
        // update lap timer
        timeSinceLastLap += timeSinceLastUpdate
        
        // update frame count
        frameCount += 1
    }
    
    /** Reset the lap timer to zero.  The lap timer is useful for tracking some arbitrary event that doesn't necessarily occur every time `update()` is called.  */
    public mutating func lap() {
        timeSinceLastLap = 0
    }
}
