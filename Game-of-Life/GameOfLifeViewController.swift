//
//  GameOfLifeViewController.swift
//  Game-of-Life
//
//  Created by Austin Cole on 7/16/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

class GameOfLifeViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var generationNumberLabel: UILabel!
    @IBOutlet weak var firstGridView: GridView!
    @IBOutlet weak var gliderCellConfigurationView: SampleCellConfigurationView!
    @IBOutlet weak var diamondCellConfigurationView: SampleCellConfigurationView!
    @IBOutlet weak var toadCellConfigurationView: SampleCellConfigurationView!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var jumpToGenerationTextField: UITextField!
    //    @IBOutlet weak var secondGridView: GridView!
    
    //MARK: Private Properties
    private var count = 0
    private let cellularAutomataOpQ = OperationQueue()
    private var isRunning = false
    private var currentGridView: GridView?
    /// Every time this variable is set, it will run updateGenerationNumberLabel() and repopulate() so long as isRunning is true
    private var currentGeneration: Int = 1 {
        willSet {
            if self.isRunning == true && newValue != 1 {
                DispatchQueue.main.async {
                    self.updateGenerationNumberLabel()
                }
                cellularAutomataOpQ.addOperation {
                    sleep(UInt32(1))
                    self.repopulateGridView()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentGridView = firstGridView
        generationNumberLabel.text = "Current Generation: \(currentGeneration)"
        let gliderGesture = UITapGestureRecognizer(target: self, action: #selector(gliderSampleTapped(_ :)))
        gliderGesture.delegate = self
        
        gliderCellConfigurationView.addGestureRecognizer(gliderGesture)
        
        let diamondGesture = UITapGestureRecognizer(target: self, action: #selector(diamondSampleTapped(_:)))
        diamondGesture.delegate = self
        diamondCellConfigurationView.addGestureRecognizer(diamondGesture)
        
        let toadGesture = UITapGestureRecognizer(target: self, action: #selector(toadSampleTapped(_:)))
        toadGesture.delegate = self
        toadCellConfigurationView.addGestureRecognizer(toadGesture)
        // Do any additional setup after loading the view.
    }
    
    @objc
    func gliderSampleTapped(_ recognizer: UITapGestureRecognizer) {
        let gridCells = currentGridView?.getGridCells()
        let centerCell = gridCells?[getCellIndexByIndexTuple(x: 15, y: 14, size: 300)]
        // next cell index = (5 + 1) *(100 / 10) + (5 + 1)
        let secondCell = gridCells?[getCellIndexByIndexTuple(x: 16, y: 15, size: 300)]
        let thirdCell = gridCells?[getCellIndexByIndexTuple(x: 17, y: 15, size: 300)]
        let fourthCell = gridCells?[getCellIndexByIndexTuple(x: 16, y: 16, size: 300)]
        let fifthCell = gridCells?[getCellIndexByIndexTuple(x: 15, y: 16, size: 300)]
        
        centerCell?.toggleState()
        secondCell?.toggleState()
        thirdCell?.toggleState()
        fourthCell?.toggleState()
        fifthCell?.toggleState()
        
    }
    @objc
    func diamondSampleTapped(_ recognizer: UITapGestureRecognizer) {
        let gridCells = currentGridView?.getGridCells()
        let centerCell = gridCells?[getCellIndexByIndexTuple(x: 15, y: 14, size: 300)]
        // next cell index = (5 + 1) *(100 / 10) + (5 + 1)
        let secondCell = gridCells?[getCellIndexByIndexTuple(x: 14, y: 15, size: 300)]
        let thirdCell = gridCells?[getCellIndexByIndexTuple(x: 16, y: 15, size: 300)]
        let fourthCell = gridCells?[getCellIndexByIndexTuple(x: 15, y: 16, size: 300)]
        
        centerCell?.toggleState()
        secondCell?.toggleState()
        thirdCell?.toggleState()
        fourthCell?.toggleState()
    }
    @objc
    func toadSampleTapped(_ sender: UITapGestureRecognizer) {
        let gridCells = currentGridView?.getGridCells()
        let centerCell = gridCells?[getCellIndexByIndexTuple(x: 15, y: 14, size: 300)]
        // next cell index = (5 + 1) *(100 / 10) + (5 + 1)
        let secondCell = gridCells?[getCellIndexByIndexTuple(x: 14, y: 14, size: 300)]
        let thirdCell = gridCells?[getCellIndexByIndexTuple(x: 13, y: 14, size: 300)]
        let fourthCell = gridCells?[getCellIndexByIndexTuple(x: 14, y: 15, size: 300)]
        let fifthCell = gridCells?[getCellIndexByIndexTuple(x: 13, y: 15, size: 300)]
        let sixthCell = gridCells?[getCellIndexByIndexTuple(x: 12, y: 15, size: 300)]
        
        centerCell?.toggleState()
        secondCell?.toggleState()
        thirdCell?.toggleState()
        fourthCell?.toggleState()
        fifthCell?.toggleState()
        sixthCell?.toggleState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        populateCellConfigurationViews()
        
    }
    @IBAction func playButtonWasTapped(_ sender: Any) {
        // Create operation queues and operations so that this doesn't junk up the main thread
        self.isRunning = true
        cellularAutomataOpQ.addOperation(repopulateGridView)
        currentGridView?.isUserInteractionEnabled = false
        toadCellConfigurationView.isUserInteractionEnabled = false
        diamondCellConfigurationView.isUserInteractionEnabled = false
        gliderCellConfigurationView.isUserInteractionEnabled = false
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
        currentGridView?.isUserInteractionEnabled = true
        toadCellConfigurationView.isUserInteractionEnabled = true
        diamondCellConfigurationView.isUserInteractionEnabled = true
        gliderCellConfigurationView.isUserInteractionEnabled = true
    }
    @IBAction func randomButtonWasTapped(_ sender: Any) {
        if isRunning == false {
            getRandomConfiguration()
        }
    }
    @IBAction func jumpToButtonTapped(_ sender: Any) {
        guard let generationNumberText = jumpToGenerationTextField.text else {
            cannotJumpToAlert()
            return
        }
        let generationNumber = Int(generationNumberText) ?? 0
        if generationNumber == 0 || generationNumber < currentGeneration {
            cannotJumpToAlert()
            return
        }
        currentGridView?.isHidden = true
        generationNumberLabel.isHidden = true
        
        currentGridView?.isUserInteractionEnabled = false
        toadCellConfigurationView.isUserInteractionEnabled = false
        diamondCellConfigurationView.isUserInteractionEnabled = false
        gliderCellConfigurationView.isUserInteractionEnabled = false
        
        for _ in currentGeneration...generationNumber - 1 {
            repopulateGridView()
        }
        currentGridView?.isHidden = false
        generationNumberLabel.isHidden = false
        generationNumberLabel.text = "Current Generation: \(currentGeneration)"
        
    }
    
    
    
    /// This method repopulates the current grid instead of using double buffering. It also increases the current generation count by 1.
    private func repopulateGridView() {
        guard let currentGridView = currentGridView else {return}
        CellAutomaton().cellAutomaton(gridView: currentGridView)
        currentGeneration += 1
    }
    
    private func updateGenerationNumberLabel() {
        generationNumberLabel.text = "Current Generation: \(currentGeneration)"
    }
    private func populateCellConfigurationViews() {
        populateGliderConfigurationView()
        populateDiamondConfigurationView()
        populateToadConfigurationView()
    }
    private func populateGliderConfigurationView() {
        // Equation for getting right index, exept for any of the indexes on the first row
        // (y * (view.width / 10)) + x
        // center index = (4 + 1) *(100 / 10) + (4 + 1))
        let centerCell = gliderCellConfigurationView.getCell(index: 55)
        // next cell index = (5 + 1) *(100 / 10) + (5 + 1)
        let secondCell = gliderCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 5, y: 5, size: 100))
        let thirdCell = gliderCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 6, y: 5, size: 100))
        let fourthCell = gliderCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 5, y: 6, size: 100))
        let fifthCell = gliderCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 4, y: 6, size: 100))
        
        centerCell.toggleState()
        secondCell.toggleState()
        thirdCell.toggleState()
        fourthCell.toggleState()
        fifthCell.toggleState()
        
        
    }
    private func populateDiamondConfigurationView() {
        // Equation for getting right index, exept for any of the indexes on the first row
        // (y * (view.width / 10)) + x
        // center index = (4 + 1) *(100 / 10) + (4 + 1))
        let centerCell = diamondCellConfigurationView.getCell(index: 55)
        // next cell index = (5 + 1) *(100 / 10) + (5 + 1)
        let secondCell = diamondCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 3, y: 5, size: 100))
        let thirdCell = diamondCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 4, y: 6, size: 100))
        let fourthCell = diamondCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 5, y: 5, size: 100))
        
        centerCell.toggleState()
        secondCell.toggleState()
        thirdCell.toggleState()
        fourthCell.toggleState()
        
    }
    private func populateToadConfigurationView() {
        // Equation for getting right index, exept for any of the indexes on the first row
        // (y * (view.width / 10)) + x
        // center index = (4 + 1) *(100 / 10) + (4 + 1))
        let centerCell = toadCellConfigurationView.getCell(index: 55)
        // next cell index = (5 + 1) *(100 / 10) + (5 + 1)
        let secondCell = toadCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 3, y: 4, size: 100))
        let thirdCell = toadCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 2, y: 4, size: 100))
        let fourthCell = toadCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 3, y: 5, size: 100))
        let fifthCell = toadCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 2, y: 5, size: 100))
        let sixthCell = toadCellConfigurationView.getCell(index: getCellIndexByIndexTuple(x: 1, y: 5, size: 100))
        
        centerCell.toggleState()
        secondCell.toggleState()
        thirdCell.toggleState()
        fourthCell.toggleState()
        fifthCell.toggleState()
        sixthCell.toggleState()
        
    }
    private func getCellIndexByIndexTuple(x: Int, y: Int, size: Int) -> Int {
        return (y + 1) * (size / 10) + (x + 1)
    }
    private func getRandomConfiguration() {
        let gridCells = currentGridView?.getGridCells()
        guard let centerCell = gridCells?[getCellIndexByIndexTuple(x: 15, y: 14, size: 300)] else {return}
        centerCell.toggleState()
        guard let adjacentCells = currentGridView?.gridCellGraph.gridCellAdjacencyList[centerCell.getIndex()] else {return}
        for _ in 0...6 {
            let randomIndex = Int.random(in: 0...adjacentCells.count - 1)
            if gridCells?[getCellIndexByIndexTuple(x: adjacentCells[randomIndex].x, y: adjacentCells[randomIndex].y, size: 300)].getCurrentState() == 0 {
                gridCells?[getCellIndexByIndexTuple(x: adjacentCells[randomIndex].x, y: adjacentCells[randomIndex].y, size: 300)].toggleState()
            }
            
        }
    }
    private func cannotJumpToAlert() {
        let alert = UIAlertController(title: "Can't do that.", message: "Please enter a number that is after the current generation's number, and the simulation will jump to that generation.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
}
