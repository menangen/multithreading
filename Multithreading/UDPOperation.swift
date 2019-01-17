//
//  UDPOperation.swift
//  Multithreading
//
//  Created by menangen on 17/01/2019.
//  Copyright © 2019 menangen. All rights reserved.
//

import Foundation

class UDPOperation : Operation {

    init(_ id: Int) {
        super.init()
        self.name = "(\(id)) UDP Worker"
    }
    
    override func main() {
        
        print("Enter Operation: \(self.name!) \n")
        
        while true {
            print("[\(self.name!)] Enter in loop")
            
            StartJobSemaphore.wait()
            
            if (self.name == nil) { break }
            
            print("[\(self.name!)] Go...")
            
            UDPBufferSemaphore.wait()
            
            if let el = udpBuffer.popLast() {
                UDPBufferSemaphore.signal()
                print("[\(self.name!)] processing |\(el)|")
            }
        }
    }
}
