//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by shengxiang guo on 1/21/16.
//  Copyright © 2016 shengxiang guo. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet var label: UILabel!
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = pokemon.name
    }



}
