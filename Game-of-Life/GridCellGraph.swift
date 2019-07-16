//
//  GridCellGraph.swift
//  Game-of-Life
//
//  Created by Austin Cole on 7/15/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import Foundation

class GridCellGraph {
    // MARK: Singleton
    static let shared = GridCellGraph()
    private init() {}
    // MARK: Private Properties
    private var gridCellAdjacencyList: [IndexTuple: [GridCell]] = [:]
    private var gridCellDictionary: [IndexTuple: GridCell] = [:]
    private var gridCellArray: [GridCell] = []
    // MARK: Public Properties
    // MARK: Private Methods
    private func getAdjacentCells(index:
        (Int, Int)) -> [GridCell]? {
        return nil
    }
    // MARK: Public Methods
    public func addCellToGraph(cell: GridCell) {
        // Add gridcell to adjacency list, gridcell index is key and array of adjacent cells is value
        let index = cell.getIndex()
        gridCellAdjacencyList[index] = []
        gridCellArray.append(cell)
        
    }
    public func populateAdjacencyList() {
        for cell in gridCellArray {
            
        }
    }
    
}
