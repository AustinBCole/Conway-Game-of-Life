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
//    @IBOutlet weak var secondGridView: GridView!
    
    //MARK: Private Properties
    private var count = 0
    private let cellularAutomataOpQ = OperationQueue()
    private var isRunning = false
    private var currentGridView: GridView?
    /// Every time this variable is set, it will run swapGridViews() and populateNextGridView() so long as isRunning is true
    private var currentGeneration: Int = 1 {
        willSet {
            if self.isRunning == true && newValue != 1 {
                DispatchQueue.main.async {
                    //self.swapGridViews()
                    self.updateGenerationNumberLabel()
                }
                cellularAutomataOpQ.addOperation {
                    sleep(UInt32(1))
                    self.repopulateGridView()
                    //self.populateNextGridView()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        secondGridView.isHidden = true
//        secondGridView.isUserInteractionEnabled = false
        currentGridView = firstGridView
        generationNumberLabel.text = "Current Generation: \(currentGeneration)"

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let array = currentGridView?.getGridCells()

        array?[0].toggleState()
        array?[1].toggleState()
        array?[2].toggleState()
        array?[3].toggleState()

    }
    @IBAction func playButtonWasTapped(_ sender: Any) {
        // Create operation queues and operations so that this doesn't junk up the main thread
        self.isRunning = true
        cellularAutomataOpQ.addOperation(repopulateGridView)
    }
    
    @IBAction func pauseButtonWasTapped(_ sender: Any) {
        self.isRunning = false
    }
    
    @IBAction func stopButtonWasTapped(_ sender: Any) {
        // Set is running to false
        self.isRunning = false
        // Change state of all cells to dead
        for cell in currentGridView!.getGridCells() {
            if cell.getCurrentState() == 1 {
                cell.toggleState()
            }
        }
        // Reset the current generation number
        currentGeneration = 1
        updateGenerationNumberLabel()
    }
    //MARK: Private Methods
//    private func swapGridViews() {
//        guard var currentGridView = currentGridView else {return}
//        if currentGridView == firstGridView {
//            currentGridView = secondGridView
//            firstGridView.isHidden = true
//            secondGridView.isHidden = false
//
//        } else {
//            currentGridView = firstGridView
//            secondGridView.isHidden = true
//            firstGridView.isHidden = false
//        }
//    }
    /// This method populates the next grid view and updates the current generation count. Every time current generation value is set, this method is called. It is a loop that is only broken when isRunning is equal to false.
//    private func populateNextGridView() {
//        // If current grid view is first grid view
//        if currentGridView == firstGridView {
//            let gridCopy = secondGridView
//            // Swap second view for first view
//            secondGridView = firstGridView
//            // Swap first view for grid copy
//            firstGridView = gridCopy
//            // Call cell automaton method
//            CellAutomaton().cellAutomaton(gridView: secondGridView)
//        // else, do the opposite
//        } else {
//            let gridCopy = firstGridView
//            // Swap first view for second view
//            firstGridView = secondGridView
//            // Swap second view for grid copy
//            secondGridView = gridCopy
//            // Call cell automaton method
//            CellAutomaton().cellAutomaton(gridView: firstGridView)
//        }
//        currentGeneration += 1
//    }
    /// This method repopulates the current grid instead of using double buffering. It also increases the current generation count by 1.
    private func repopulateGridView() {
        guard let currentGridView = currentGridView else {return}
        CellAutomaton().cellAutomaton(gridView: currentGridView)
        currentGeneration += 1
    }
    private func updateGenerationNumberLabel() {
        generationNumberLabel.text = "Current Generation: \(currentGeneration)"
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
