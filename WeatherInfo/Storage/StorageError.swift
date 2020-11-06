//
//  StorageError.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation

enum StorageError: Error {
    case urlError
    case networkUnavailable
    case wrongDataFormat
    case creationError
}

extension StorageError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .urlError:
            return NSLocalizedString("Could not create a URL.", comment: "")
        case .networkUnavailable:
            return NSLocalizedString("Could not get data from the remote server.", comment: "")
        case .wrongDataFormat:
            return NSLocalizedString("Could not digest the fetched data.", comment: "")
        case .creationError:
            return NSLocalizedString("Failed to create a new object.", comment: "")
        }
    }
}
