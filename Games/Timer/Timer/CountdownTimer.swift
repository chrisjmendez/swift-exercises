import UIKit

class CountdownTimer: ASAttributedLabelNode {
    
    var endTime: NSDate!
    

    func update() {
        let remainingTime = timeLeft()
        attributedString = stringFromTimeInterval(remainingTime)
    }
    
    func startWithDuration(duration: NSTimeInterval) {
        let timeNow = NSDate()
        endTime = timeNow.dateByAddingTimeInterval(duration)
    }
    
    func hasFinished() -> Bool {
        return timeLeft() == 0
    }
    
    func createAttributedString(string: String) -> NSMutableAttributedString {
        let font =  UIFont(name: "Futura-Medium", size: 65)
        let textAttributes = [
            NSFontAttributeName : font!,
            // Note: SKColor.whiteColor().CGColor breaks this
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSStrokeColorAttributeName: UIColor.blackColor(),
            // Note: Use negative value here if you want foreground color to show
            NSStrokeWidthAttributeName: -3
        ]
        return NSMutableAttributedString(string: string , attributes: textAttributes)
    }
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> NSMutableAttributedString {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let timeString = String(format: "%01d:%02d", minutes, seconds)
        return createAttributedString(timeString)
    }
    
    private func timeLeft() -> NSTimeInterval {
        let now = NSDate()
        let remainingSeconds = endTime.timeIntervalSinceDate(now)
        return max(remainingSeconds, 0)
    }
}