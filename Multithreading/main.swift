//
//  main.swift
//  Multithreading
//
//  Created by menangen on 11/10/2016.
//  Copyright © 2016 menangen. All rights reserved.
//

import Foundation

let offset = 2
let threads = 4

var resultArray: [Int] = []

let wSquare = offset * 2 + 1
let sPixels = wSquare * wSquare

let outOfRangeElements = sPixels % threads
let elementInGroup = (sPixels - outOfRangeElements) / threads

func processPixels(_ number: Int, success: @escaping (Int) -> Void)->Void {
    DispatchQueue(label: "operations").async {
        print("Group #\(number) starts")
        success(number)
    }
}


let operationQueue = OperationQueue.main
var sema = DispatchSemaphore(value: 1)
let group = DispatchGroup()

for threadNumber in 1...threads {
    
    group.enter()
    
    let operation = Operation(
        processPixels(threadNumber) { groupNumber in
            let start = elementInGroup * (groupNumber - 1)
            var end = elementInGroup * groupNumber
            
            if (groupNumber == threads) {
                end += outOfRangeElements
            }
            
            var containerArray = [Int]()
            
            for pixelId in start..<end {
                let xInternalPixel = pixelId % wSquare - offset
                if (xInternalPixel > -1) {
                    containerArray.append(pixelId)
                    //containerArray.append(xInternalPixel)
                }
            }
            print("Group #\(groupNumber): \(start)-\(end) in container: \(containerArray) with length: \(containerArray.count)")
            
            sema.wait()
            resultArray.append(contentsOf: containerArray)
            sema.signal()
            group.leave()
        }
    )
    operation.name = "Operation #\(threadNumber)"
    operationQueue.addOperation(operation)
}

group.wait()
print(resultArray)
