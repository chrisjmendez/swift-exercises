Positioning Objects on a new xCode Game
=

It makes absolutely no sense but for whatever reason, if you create a new game within xCode 7.0, you have to configure a few things to make sprites appear properly on the page. Here are the key things you'll need to "fix".

### Edit the GameViewController
You need to replace ```viewDidLoad()``` with ```viewWillLayoutSubviews()```.  For peace of mind, simply remove viewDidLoad completely.

Your code will look like this:
<pre>
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            scene.size = skView.bounds.size
            
            skView.presentScene(scene)
        }

    }
</pre>

Resources
-
- [Best explanation of the problem](http://www.ymc.ch/en/ios-7-sprite-kit-setting-up-correct-scene-dimensions)
- [Understanding SKSceneScaleMode](http://blog.infinitecortex.com/2014/01/spritekit-understanding-skscene-scalemode/): This will explain the different types of scale modes and how they can affect your game. This will clearly explain why it would be very challenging to build a game that worked in both portrait and landscape
