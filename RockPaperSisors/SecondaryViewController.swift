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
    
    var numberOfPlayers:Int = 1
    var userChoice:Int = 0
    var opponentChoice:Int = 0
    var userWon:Bool = false
    var userTie:Bool = false
    let ROCK:Int = 1
    let PAPER:Int = 2
    let SCISSORS:Int = 3
    
    var swipeOne: UISwipeGestureRecognizer!
    var swipeTwo: UISwipeGestureRecognizer!
    var swipeThree: UISwipeGestureRecognizer!
    
    
    
    
    //TODO: Generate Computer Choice function
    //TODO: Game Logic Function
    

    
    @IBOutlet weak var Button_Play: UIButton!
    @IBOutlet weak var Label_UserChoice: UILabel!
    @IBOutlet weak var Button_Rock: UIButton!
    @IBOutlet weak var Button_Paper: UIButton!
    @IBOutlet weak var Button_Scissors: UIButton!
    @IBOutlet weak var Label_Results: UILabel!
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //INIT: Gesture Recognizers
        self.swipeOne = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeOne.numberOfTouchesRequired = 1
        swipeOne.direction = UISwipeGestureRecognizerDirection.Down
        
        self.swipeTwo = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeTwo.numberOfTouchesRequired = 2
        swipeTwo.direction = UISwipeGestureRecognizerDirection.Down
        swipeOne.requireGestureRecognizerToFail(swipeTwo)
        
        self.swipeThree = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeThree.numberOfTouchesRequired = 3
        swipeThree.direction = UISwipeGestureRecognizerDirection.Down
        swipeTwo.requireGestureRecognizerToFail(swipeThree)
        swipeOne.requireGestureRecognizerToFail(swipeThree)
        
        self.view.addGestureRecognizer(swipeOne)
        self.view.addGestureRecognizer(swipeTwo)
        self.view.addGestureRecognizer(swipeThree)
        
        
    }
    

    @IBAction func OnClick_RockButton(sender: AnyObject) {
        self.Label_UserChoice.text = "You have chosen ROCK"
        userChoice = ROCK
        UI_SetButtonColors()
        Button_Rock.backgroundColor = UIColor.greenColor()
        Button_Rock.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        println("Userchoice: Rock")
    }
    
    @IBAction func OnClick_PaperButton(sender: AnyObject) {
        self.Label_UserChoice.text = "You have chosen PAPER"
        userChoice = PAPER
        UI_SetButtonColors()
        Button_Paper.backgroundColor = UIColor.greenColor()
        Button_Paper.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        println("Userchoice: Paper")
    }
    
    @IBAction func OnClick_ScissorsButton(sender: AnyObject) {
        self.Label_UserChoice.text = "You have chosen SCISSORS"
        userChoice = SCISSORS
        UI_SetButtonColors()
        Button_Scissors.backgroundColor = UIColor.greenColor()
        Button_Scissors.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        println("Userchoice: Scissors")
    }
    
    @IBAction func OnClick_PlayButton(sender: AnyObject) {
        userTie = false
        GameLogic_GenerateComputerChoice()
        GameLogic_ComputeResults()
        GameLogic_DisplayResults()
    }

    func UI_SetButtonColors(){
        Button_Scissors.backgroundColor = UIColor.whiteColor()
        Button_Scissors.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        Button_Paper.backgroundColor = UIColor.whiteColor()
        Button_Paper.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        Button_Rock.backgroundColor = UIColor.whiteColor()
        Button_Rock.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    }
    
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) { //Handle All Gestures
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.numberOfTouches() {
            case 1:
                OnClick_RockButton(Button_Rock)
                println("Swiped with 1")
            case 2:
                OnClick_PaperButton(Button_Paper)
                println("Swiped with 2")
            case 3:
                OnClick_ScissorsButton(Button_Scissors)
                println("Swiped with 3")
            default:
                break
            }
        }
    }
    
    func GameLogic_DisplayResults(){
        if numberOfPlayers == 1{
            if userTie{
                Label_Results.text = "Tie Game"
            }
            else if userWon{
                Label_Results.text = "You Win!"
            }
            else{
                Label_Results.text = "You Lose :("
            }
        }
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
                userTie = true
                break;
            case PAPER:
                //Loss
                println("User Loses")
                userWon = false
                break;
            case SCISSORS:
                //Win
                println("User Wins")
                userWon = true
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
                userWon = true
                break;
            case PAPER:
                //Tie
                println("Tie Game")
                userTie = true
                break;
            case SCISSORS:
                //Loss
                println("User Loses")
                userWon = false
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
                userWon = false
                break;
            case PAPER:
                //Win
                println("User Wins")
                userWon = true
                break;
            case SCISSORS:
                //Tie
                println("Tie Game")
                userTie = true
                break;
            default:
                break;
            }
        }
    }
}