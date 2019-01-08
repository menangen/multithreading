import Foundation

func twoThreads() {
    let operationQueue = OperationQueue()
    
    let thread1 = BlockOperation {
        print("Hi from 1!")
        print("1 is end..", Thread.current)
    }
    
    let thread2 = BlockOperation {
        print("Hi from 2!")
        print("2 is end..", Thread.current)
    }
    
    let thread3 = BlockOperation {
        print("Hi from 3!")
        print("3 is end..", Thread.current)
    }
    
    thread3.addDependency(thread2)

    print("Running in current thread: ", Thread.current)
    operationQueue.addOperations([thread1, thread2, thread3], waitUntilFinished: true)
}

func useAccessRace() {
    let operationQueue = OperationQueue()
    
    var unsafeArray = [Int]()
    
    func modificateArray(_ seed: Int) {
        print("Appending \(seed)", Thread.current)
        unsafeArray.append(seed)
        
        print(unsafeArray)
    }
    
    for threadNumber in 1...2 {
        let operation = BlockOperation {
            print(threadNumber, Thread.current)
            
            modificateArray(threadNumber)
        }
        operationQueue.addOperation(operation);
    }
    
    operationQueue.waitUntilAllOperationsAreFinished()
    print("end")
}
