//
//  JobQueue.swift
//  SwiftUIHomework5 (iOS)
//
//  Created by Mikhail Kanshin on 17.07.2022.
//

import Foundation

final class JobQueue {
    private var queue : [JobProtocol] = []
    private var index : Int = -1
    private let lock  : NSLock = NSLock()
    
    func add(_ job: JobProtocol) {
        assert(index < 0, "adding not allowed")
        lock.lock()
        queue.append(job.copy() as! JobProtocol)
        lock.unlock()
    }
    
    // TODO: Добавить приотритеты
    func next() -> JobProtocol? {
        guard index < queue.count - 1 else { return nil }
        index += 1
        return queue[index]
    }
}
