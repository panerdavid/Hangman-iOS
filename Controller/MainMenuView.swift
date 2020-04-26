//
//  MainMenuView.swift
//  Hangman
//
//  Created by David Paner on 3/6/20.
//  Copyright © 2020 Tim's Apples. All rights reserved.
//

import UIKit

class MainMenuView: UIViewController {

    @IBOutlet var play: UIView!
    
    @IBOutlet weak var logo: UIImageView!
    //launches game
    @IBAction func launchGame(_ sender: Any) {
              performSegue(withIdentifier: "toGame", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logo.image = UIImage(named : "hangman7" )
        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
