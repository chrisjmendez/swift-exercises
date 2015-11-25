import UIKit

func random(max: Int) -> Int {
    
    var numbers = [Int]()
    for x in 0...max {
        numbers.append(x)
    }
    
    var result:Int?
    var numbersCopy = numbers
    for _ in 0..<numbers.count {
        let randomIndex = Int(arc4random_uniform(UInt32(numbersCopy.count)))
        result = numbersCopy.removeAtIndex(randomIndex)
        print("Random Number: \(result)")
    }
    return result!
}


var number = random(3)

random(4)
random(4)
random(4)
random(4)
random(4)
random(4)