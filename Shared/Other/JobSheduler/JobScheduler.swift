//
//  JobScheduler.swift
//  SwiftUIHomework5 (iOS)
//
//  Created by Mikhail Kanshin on 17.07.2022.
//

import Foundation

typealias JobSchedulerCompletionHandler<T: JobProtocol> = ([T]) -> Void

final class JobScheduler<T: JobProtocol> {
    var completionHandler : JobSchedulerCompletionHandler<T>? = nil
    
    private(set) var isExecuting : Bool = false
    private(set) var isCompleted : Bool = false
    
    private var jobQueue: JobQueue? = nil
    private var completedJobs : [T] = []
    
    func add(_ job: T) {
        if jobQueue == nil {
            jobQueue = .init()
        }
        jobQueue!.add(job)
    }
    
    func executeAll() {
        isExecuting = true
        r_executeAll()
    }
    
    private func r_executeAll() {
        guard jobQueue != nil else { return }
        let job = jobQueue!.next()
        if job != nil {
            job!.execute({[weak self] result in
                guard let self = self else { return }
                self.completedJobs.append(job as! T)
                self.r_executeAll()
            })
        } else {
            self.jobQueue = nil
            self.isExecuting = false
            self.isCompleted = true
            if self.completionHandler != nil {
                self.completionHandler!(self.completedJobs)
            }
        }
    }
}
