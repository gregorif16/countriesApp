//
//  NetworkError.swift
//  iOsCodingAssigment
//
//  Created by Gregori Farias on 23/2/24.
//

import Foundation

enum NetworkError: Error {
    case malformedURL
    case dataFormatting
    case other
    case noData
    case errorCode(Int?)
    case decoding
}
