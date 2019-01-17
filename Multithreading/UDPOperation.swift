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
    packetBuffer: [String] = []
    
    public let
    runLoopSemaphore = DispatchSemaphore(value: 0)
    
    init(_ id: Int) {
        super.init()
        self.name = "(\(id)) UDP Worker"
    }
    
    override func main() {
        
        print("Enter Operation: \(self.name!)")
        group.enter()
        
        while true {
            runLoopSemaphore.wait()

            print("[\(self.name!)] packetBuffer = ", packetBuffer)
            
            let el: String = packetBuffer.popLast() ?? "NULL"

            print("[\(self.name!)] processing |\(el)|")
            
            sleep(2)

            if (packetBuffer.isEmpty) {
                print("[\(self.name!)] Completed")
                
                group.leave()
                break
            }
        }
    }
}
