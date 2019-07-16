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
    
    
    //MARK: Public Methods
    public func cellAutomaton() {
        let gridCellArray = gridCellGraph.getGridCellArray()
        for cell in gridCellArray {
            if cellShouldChangeState(cell: cell) {
                cell.toggleState()
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
    private func cellShouldChangeState(cell: GridCell) -> Bool {
        // Get state of all neighbors
        let neighborsState = getStateOfNeighbors(cell: cell)
        // If the cell is currently dead
        if cell.getState() == 0 {
            // And if neighbor state array has 3 elements
            if neighborsState.count == 3 {
                // Return true
                return true
            }
        }
        // Else if cell is alive
        else if cell.getState() == 1 {
            // And array has either 2 OR 3 elements
            if neighborsState.count == 2 || neighborsState.count == 3 {
                // Return true
                return true
            }
        }
        // Base case is return false
        return false
    }
}
