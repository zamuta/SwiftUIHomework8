//
//  MeasureTimeJob.swift
//  SwiftUIHomework5 (iOS)
//
//  Created by Mikhail Kanshin on 17.07.2022.
//

import Foundation

class MeasureTimeJob<T>: HandlerJob<T> {
    private(set) var measureTime : TimeInterval?
    
    override func job() async throws -> Any {
        let start = CFAbsoluteTimeGetCurrent()
        let result = try await super.job()
        let end = CFAbsoluteTimeGetCurrent()
        self.measureTime = end - start
        return result
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let actionHandler = self.actionHandler
        let copy = MeasureTimeJob(actionHandler)
        return copy
    }
}
