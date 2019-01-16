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

let sema1 = DispatchSemaphore(value: 1)
let sema2 = DispatchSemaphore(value: 0)

let blockA = BlockOperation {
        
    print("Enter Block")
    
    for i in 0...2 {
        sema2.wait()
        
        let el: String = thread1Buffer.popLast() ?? "NULL"
        print("processing |\(el)|")
        
        if (i == 1) { break }
        // else { sema2.wait() }
    }
}

let operationQueue = OperationQueue()

let el = udpArray[0]

let block = BlockOperation {
    print("Sending \(el) to Thread")
    
    sema1.wait()
    
    thread1Buffer.append(el)
    
    sema2.signal()
    sema1.signal()
}

let block3 = BlockOperation {
    sleep(3)
    
    thread1Buffer.append("New Packet")
    sema2.signal()
}
operationQueue.addOperations([block, blockA, block3], waitUntilFinished: true)

print("thread1Buffer on END: ", thread1Buffer)
