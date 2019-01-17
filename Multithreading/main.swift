//
//  main.swift
//  Multithreading
//
//  Created by menangen on 16/01/2019.
//  Copyright © 2019 menangen. All rights reserved.
//

import Foundation

var udpArray: [String] = ["Packet1", "Packet2", "Packet3"]

var operationsList = [UDPOperation]()
let operationQueue = OperationQueue()

let group = DispatchGroup()

for index in 0...1 {
    let op = UDPOperation(index)
    operationsList.append(op)
    operationQueue.addOperation(op)
}

for (index, el) in udpArray.enumerated() {
    
    let block = BlockOperation {
        let operationId = index & 0x1
        
        print("Sending \(el) to Thread \(operationId)", Thread.current.description)
        
        let udpThread = operationsList[operationId]
  
        udpThread.packetBuffer.append(el)
        udpThread.runLoopSemaphore.signal()
    }
    
    block.name = "UDP Block"
    block.start()
}

group.wait()
