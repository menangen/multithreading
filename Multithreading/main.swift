//
//  main.swift
//  Multithreading
//
//  Created by menangen on 16/01/2019.
//  Copyright © 2019 menangen. All rights reserved.
//

import Foundation

var udpArray: [String] = ["Packet1", "Packet2", "Packet3"]

var thread1Buffer: [String] = []

let operationQueue = OperationQueue()

let bufferSemaphore = DispatchSemaphore(value: 1)
let runLoopSemaphore = DispatchSemaphore(value: 0)

let blockA = BlockOperation {
        
    print("Enter Block A")
    
    while true {
        runLoopSemaphore.wait()
        
        bufferSemaphore.wait()
        let el: String = thread1Buffer.popLast() ?? "NULL"
        bufferSemaphore.signal()
        print("processing |\(el)|", Thread.current)
        
        sleep(3)
        
        bufferSemaphore.wait()
        if (thread1Buffer.count == 0) { break }
        bufferSemaphore.signal()
    }
}

for el in udpArray {
    let block = BlockOperation {
        print("Sending \(el) to Thread")
        
        bufferSemaphore.wait()
        
        thread1Buffer.append(el)
        
        runLoopSemaphore.signal()
        bufferSemaphore.signal()
        
    }
    
    operationQueue.addOperation(block)
}

operationQueue.addOperations([blockA], waitUntilFinished: true)

print("thread1Buffer on END: ", thread1Buffer)
