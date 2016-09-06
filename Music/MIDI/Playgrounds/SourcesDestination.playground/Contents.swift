//: Create a Client, Create a Destination, Play a Note
//: Matt Grippaldi http://mattg411.com/swift-coremidi-callbacks/

import Cocoa
import CoreMIDI

func getDisplayName(obj: MIDIObjectRef) -> String{
    var param: Unmanaged<CFString>?
    var name: String = "Error";
    
    let err: OSStatus = MIDIObjectGetStringProperty(obj, kMIDIPropertyDisplayName, &param)
    if err == OSStatus(noErr){
        name =  param!.takeRetainedValue() as String
    }
    return name;
}


func getDestinationNames() -> [String]{
    var names:[String] = [String]();
    
    let count: Int = MIDIGetNumberOfDestinations();
    for i in 0 ..< count {
        let endpoint:MIDIEndpointRef = MIDIGetDestination(i);
        if (endpoint != 0){
            names.append(getDisplayName(endpoint));
        }
    }
    return names;
}

func getSourceNames() -> [String]{
    var names:[String] = [String]();
    let count: Int = MIDIGetNumberOfSources();
    
    for i in 0 ..< count {
        let endpoint:MIDIEndpointRef = MIDIGetSource(i);
        if (endpoint != 0){
            names.append(getDisplayName(endpoint));
        }
    }
    return names;
}


let destNames = getDestinationNames();
for destName in destNames {
    print("Destination: \(destName)");
}


let sourceNames = getSourceNames();
for sourceName in sourceNames{
    print("Source: \(sourceName)");
}

print("A")
