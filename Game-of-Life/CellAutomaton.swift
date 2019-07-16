//
//  CellAutomaton.swift
//  Game-of-Life
//
//  Created by Austin Cole on 7/16/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import Foundation

class CellAutomaton {
    
    let gridCellGraph = GridCellGraph.shared
    
    func getStateOfNeighbors(cell: GridCell) {
        let adjacencyList = gridCellGraph.getAdjacentIndexTuples(cell: cell)
    }
}
