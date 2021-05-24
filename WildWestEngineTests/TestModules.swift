//
//  TestModules.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 25/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Resolver
import WildWestEngine

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {

        register { JsonReader(bundle: Bundle.resourcesBundle) }.scope(application)

        register { ResourcesLoader(jsonReader: resolve()) as ResourcesLoaderProtocol }.scope(application)
        
        register(AbilityMatcherProtocol.self) {
            let resourcesLoader = resolve(ResourcesLoaderProtocol.self)
            let abilities = resourcesLoader.loadAbilities()
            return AbilityMatcher(abilities)
        }.scope(application)
    }
}
