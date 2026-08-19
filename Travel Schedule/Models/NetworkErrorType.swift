//
//  NetworkErrorType.swift
//  Travel Schedule
//
//  Created by Максим on 19.08.2026.
//

enum NetworkErrorType: CaseIterable {
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
}
