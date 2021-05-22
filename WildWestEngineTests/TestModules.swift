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
            let resourcesLoader: ResourcesLoaderProtocol = resolve()
            let abilities = resourcesLoader.loadAbilities()
            return AbilityMatcher(abilities: abilities,
                                  effectMatcher: EffectMatcher(),
                                  playReqMatcher: PlayReqMatcher())
        }.scope(application)
        
        register(GAbilityMatcher.self) {
            let resourcesLoader: ResourcesLoaderProtocol = resolve()
            let abilities = resourcesLoader.loadGAbilities()
            return GAbilityMatcher(abilities)
        }.scope(application)
    }
}
