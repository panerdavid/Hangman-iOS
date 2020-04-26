//
//  Hangman.swift
//  Hangman
//
//  Created by Jackson Chui on 2/20/20.
//  Copyright © 2020 Tim"s Apples. All rights reserved.
//

import Foundation

class Hangman {
    let wwdcArray:[String] = [
        "Good morning",
        "We have developers here",
        "June Fourth",
        "World Wide Developers Conference",
        "San Jose Convention Center",
        "App Store turns ten",
        "This is mind blowing",
        "This is beyond remarkable",
        "the power of code",
        "Everyone Can Code",
        "changing the world",
        "Today is all about software",
        "Craig Federighi",
        "Hair Force One",
        "tens of millions of students",
        "Swift on the App Store",
        "fastest growing programming language",
        "Swift Playgrounds",
        "group of creators",
        "The App Store",
        "Your creativity and hard work",
        "Tim Cook",
        "Split View",
        "Drag and Drop",
        "Slide Over",
        "ARKit",
        "Find My",
        "iMessage",
        "Airpods Pro",
        "Voice Memos",
        "Apple News",
        "Do Not Disturb",
        "Apple Park",
        "Apple Watch Series",
        "Siri Shortcuts",
        "macOS Mojave",
        "macOS Catalina",
        "macOS High Sierra",
        "AMD Vega Pro",
        "Macbook Pro",
        "Core ML",
        "iMac Pro"
    ]
    
    // MARK: - Your Code Here
    
    //array to hold file names of hangman pics
     let progression = ["hangman1", "hangman2", "hangman3", "hangman4", "hangman5", "hangman6", "hangman7"]
    
    //array of valid characters
    let validChars = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

    //set of played characters
    var used = Set<Character>()
    //array of correct characters
    var correct:[Character]
    //string to hold solution to hangman puzzle
    var answer = ""
    //current index of progression
    var currImg = 0
    //set of answer"s charaters
    var letters = Set<Character>()
    //index map that includes spaces for answer
    var indices: [Int : Character] = [:]
    

    
  
    
    //creates instance of hangman
    init() {
        //pick random word
        self.answer = wwdcArray.randomElement()!
        //create empty array for correct
        self.correct = []
        //fill out letters set
        for c in answer {
            if c != " " {
                letters.insert(Character(c.lowercased()))
            }
        }
        
        
    }
    //_ _  _ _
    
    
    //creates blank spaces and accounts for spaces in answer
    func createBlank(answer: String) -> String{
        var result = ""
        var i = 0
        for char in answer {
            if char != " " {
                result += "_"
                indices[i] = char
                result += " "
                i+=1
                
                
            }
            else {
                result += " "
            }
            i += 1
        }
        return result;
    }
    
    //helper function to replace character at an index
    func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    
    //check if guess is correct
    func checkGuess(guess: Character) -> Int {
        
        if !letters.contains(guess) && !used.contains(guess) {
            
            currImg += 1
            
            used.insert(guess)
            
            return 1
        }
        //incorrect but repeat
        if used.contains(guess) {
            return 2
        }
        //correct
        used.insert(guess)
        return 3
    }
    
    //update the blank string with correct letter, call only when character is correct
    func placeLetter(spots: String, guess: Character) -> String {
        var i = 0
        var update = spots
        for char in spots {
            if char == "_" {
                
                if String(guess) == indices[i]?.lowercased(){
                    
                    update = replace(myString: update, i, indices[i]!)
                }
                
            }
            
            i += 1
            
        }
        letters.remove(guess)
        return update
    }
    
    //checks to see if hangman state is a win, loss, or in progress
    func checkWin() -> Int{
        if currImg == 6 {
        return 2
        }
        else if letters.isEmpty {
            return 1
        }
        else {
            return 3
        }
    }
    
    func invalidChar(guess : String) -> Bool {
        return !validChars.contains(guess)
    }
    
    
    
    
    
}


