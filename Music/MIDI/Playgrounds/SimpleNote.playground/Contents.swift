//: Create a Client, Create a Destination, Play a Note
//: Matt Grippaldi http://mattg411.com/swift-coremidi-callbacks/

import Cocoa
import CoreMIDI

var midiClient: MIDIClientRef = 0;
var outPort:MIDIPortRef = 0;

MIDIClientCreate("MidiTestClient", nil, nil, &midiClient);
MIDIOutputPortCreate(midiClient, "MidiTest_OutPort", &outPort);

var packet1:MIDIPacket = MIDIPacket();
    packet1.timeStamp = 0;
    packet1.length = 3;
    packet1.data.0 = 0x90 + 0; // Note On event channel 1
    packet1.data.1 = 0x3C; // Note C3
    packet1.data.2 = 100; // Velocity

var packetList:MIDIPacketList = MIDIPacketList(numPackets: 1, packet: packet1);

// Get the first destination
var dest:MIDIEndpointRef = MIDIGetDestination(0);

MIDISend(outPort, dest, &packetList);

packet1.data.0 = 0x80 + 0; // Note Off event channel 1
packet1.data.2 = 0; // Velocity

sleep(1);

packetList = MIDIPacketList(numPackets: 1, packet: packet1);

MIDISend(outPort, dest, &packetList);
