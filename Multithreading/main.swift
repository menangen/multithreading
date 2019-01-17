//
//  main.swift
//  Multithreading
//
//  Created by menangen on 16/01/2019.
//  Copyright © 2019 menangen. All rights reserved.
//

import Foundation

let StartJobSemaphore = DispatchSemaphore(value: 4)

let UDPBufferSemaphore = DispatchSemaphore(value: 1)
var udpBuffer: [String] = ["Packet1", "Packet2", "Packet3", "Packet4"]

var operationsList = [UDPOperation]()
let operationQueue = OperationQueue()


for index in 0..<4 {
    let op = UDPOperation(index)
    operationsList.append(op)
}

let block = BlockOperation {
    sleep(1)
    for count in 5...10 {
        UDPBufferSemaphore.wait()
        
        udpBuffer.append("Packet\(count)")
        
        UDPBufferSemaphore.signal()
        StartJobSemaphore.signal()
    }
}
operationQueue.addOperation(block)

let block2 = BlockOperation {
    sleep(3)
    for count in 11...14 {
        UDPBufferSemaphore.wait()
        
        udpBuffer.append("Packet\(count)")
        
        UDPBufferSemaphore.signal()
        StartJobSemaphore.signal()
    }
}
operationQueue.addOperation(block2)

operationQueue.addOperation {
    sleep(5)
    
    for op in operationsList {
        op.name = nil
        StartJobSemaphore.signal()
    }
}
operationQueue.addOperations(operationsList, waitUntilFinished: true)
