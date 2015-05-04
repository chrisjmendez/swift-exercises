import UIKit

/** ** ** ** ** ** ** ** ** ** ** ** ** ** **
TITLE: What are Blocks?


DESCRIPTION: BLOCKS ARE:
• Anonymous collections of inline code.
• Each block has a [declaration, return type, parameters]

OTHER NOTES:

• Variables created within the same scope of the block are accessible within the block
• In SWIFT, __CONSTANTS no longer exist, they are simply var variables now

WHAT'S THE POINT?:
• This will become handy when you want to dispatch multi-threaded processes concurrently
• Sometimes you will want to pass a block to a function and have the block execute on another thread

OLD WAY:

//Return Type | (Block Signifier ^blockName)(parameters) = Block Signifier ^(Return Type)(parameters)
void (^completionBlock)(NSData *, NSError *) = ^(NSData *data, NSError *error) {
    /* Enter Code Here */
}


SWIFT WAY:
let completionBlock: (NSData, NSError) -> Void = {data, error in
    /* Enter Code Here */
}
** ** ** ** ** ** ** ** ** ** ** ** ** ** **/

//EXAMPLE 1: This block returns an Integer
let squareBlock:Int -> Int = { num in
    return num * num
}


//EXAMPLE 2: Capture variables declared in the same lexical scope and modify them within the block
func changeVarInBlock(){
    
    let constantInBlock:Int = 5
    
    var modifyInBlock:Int = 10

    let addLexicalScopeVars:Void -> Int = {
        modifyInBlock = 2
        return constantInBlock + modifyInBlock
    }
    
    let sum:Int = addLexicalScopeVars()
    
    println("The sum is \(sum)")
}
changeVarInBlock()


//EXAMPLE 3: Return an Int from squareBlock with one Int param
func declareAndCallBlock() -> Void {
    let squareBlock:Int -> Int = { num in
        return num * num
    }
    println("Block return value: \(squareBlock(10))")
}
declareAndCallBlock()


//EXAMPLE 4: Capture variables in the same scope as the block
func shareScopeVars(){
    
    let weather:String = "rain"
    
    println("Before Block: \(weather)")
    
    let changeWeather:Void -> String = {
        return "Inside Block: \(weather)"
    }
    
    println(changeWeather())
}
shareScopeVars()


//EXAMPLE 5: Inline blocks are often passed as parameters to methods. It helps keep the block code in the same method as the one callilng it.
func useInlineBlock(){
    let names:NSArray = ["a", "b", "c", "d", "e", "f"]
    
    names.enumerateObjectsUsingBlock { (obj, idx, stop) -> Void in
        var string:String = obj.description as String
        println( "Letter: \(string.uppercaseString)" )
    }
}
useInlineBlock()


