//
//  CellAutomaton.swift
//  Game-of-Life
//
//  Created by Austin Cole on 7/16/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import Foundation

class CellAutomaton {
    
    //MARK: Private Properties
    private let gridCellGraph = GridCellGraph.shared
    private var isRunning = false
    private var grid
    
    
    //MARK: Public Methods
    public func cellAutomaton() {
        let gridCellArray = gridCellGraph.getGridCellArray()
        while self.isRunning == true {
            for cell in gridCellArray {
                
            }
            
        }
    }
    public func toggleCellAutomaton() {
        if self.isRunning == false {
            self.isRunning = true
            cellAutomaton()
        } else {
            self.isRunning = false
        }
    }
    //MARK: Private Methods
    private func getStateOfNeighbors(cell: GridCell) -> [Int] {
        // Get list of cell neighbors
        let adjacencyList = gridCellGraph.getAdjacentIndexTuples(cell: cell)
        // Declare adjacent cells state array property, to store the state of adjacent arrays
        var adjacentCellsStateArray: [Int] = []
        // Check state of all cell neighbors
        for cell in adjacencyList {
            let state = checkStateOfCell(cell: cell)
            if state == 1 {
                adjacentCellsStateArray.append(state)
            }
        }
        return adjacentCellsStateArray
    }
    private func checkStateOfCell(cell: GridCell) -> Int {
        return cell.getState()
    }
}
