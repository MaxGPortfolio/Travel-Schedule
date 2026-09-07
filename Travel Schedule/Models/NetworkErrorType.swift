//
//  NetworkErrorType.swift
//  Travel Schedule
//
//  Created by Максим on 19.08.2026.
//
import Foundation

enum NetworkErrorType: CaseIterable, Sendable {
    case server
    case noInternet

    var title: String {
        switch self {
        case .server:
            return "Ошибка сервера"
        case .noInternet:
            return "Нет интернета"
        }
    }

    var imageName: String {
        switch self {
        case .server:
            return "ServerError"
        case .noInternet:
            return "NoInternet"
        }
    }
    
    static func from(_ error: Error) -> NetworkErrorType {
        guard let urlError = error as? URLError else {
            return .server
        }

        switch urlError.code {
        case .notConnectedToInternet,
             .networkConnectionLost,
             .cannotConnectToHost,
             .cannotFindHost,
             .dnsLookupFailed:
            return .noInternet

        default:
            return .server
        }
    }
}
