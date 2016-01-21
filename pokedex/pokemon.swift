//
//  pokemon.swift
//  pokedex
//
//  Created by shengxiang guo on 1/21/16.
//  Copyright © 2016 shengxiang guo. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    
    var name: String{
        return _name
    }
    
    var pokedexID: Int{
        return _pokedexID
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexID = pokedexId
    }
}