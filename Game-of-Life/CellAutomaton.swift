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
    private var isRunning = false
    
    
    //MARK: Public Methods
    public func cellAutomaton(gridView: GridView) {
        let gridCellArray = gridView.getGridCells()
        for cell in gridCellArray {
            if cellShouldChangeState(cell: cell, gridView: gridView) {
                cell.toggleState()
                print(cell.getState())
            }
        }
    }
    //MARK: Private Methods
    private func getStateOfNeighbors(cell: GridCell, gridView: GridView) -> [Int] {
        // Get list of cell neighbors
        let adjacencyList = gridView.gridCellGraph.getAdjacentIndexTuples(cell: cell)
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
    private func cellShouldChangeState(cell: GridCell, gridView: GridView) -> Bool {
        // Get state of all neighbors
        let neighborsState = getStateOfNeighbors(cell: cell, gridView: gridView)
        // If the cell is currently dead
        if cell.getState() == 0 {
            // And if neighbor state array has exactly 3 elements
            if neighborsState.count == 3 {
                // Return true
                return true
            }
            // Else return false
            return false
        }
        // Else if cell is alive
        else if cell.getState() == 1 {
            // And array has either 2 OR 3 elements
            if neighborsState.count == 2 || neighborsState.count == 3 {
                // Return false
                return false
            }
            // Else return true
            return true
        }
        // Base case is return false
        return false
    }
    
    
}
