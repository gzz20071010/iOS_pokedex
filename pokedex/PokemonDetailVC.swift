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
    
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var typeLbl: UILabel!
    @IBOutlet var defenseLbl: UILabel!
    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var baseAttackLbl: UILabel!
    @IBOutlet var heightLbl: UILabel!
    @IBOutlet var pokedexIDLbl: UILabel!
    @IBOutlet var evoLbl: UILabel!
    
    @IBOutlet var nextEvoImg: UIImageView!
    @IBOutlet var finalEvoImg: UIImageView!
    
    
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedexID)")
        pokemon.downloadPokemonDetails { () -> () in
            //this will be called after download is done
        }
    }


    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
