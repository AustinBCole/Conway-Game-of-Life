//
//  GridCellGraph.swift
//  Game-of-Life
//
//  Created by Austin Cole on 7/15/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import Foundation

class GridCellGraph {
    // MARK: Private Properties
    private var gridCellAdjacencyList: [IndexTuple: [IndexTuple]] = [:]
    private var gridCellDictionary: [IndexTuple: GridCell] = [:]
    private var gridCellArray: [GridCell] = []
    // MARK: Private Methods
    private func getAdjacentIndexTuples(index:
        IndexTuple) -> [IndexTuple] {
        // Get all the neighbors
        let topLeftIndexTuple = IndexTuple(x: index.x - 1, y: index.y - 1)
        let topIndexTuple = IndexTuple(x: index.x, y: index.y - 1)
        let topRightIndexTuple = IndexTuple(x: index.x + 1, y: index.y - 1)
        let rightIndexTuple = IndexTuple(x: index.x + 1, y: index.y)
        let bottomRightIndexTuple = IndexTuple(x: index.x + 1, y: index.y + 1)
        let bottomIndexTuple = IndexTuple(x: index.x, y: index.y + 1)
        let bottomLeftIndexTuple = IndexTuple(x: index.x - 1, y: index.y + 1)
        let leftIndexTuple = IndexTuple(x: index.x - 1, y: index.y)
        // Add all neighbors to the array
        var indexTupleArray = [topLeftIndexTuple, topIndexTuple, topRightIndexTuple, rightIndexTuple, bottomRightIndexTuple, bottomIndexTuple, bottomLeftIndexTuple, leftIndexTuple]
        // Go through the array and remove all neighbors that don't actually exist, or all neighbors with a negative x or y
        for tupleIndex in 0...indexTupleArray.count {
            if indexTupleArray[tupleIndex].x < 0 || indexTupleArray[tupleIndex].y < 0 {
                indexTupleArray.remove(at: tupleIndex)
            }
        }
        // Return the array
        return indexTupleArray
    }
    // MARK: Public Methods
    public func addCellToGraph(cell: GridCell) {
        // Get cell index
        let index = cell.getIndex()
        // Cell index is key, all adjacent indexes are value
        gridCellAdjacencyList[index] = getAdjacentIndexTuples(index: index)
        // Store the index into the other dictionary as key, the cell as value
        gridCellDictionary[index] = cell
        // Append cell to gridCellArray for use in the CellAutomaton file
        gridCellArray.append(cell)
        
    }
    public func getAdjacentIndexTuples(cell: GridCell) -> [GridCell] {
        // Get adjacency list of IndexTuple
        let adjacencyList = getAdjacentIndexTuples(index: cell.getIndex())
        // Create empty array for cells
        var cellAdjacencyList: [GridCell] = []
        // For tuple index in adjacency list
        for index in adjacencyList {
            // Append grid cell to array, get grid cell from grid cell dictionary using tuple index as key
                cellAdjacencyList.append(gridCellDictionary[index]!)
        }
        return cellAdjacencyList
    }
    public func getGridCellArray() -> [GridCell] {
        return gridCellArray
    }
}


// A plan to implement this without needing to have a cell object, just drwaw every time
// Get center index ex. (4, 4)
// Subtract 5 and add 5 to each to get the full cell
// Store center point in adjacency list
// Algo for adjacency list
// Store the x and y values of index tuple into x and y properties
// I am incrementing and decrementing by 11 instead of 1 because I am starting at the center point of the cell. If each cell were only one point it would be 1
// topLeft = (x - 11, y - 11)
// top = (x, y - 11)
// topRight = (x + 11, y - 11)
// right = (x + 11, y)
// bottomRight = (x + 11, y + 11)
// bottom = (x, y + 11)
// bottomLeft = (x - 11, y + 11)
// properties to adjacency list, using key

// Another idea for algo to populate adjacency list
// in GetAdjacentIndexTuples
// Just create 8 IndexTuple instances holding the values of the given IndexTuple instances neighbors
// If any of the IndexTuples contains negative numbers, don't add them to the return array
// Else, add them to the return array
