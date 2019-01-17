//
//  main.swift
//  Multithreading
//
//  Created by menangen on 16/01/2019.
//  Copyright © 2019 menangen. All rights reserved.
//

import Foundation

let UDPBufferSemaphore = DispatchSemaphore(value: 1)
var udpBuffer: [String] = ["Packet1", "Packet2", "Packet3", "Packet4"]

var operationsList = [UDPOperation]()
let operationQueue = OperationQueue()


for index in 0...1 {
    let op = UDPOperation(index)
    operationsList.append(op)
}

operationQueue.addOperations(operationsList, waitUntilFinished: true)
