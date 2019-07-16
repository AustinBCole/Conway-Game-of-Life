//
//  GameOfLifeViewController.swift
//  Game-of-Life
//
//  Created by Austin Cole on 7/16/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

class GameOfLifeViewController: UIViewController {
    @IBOutlet weak var generationNumberLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var firstGridView: GridView!
    @IBOutlet weak var secondGridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func playButtonWasTapped(_ sender: Any) {
    }
    
    @IBAction func pauseButtonWasTapped(_ sender: Any) {
    }
    
    @IBAction func stopButtonWasTapped(_ sender: Any) {
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
