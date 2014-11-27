//
//  RockPaperSisorsView.swift
//  Homework1
//
//  Created by Kieley, James P on 11/24/14.
//  Copyright (c) 2014 Kieley, James P. All rights reserved.
//

import Foundation
import SpriteKit


class SecondaryViewController: UIViewController {
    //TODO: UserChoice variable
    // Rock:1 Paper:2 Scissors:3
    
    var userChoice:Int = 0
    var opponentChoice:Int = 0
    let ROCK:Int = 1
    let PAPER:Int = 2
    let SCISSORS:Int = 3
    
    
    //TODO: Generate Computer Choice function
    //TODO: Game Logic Function
    

    
    @IBOutlet weak var Button_Play: UIButton!
    @IBOutlet weak var Label_UserChoice: UILabel!
    

    @IBAction func OnClick_RockButton(sender: AnyObject) {
        self.Label_UserChoice.text = "You have chosen ROCK"
        userChoice = ROCK
        println("Userchoice: Rock")
    }
    
    @IBAction func OnClick_PaperButton(sender: AnyObject) {
        self.Label_UserChoice.text = "You have chosen PAPER"
        userChoice = PAPER
        println("Userchoice: Paper")
    }

    
    @IBAction func OnClick_ScissorsButton(sender: AnyObject) {
        self.Label_UserChoice.text = "You have chosen SCISSORS"
        userChoice = SCISSORS
        println("Userchoice: Scissors")
    }
    
    @IBAction func OnClick_PlayButton(sender: AnyObject) {
        GameLogic_GenerateComputerChoice()
    }

    
    func GameLogic_GenerateComputerChoice(){
        opponentChoice = Int(arc4random_uniform(3)) + 1
        
        switch(opponentChoice){
        case 1:
            println("OpponentChoice: Rock")
            break
        case 2:
            println("OpponentChoice: Paper")
            break
        case 3:
            println("OpponentChoice: Scissors")
            break
        default:
            break
        }
        
    }
    
    func GameLogic_ComputeResults(){
        if userChoice == ROCK {
            switch(opponentChoice){
            case ROCK:
                //Tie
                println("Tie Game")
                break;
            case PAPER:
                //Loss
                println("User Loses")
                break;
            case SCISSORS:
                //Win
                println("User Wins")
                break;
            default:
                break;
            }
            
        }

        else if userChoice == PAPER {
            switch(opponentChoice){
            case ROCK:
                //Win
                println("User Wins")
                break;
            case PAPER:
                //Tie
                println("Tie Game")
                break;
            case SCISSORS:
                //Loss
                println("User Loses")
                break;
            default:
                break;
            }
            
        }
        
        else if userChoice == SCISSORS {
            switch(opponentChoice){
            case ROCK:
                //Loss
                println("User Loses")
                break;
            case PAPER:
                //Win
                println("User Wins")
                break;
            case SCISSORS:
                //Tie
                println("Tie Game")
                break;
            default:
                break;
            }
        }
    }
}