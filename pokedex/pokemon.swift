//
//  pokemon.swift
//  pokedex
//
//  Created by shengxiang guo on 1/21/16.
//  Copyright © 2016 shengxiang guo. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _defense: String!
    private var _attack: String!
    private var _nextEvoText: String!
    private var _pokemonURL: String!
    
    var name: String{
        return _name
    }
    
    var pokedexID: Int{
        return _pokedexID
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexID = pokedexId
        
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexID)/"
    }
    
    func downloadPokemonDetails(completed:DownloadComplete){
        let url = NSURL(string: _pokemonURL)!
//        Alamofire.request(.GET, url).responseJSON{ (request: NSURLRequest?,
//            response: NSHTTPURLResponse?, result: Result<AnyObject>) -> Void in
//    }
         Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0{
                    //print(types.debugDescription)
                    if let name = types[0]["name"]{
                        self._type = name
                    }
                    
                    if types.count > 1{
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"]{
                                self._type! += "/\(name)"
                            }
                        }
                    }
                }else{
                    self._type = ""
                }
                
//                print(self._type)
//                print(self._weight)
//                print(self._height)
//                print(self._attack)
//                print(self._defense)

            }
        }
    }
}