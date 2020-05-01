//
//  FirebaseCompletion.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

enum EmptyResult {
    case success
    case error(Error)
}

enum Result<T> {
    case success(T)
    case error(Error)
}

typealias FirebaseCompletion = (EmptyResult) -> Void
typealias FirebaseCardCompletion = (Result<CardProtocol>) -> Void
typealias FirebaseStateCompletion = (Result<GameStateProtocol>) -> Void
typealias FirebaseUpdateCompletion = (Result<GameUpdate>) -> Void
typealias FirebaseOptionalMoveCompletion = (Result<GameMove?>) -> Void
typealias FirebaseMovesCompletion = (Result<[GameMove]>) -> Void

func result(from error: Error?) -> EmptyResult {
    if let error = error {
        return .error(error)
    } else {
        return .success
    }
}
