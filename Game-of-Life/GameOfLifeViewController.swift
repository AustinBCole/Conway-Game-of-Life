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
    private var count = 0
    private let cellularAutomataOpQ = OperationQueue()
    private var isRunning = false
    private var currentGridView: GridView?
    /// Every time this variable is set, it will run swapGridViews() and populateNextGridView() so long as isRunning is true
    private var currentGeneration: Int = 1 {
        didSet {
            if self.isRunning == true {
                DispatchQueue.main.async {
                    self.swapGridViews()
                }
                cellularAutomataOpQ.addOperation {
                  self.populateNextGridView()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondGridView.isHidden = true
        secondGridView.isUserInteractionEnabled = false
        currentGridView = firstGridView

        // Do any additional setup after loading the view.
    }
    @IBAction func playButtonWasTapped(_ sender: Any) {
        // Create operation queues and operations so that this doesn't junk up the main thread
        self.isRunning = true
        cellularAutomataOpQ.addOperation(populateNextGridView)
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
    /// This method populates the next grid view and updates the current generation count. Every time current generation value is set, this method is called. It is a loop that is only broken when isRunning is equal to false.
    private func populateNextGridView() {
        // If current grid view is first grid view
        if currentGridView == firstGridView {
            // Make pointer to graph of second grid view
            let graphCopy = secondGridView.gridCellGraph
            // Swap second view's graph for first view's graph
            secondGridView.gridCellGraph = firstGridView.gridCellGraph
            // Swap first view's graph for graph copy
            firstGridView.gridCellGraph = graphCopy
            // Call cell automaton method
            CellAutomaton().cellAutomaton(gridView: secondGridView)
        // else, do the opposite
        } else {
            // Make pointer to graph of second grid view
            let graphCopy = firstGridView.gridCellGraph
            // Swap second view's graph for first view's graph
            firstGridView.gridCellGraph = secondGridView.gridCellGraph
            // Swap first view's graph for graph copy
            secondGridView.gridCellGraph = graphCopy
            // Call cell automaton method
            CellAutomaton().cellAutomaton(gridView: firstGridView)
        }
        currentGeneration += 1
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
