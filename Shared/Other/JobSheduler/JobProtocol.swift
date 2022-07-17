//
//  JobProtocol.swift
//  SwiftUIHomework5 (iOS)
//
//  Created by Mikhail Kanshin on 17.07.2022.
//

import Foundation

typealias JobCompletionHandler = (Any) -> Void

protocol JobProtocol : NSCopying {
    func job() async throws -> Any
    func execute(_ completionHandler: @escaping JobCompletionHandler)
}
