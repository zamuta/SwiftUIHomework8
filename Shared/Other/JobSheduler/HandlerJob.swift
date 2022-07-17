//
//  HandlerJob.swift
//  SwiftUIHomework5 (iOS)
//
//  Created by Mikhail Kanshin on 17.07.2022.
//

import Foundation

typealias JobActionHandler<T> = () -> T

class HandlerJob<T>: JobProtocol {    
    private(set) var actionHandler : JobActionHandler<T>
    
    init(_ actionHandler: @escaping JobActionHandler<T>) {
        self.actionHandler = actionHandler
    }
    
    func job() async throws -> Any {
        return actionHandler()
    }
    
    func execute(_ completionHandler: @escaping JobCompletionHandler) {
        Task.detached { [weak self] in
            guard let self = self else { return }
            let result = try await self.job()
            await MainActor.run {
                completionHandler(result)
            }
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let actionHandler = self.actionHandler
        let copy = HandlerJob(actionHandler)
        return copy
    }
}
