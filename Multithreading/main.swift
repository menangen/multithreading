//
//  main.swift
//  Multithreading
//
//  Created by menangen on 16/01/2019.
//  Copyright © 2019 menangen. All rights reserved.
//

import Foundation

var udpArray: [String] = ["Packet1", "Packet2", "Packet3"]

let operationQueue = OperationQueue()
let udpThread = UDPOperation()

for el in udpArray {
    let block = BlockOperation {
        print("Sending \(el) to Thread")
        
        udpThread.bufferSemaphore.wait()
            udpThread.thread1Buffer.append(el)
        udpThread.bufferSemaphore.signal()
        
        udpThread.runLoopSemaphore.signal()
        
    }
    
    operationQueue.addOperation(block)
}

operationQueue.addOperations([udpThread], waitUntilFinished: true)

print("thread1Buffer on END: ", udpThread.thread1Buffer)
