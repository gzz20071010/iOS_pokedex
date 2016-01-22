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
        let img = UIImage(named: "\(pokemon.pokedexID)")
        mainImg.image = img
        nextEvoImg.image = img
        
        
        pokemon.downloadPokemonDetails { () -> () in
            //print("did we get here")
            self.updateUI()
        }
    }
    
    func updateUI(){
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        pokedexIDLbl.text = "\(pokemon.pokedexID)"
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.attack
        
        
        if pokemon.nextEvoID == ""{
            evoLbl.text = "No evolutions"
            finalEvoImg.hidden = true
        }else{
            finalEvoImg.hidden = false
            finalEvoImg.image = UIImage(named: pokemon.nextEvoID)
            var str = "Next Evolution \(pokemon.nextEvoText)"
            
            if pokemon.nextEvoLvl != "" {
                str += "- LV \(pokemon.nextEvoLvl)"
            }
            evoLbl.text = str
        }
        
    }


    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
