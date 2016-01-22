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
    private var _nextEvoId: String!
    private var _nextEvoLvl: String!
    private var _pokemonURL: String!
    
    var nextEvoText: String{
        get{
            if _nextEvoText == nil{
                _nextEvoText = ""
            }
            return _nextEvoText
        }
    }
    
    var nextEvoLvl: String{
        if _nextEvoLvl == nil{
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
    
    var nextEvoID: String{
        if _nextEvoId == nil{
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type: String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defense: String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var height: String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String{
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
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
                
                print(self._type)
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"]{
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON{ response in
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject>{
                                if let description = descDict["description"] as? String{
                                    self._description = description
                                    print(self._description)
                                }
                            }
                           completed()
                        }
                    }
                }else{
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    if let to =  evolutions[0]["to"] as? String{
                        //'mega' is not found/ cant support mega api right now
                        if to.rangeOfString("mega") == nil{
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvoId = num
                                self._nextEvoText = to
                              //  self._nextEvoLvl
                                
                                if let level = evolutions[0]["level"] as? Int{
                                    self._nextEvoLvl = "\(level)"
                                }else{
                                    self._nextEvoLvl = "N/A"
                                }
                                print("here")
                                print(self._pokedexID)
                                print(self._nextEvoLvl)
                                print(self._nextEvoId)
                                print(self._nextEvoText)
                            }
                        }
                    }
                }
            }
        }
    }
}