//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var puzzleLabel : UILabel = UILabel()
    var completedPuzzleLabel : UILabel = UILabel()
    var incorrectGuessesLabel : UILabel = UILabel()
    var correctGuesses : [String] = []
    var lettersInPhrase : [String] = []
    var incorrectGuesses : [String] = []
    var finalPhrase : String = String()
    let numbersList = ["0","1","2","3","4","5","6","7","8","9"]
    let lettersList = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n",
                       "o","p","q","r","s","t","u","v","w","x","y","z"]
    var numIncorrectGuesses = 0
    var incorrectGuessesStr = ""
    let numMaxGuesses = 7
    var gameOver = false
    let imageView = UIImageView(frame: CGRect(x: 150, y: 100, width: 150, height: 150));
    
    
    @IBOutlet weak var hangmanImage: UIImageView!

    @IBOutlet weak var startOver: UIButton!
    @IBOutlet weak var userGuess: UITextField!
    
   @IBOutlet weak var submitGuess: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        finalPhrase = phrase!
        print(phrase)
        finalPhrase = phrase!
        var sizeOfPhrase = 0
        print(sizeOfPhrase)
        puzzleLabel = UILabel(frame: CGRect(x: 0, y: 0,width: 300, height: 600))
        puzzleLabel.center = CGPoint(x: 160, y: 285)
        puzzleLabel.numberOfLines = 0
        puzzleLabel.textAlignment = .center
        incorrectGuessesLabel.text = ""
        incorrectGuessesLabel = UILabel(frame: CGRect(x: 0, y: 0,width: 300, height: 200))
        incorrectGuessesLabel.center = CGPoint(x: 175, y: 475)
        incorrectGuessesLabel.textAlignment = .left
        var puzzle = ""
        var lettersSoFar = 0
        for i in phrase!.characters {
            if (i != " " ){
                sizeOfPhrase += 1
                puzzle += "_ "
                lettersSoFar += 1
               lettersInPhrase.append(String(i))
               lettersInPhrase.append(String(i).lowercased())
            }
//            else if (lettersSoFar > 20 && i == " "){
//                puzzle += "\n"
//            }
            else {
                puzzle += "   "
                lettersSoFar += 4
            }
        }
        
        print("final puzzle")
        print(puzzle)
        
        let image = UIImage(named: "white.gif");
        imageView.image = image;
        
        puzzleLabel.text = puzzle
        self.view.addSubview(puzzleLabel)
        self.view.addSubview(incorrectGuessesLabel)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitGuess(_ sender: AnyObject) {
        print("button hit!")
        if (userGuess.text!.characters.count == 1 &&
            lettersList.contains(String(userGuess.text!).lowercased())
            && !gameOver){
            if (lettersInPhrase.contains(String(userGuess.text!)) &&
                !correctGuesses.contains(String(userGuess.text!))){
              //correct guess
                correctGuesses.append(String(userGuess.text!))
                correctGuesses.append(String(userGuess.text!).uppercased())
                displayUpdatedGuesses()
                
            } else if (!incorrectGuesses.contains(String(userGuess.text!)) && !numbersList.contains(String(userGuess.text!))){
               // incorrect guess
                    incorrectGuess()
            }
        puzzleLabel.reloadInputViews()
        incorrectGuessesLabel.reloadInputViews()
        }
        userGuess.text = ""
        if (numIncorrectGuesses == numMaxGuesses) {
            lostGame()
        }
    }
    
  
    
    func displayUpdatedGuesses() {
        puzzleLabel.text = ""
        for char in finalPhrase.characters {
            if (correctGuesses.contains(String(char))) {
                puzzleLabel.text! += String(char).uppercased()
            } else if (char == " ") {
                puzzleLabel.text! += "   "
            } else {
                puzzleLabel.text! += "_ "
            }
        }
        
        if (!puzzleLabel.text!.contains("_")){
            wonGame()
        }
    }
    
    func incorrectGuess(){
        incorrectGuesses.append(String(userGuess.text!).lowercased())
        incorrectGuesses.append(String(userGuess.text!).uppercased())
        if (incorrectGuessesStr != ""){
            incorrectGuessesStr += ", "
        }
        incorrectGuessesStr += String(userGuess.text!).uppercased()
        incorrectGuessesLabel.text = incorrectGuessesStr
        numIncorrectGuesses += 1
        print("incorrect letter")
        print(String(userGuess.text!).uppercased())
        print("incorrect label")
        print(incorrectGuessesLabel.text!)
        displayCorrectImage()
    }
    
    func displayCorrectImage() {
        
        if (numIncorrectGuesses == 1) {
            // set as you want
             let image = UIImage(named: "hangman1.gif");
             imageView.image = image;
        } else if (numIncorrectGuesses == 2) {
             let image = UIImage(named: "hangman2.gif");
             imageView.image = image;
        } else if (numIncorrectGuesses == 3) {
             let image = UIImage(named: "hangman3.gif");
             imageView.image = image;
        } else if (numIncorrectGuesses == 4) {
             let image = UIImage(named: "hangman4.gif");
             imageView.image = image;
        } else if (numIncorrectGuesses == 5) {
             let image = UIImage(named: "hangman5.gif");
             imageView.image = image;
        } else if (numIncorrectGuesses == 6) {
             let image = UIImage(named: "hangman6.gif");
             imageView.image = image;
        } else if (numIncorrectGuesses == 7){
             let image = UIImage(named: "hangman7.gif");
             imageView.image = image;
        }
       
        self.view.addSubview(imageView);
    }

    
    func wonGame(){
        print("Won")
        let alertController = UIAlertController(title: "Congratulations!", message:
            "You won!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        gameOver = true
    }
    
    func lostGame(){
        print("lost")
        
        let alertController = UIAlertController(title: "I'm sorry!", message:
            "You lost. The phrase was " + finalPhrase, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        gameOver = true

    }
    

    @IBAction func startOver(_ sender: AnyObject) {
        print("start over")
        puzzleLabel.text = ""
        correctGuesses = []
        lettersInPhrase = []
        incorrectGuesses = []
        finalPhrase = String()
        numIncorrectGuesses = 0
        incorrectGuessesStr = ""
        gameOver = false
        reset()
        let image = UIImage(named: "white.gif")
        imageView.image = image
        puzzleLabel.reloadInputViews()
        incorrectGuessesLabel.reloadInputViews()
        
    }
    
    func reset() {
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        finalPhrase = phrase!
        var sizeOfPhrase = 0
        print(sizeOfPhrase)
        incorrectGuessesLabel.text = ""
        completedPuzzleLabel.text = ""
        var puzzle = ""
        var lettersSoFar = 0
        for i in phrase!.characters {
            if (i != " " ){
                sizeOfPhrase += 1
                puzzle += "_ "
                lettersSoFar += 1
                lettersInPhrase.append(String(i))
                lettersInPhrase.append(String(i).lowercased())
            } else if (lettersSoFar > 20 && i == " "){
                puzzle += "\n"
            }else {
                puzzle += "   "
                lettersSoFar += 4
            }
        }
        
        
        print("final puzzle")
        print(puzzle)
        
        puzzleLabel.text = puzzle
    }
    
    }
    /*
    // MARK: - Navigation


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

