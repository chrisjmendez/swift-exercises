//: Matt Grippaldi http://mattg411.com/swift-coremidi-callbacks/

import Cocoa
import CoreMIDI
import XCPlayground

func getDisplayName(obj: MIDIObjectRef) -> String {
    var param: Unmanaged<CFString>?
    var name: String = "Error";
    
    let err: OSStatus = MIDIObjectGetStringProperty(obj, kMIDIPropertyDisplayName, &param)
    if err == OSStatus(noErr)
    {
        name =  param!.takeRetainedValue() as String
    }
    
    return name;
}

func MyMIDIReadProc(pktList: UnsafePointer<MIDIPacketList>,
                    readProcRefCon: UnsafeMutablePointer<Void>, srcConnRefCon: UnsafeMutablePointer<Void>) -> Void {
    let packetList:MIDIPacketList = pktList.memory;
    let srcRef:MIDIEndpointRef = UnsafeMutablePointer<MIDIEndpointRef>(COpaquePointer(srcConnRefCon)).memory;
    print("MIDI Received From Source: \(getDisplayName(srcRef))");
    
    var packet:MIDIPacket = packetList.packet;
    for _ in 1...packetList.numPackets
    {
        let bytes = Mirror(reflecting: packet.data).children;
        var dumpStr = "";
        
        // bytes mirror contains all the zero values in the ridiulous packet data tuple
        // so use the packet length to iterate.
        var i = packet.length;
        for (_, attr) in bytes.enumerate()
        {
            dumpStr += String(format:"$%02X ", attr.value as! UInt8);
            --i;
            if (i <= 0)
            {
                break;
            }
        }
        
        print(dumpStr)
        packet = MIDIPacketNext(&packet).memory;
    }
}

var midiClient: MIDIClientRef = 0;
var inPort:MIDIPortRef = 0;
var src:MIDIEndpointRef = MIDIGetSource(0);

MIDIClientCreate("MidiTestClient", nil, nil, &midiClient);
MIDIInputPortCreate(midiClient, "MidiTest_InPort", MyMIDIReadProc, nil, &inPort);

MIDIPortConnectSource(inPort, src, &src);

// Keep playground running
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true;

