//
//  HangmanViewController
//  Hangman
//
//  Created by iOS Decal on Feb 11 2020.
//  Copyright © 2020 iosdecal. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Instances: Models
    var hangman = Hangman();
    // MARK: - IBOutlets
    
    @IBOutlet weak var quit: UIButton!
    @IBOutlet weak var Letters: UILabel!
    @IBOutlet weak var letterInput: UITextField!
    @IBOutlet weak var incorrectGuesses: UILabel!
    @IBOutlet weak var progression: UIImageView!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var newGame: UIButton!
    // MARK: - Class Props/Vars
    var currImg = 0
    
    
    
    // MARK: - IBActions
    
    @IBAction func newGameFunc(_ sender: Any) {
        reset()
    }
    
    
    @IBAction func quitGame(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    
    @IBAction func guess(_ sender: Any) {
        if hangman.invalidChar(guess : letterInput.text!){
            letterInput.text = "";
            return
        }
        let s = letterInput.text!.lowercased()
        let c = Character(s)
        let state = hangman.checkGuess(guess: c)
        //correct guess
        if state == 3 {
            self.Letters.text = hangman.placeLetter(spots: self.Letters.text!, guess: c)
            if hangman.checkWin() == 1{
                //win alert
                let alert = UIAlertController(title: "You win!", message: "Try again?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
                    self.reset()}))
                alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "Default action"), style: .default, handler: { _ in
                    self.endGame()}))
                self.present(alert, animated: true, completion: nil)
            }
        }
            //wrong character guess
        else if state == 1 {
            self.incorrectGuesses.text! += String(c) + " "
            self.progression.image = UIImage(named: hangman.progression[hangman.currImg])
            if hangman.checkWin() == 2{
                //loss alert
                let alert = UIAlertController(title: "You lost!", message: "Try again?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
                    self.reset()}))
                alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "Default action"), style: .default, handler: { _ in
                    self.endGame()}))
                self.present(alert, animated: true, completion: nil)
            }
        }
        letterInput.text = "";
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reset()
        
        
        
        
        
    }
    
    // MARK: - Class Methods
    
    //function to limit letterInput to 1
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    
    
    //reset and start new game
    private func reset() -> Void {
        hangman = Hangman()
        letterInput.delegate = self
        self.Letters.text = hangman.createBlank(answer: hangman.answer)
        self.incorrectGuesses.text = "Incorrect Guesses: "
        print(hangman.answer)
        self.progression.image = UIImage(named: hangman.progression[hangman.currImg]);
    }
    
    //go back to main menu, resets game
    private func endGame()  {
        reset()
        performSegue(withIdentifier: "segue", sender: self)
    }
    
}
