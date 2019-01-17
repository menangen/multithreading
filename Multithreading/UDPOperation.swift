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
        
        print("Enter Operation: \(self.name!)")
        
        
        while true {
            UDPBufferSemaphore.wait()
            
            if let el = udpBuffer.popLast() {
                UDPBufferSemaphore.signal()
                print("[\(self.name!)] processing |\(el)|")
                
                sleep(1)
            }

            else {
                UDPBufferSemaphore.signal()
                print("[\(self.name!)] Completed")
            
                break
            }
        }
    }
}
