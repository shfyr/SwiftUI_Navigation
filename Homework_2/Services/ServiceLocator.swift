//
//  ServiceLocator.swift
//  Homework_2
//
//  Created by Elizaveta on 16.12.2024.
//

import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()
    private var services: [String: Any] = [:]
    
    private init() {}
    
    func register<T>(_ service: T, for type: T.Type) {
        let key = String(describing: type)
        services[key] = service
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        guard let service = services[key] as? T else {
            fatalError("No service registered for \(key)")
        }
        return service
    }
}
