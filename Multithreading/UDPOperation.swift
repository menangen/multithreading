//
//  UDPOperation.swift
//  Multithreading
//
//  Created by menangen on 17/01/2019.
//  Copyright © 2019 menangen. All rights reserved.
//

import Foundation

class UDPOperation : Operation {
    public var
    thread1Buffer: [String] = []
    
    public let
    bufferSemaphore = DispatchSemaphore(value: 1)
    
    public let
    runLoopSemaphore = DispatchSemaphore(value: 0)
    
    override func main() {
        print("Enter Operation", Thread.current)
        
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
}
