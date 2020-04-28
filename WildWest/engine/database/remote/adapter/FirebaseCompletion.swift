//
//  FirebaseCompletion.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

enum Result<T> {
  case success(T)
  case error(Error)
}

typealias FirebaseCompletion = (Error?) -> Void
typealias FirebaseCardCompletion = (CardProtocol?, Error?) -> Void
typealias FirebaseStateCompletion = (Result<GameStateProtocol>) -> Void
typealias FirebaseStringCompletion = (Result<String>) -> Void
