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
    
    //MARK: Private Properties
    private var isRunning = false
    private var currentGridView: GridView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondGridView.isHidden = true
        secondGridView.isUserInteractionEnabled = false
        currentGridView = firstGridView

        // Do any additional setup after loading the view.
    }
    @IBAction func playButtonWasTapped(_ sender: Any) {
        // Change isRunning to true
        self.isRunning = true
        // While is running is true
        while self.isRunning == true {
            // Populate next grid view
            // Swap grid views
            
        }
    }
    
    @IBAction func pauseButtonWasTapped(_ sender: Any) {
        self.isRunning = false
    }
    
    @IBAction func stopButtonWasTapped(_ sender: Any) {
    }
    //MARK: Private Methods
    private func swapGridViews() {
        guard var currentGridView = currentGridView else {return}
        if currentGridView == firstGridView {
            currentGridView = secondGridView
            firstGridView.isHidden = true
            
        } else {
            currentGridView = firstGridView
            secondGridView.isHidden = true
        }
    }
    private func populateNextGridView() {
        if currentGridView == firstGridView {
            secondGridView = firstGridView.copy() as? GridView
            
        }
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
