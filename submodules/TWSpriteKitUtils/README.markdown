# TWControls - Simple Controls (Button, Switch) for SpriteKit, written in Swift!

## **IMPORTANT**

All development happens on the [develop][develop] branch. Code is merged back on master branch.

[develop]: https://github.com/txaidw/TWControls/tree/develop

This project requires Swift 1.2 and Xcode 6.3.

You can help adding issues and submitting pull requests.

## Easy to use SpriteKit controls

TWControls is a project that attempts to provide an easy-to-use API to perform actions based on user interaction on SpriteKit. It provides controls like Buttons and Switches. Is written in pure Swift and uses closures to perform actions triggered by the controls.

* TWControl: A base class with handlers for UIControlEvents.
* TWButton: Subclass of TWControl that implements a complete button for SpriteKit.
* TWSwitch: Subclass of TWControl that implements a complete switch for SpriteKit.

![Demonstration](https://github.com/txaidw/TWControls/blob/master/demo.gif)

## What's included

For now we have 3 types of controls:

* Color: A simple colored rectangle;
* Texture: Controls with textures;
* Text: Controls only with labels;

**Color and Texture control types can have text labels too.

## Usage

You can set up a TWButton using one of the following initializers:

    init(normalText: String, highlightedText: String)
    init(normalTexture: SKTexture, highlightedTexture: SKTexture) 
    init(normalColor: SKColor, highlightedColor: SKColor, size:CGSize) 

You can set up a TWSwitch using one of the following initializers:
	    
	init(normalText: String, selectedText: String)
    init(normalTexture: SKTexture, selectedTexture: SKTexture)
    init(normalColor: SKColor, selectedColor: SKColor, size:CGSize)

Or you can set up a TWButton or a TWSwitch using the complete methods found on TWControl:

    init(normalTexture:SKTexture, highlightedTexture:SKTexture, selectedTexture:SKTexture, disabledTexture:SKTexture)
    init(normalColor:SKColor, highlightedColor:SKColor, selectedColor:SKColor, disabledColor:SKColor, size:CGSize)
    init(normalText:String, highlightedText:String, selectedText:String, disabledText:String)

Swift doesn't have a "performSelector: method, so my idea was to use only closures. The problem is we have to be *VERY CAREFUL*, because is very easy to end up with reference cycles.

You should use inside your closures only the objects that are on the capture list of the closure!

To add an action to the control you use:

	func addClosureFor<T: AnyObject>(event: UIControlEvents, target: T, closure: (target:T, sender:TWControl) -> ())



Here's a full init code snippet:

        class Test {
            var testProperty = "Default String"
    
            init() {
                let control = TWButton(normalColor: SKColor.blueColor(), highlightedColor: SKColor.redColor(), size: CGSize(width: 160, height: 80))
                control.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
                control.position.allStatesLabelText = "PLAY"
                control.addClosureFor(.TouchUpInside, target: self, closure: { (scene, sender) -> () in
                    scene.testProperty = "Changed Property"
                })
            }
    
            deinit { println("Class Released..") }
        }


You can customize the controls using the following properties:

    // TYPE Color Customizations
    internal var stateDisabledColor:SKColor!
    internal var stateHighlightedColor:SKColor!
    internal var stateNormalColor:SKColor!
    internal var stateSelectedColor:SKColor!
    
    // TYPE Texture Customizations
    internal var stateDisabledTexture:SKTexture!
    internal var stateHighlightedTexture:SKTexture!
    internal var stateNormalTexture:SKTexture!
    internal var stateSelectedTexture:SKTexture!
    
    // TEXT Labels Customizations
    internal var allStatesLabelText:String!
    internal var allStatesFontColor:SKColor!
    internal var allStatesLabelFontSize:CGFloat!
    internal var allStatesLabelFontName:String!

	internal var stateDisabledLabelText:String?
    internal var stateHighlightedLabelText:String?
    internal var stateNormalLabelText:String?
    internal var stateSelectedLabelText:String?

    internal var stateDisabledFontColor:SKColor!
    internal var stateHighlightedFontColor:SKColor!
    internal var stateNormalFontColor:SKColor!
    internal var stateSelectedFontColor:SKColor!


    // Labels Direct Access - Change properties directly from SKLabelNode
    internal let stateDisabledLabel:SKLabelNode
    internal let stateHighlightedLabel:SKLabelNode
    internal let stateNormalLabel:SKLabelNode
    internal let stateSelectedLabel:SKLabelNode



## Help Wanted

TWControls is really simple implementation. I made while learning Swift. If you can improve, please do it.

You can add issues as well!

Your help will be greatly appreciated. Please star, fork and submit pull requests.

You can help by using TWControls in your projects and discovering its shortcomings.


## In Progress

Here are some things that I still want to implement:

* (DONE) Support for audio effects; (DONE)
* Improve Documentation;
* Animations

## Thanks

* This work is almost a translation of a ObjC control called "SpriteKit-iOS-Basic-Controls" by Nicolás Miari (https://github.com/nicolas-miari) with modifications and improvements! So all credit must go to him! :) Thanks man!

## License

See LICENSE for more information

