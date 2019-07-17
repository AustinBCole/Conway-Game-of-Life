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
    private var visited: [GridCell: Bool] = [:]
    
    
    //MARK: Public Methods
    public func cellAutomaton(gridView: GridView) {
        let gridCellArray = gridView.getGridCells()
        for cell in gridCellArray {
            cell.setPreviousState(value: cell.getCurrentState())
            if cellShouldChangeState(cell: cell, gridView: gridView) {
                cell.toggleState()
                visited[cell] = true
                print(cell.getCurrentState())
            }
        }
    }
    public func refreshCellAutomaton(gridView: GridView) {
        // Get cells from gridView
        let gridCellArray = gridView.getGridCells()
        // Loop through each cell
        for cell in gridCellArray {
            // If cell state is 1, toggle it
            if cell.getCurrentState() == 1 {
                cell.toggleState()
                // And set prvious state to 0 as well
                cell.setPreviousState(value: 0)
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
        if visited.contains(where: { (key, value) -> Bool in
            cell == key
        }) {
            return cell.getPreviousState()
        }
        return cell.getCurrentState()
    }
    private func cellShouldChangeState(cell: GridCell, gridView: GridView) -> Bool {
        // Get state of all neighbors
        let neighborsState = getStateOfNeighbors(cell: cell, gridView: gridView)
        // If the cell is currently dead
        if cell.getCurrentState() == 0 {
            // And if neighbor state array has exactly 3 elements
            if neighborsState.count == 3 {
                // Return true
                return true
            }
            // Else return false
            return false
        }
        // Else if cell is alive
        else if cell.getCurrentState() == 1 {
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
