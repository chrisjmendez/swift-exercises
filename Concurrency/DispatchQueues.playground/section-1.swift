import UIKit

/** ** ** ** ** ** ** ** ** ** ** ** ** ** **
TITLE: Dispatch Queues


DESCRIPTION: 

There are TWO types:
• Sequential (series)
• Concurrent (parallel)

OTHER NOTES:

OLD WAY:
Objective-C thinks about the world using the idea of BLOCKS

SWIFT WAY:
SWIFT thinks about the world using the idea of CLOSURES

** ** ** ** ** ** ** ** ** ** ** ** ** ** **/

//EXAMPLE: SERIAL QUEUE
//You have to create SERIAL queue's before you can create them.

//Declare a variable to hold a reference to a dispatch queue = then create the queue, "name", serial CONSTANT
var q:dispatch_queue_t = dispatch_queue_create("fm.guitarpick.queue", DISPATCH_QUEUE_SERIAL)
dispatch_async(q, {
    /*
    Do some work
    */
})


//EXAMPLE: CONCURRENT QUEUE
var d:dispatch_queue_t = dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 )
dispatch_async(d, {
    /*
    Do some work
    */
    //You have to create another operation to return back to the GUI
    dispatch_async( dispatch_get_main_queue() ){
        
    }
})
