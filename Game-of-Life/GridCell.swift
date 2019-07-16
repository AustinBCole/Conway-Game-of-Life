//
//  GridCell.swift
//  Game-of-Life
//
//  Created by Austin Cole on 7/15/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

class GridCell: UIView {
    
    // MARK: Private Properties
    private var currentState = 0 {
        willSet {
            if newValue == 0 {
                self.backgroundColor = .white
            }
            else {
                self.backgroundColor = .black
            }
        }
    }
    private let index: IndexTuple
    
    init(frame: CGRect, index: (Int, Int)) {
        self.index = IndexTuple(x: index.0, y: index.1)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    // MARK: Public Methods
    public func toggleState() {
        if currentState == 0 {
            currentState = 1
        }
        else {
            currentState = 0
        }
    }

    public func toggleInteraction() {
        if self.isUserInteractionEnabled == true {
            self.isUserInteractionEnabled = false
        }
        else {
            self.isUserInteractionEnabled = true
        }
    }
    
    public func getIndex() -> IndexTuple {
        return index
    }
    
    public func getState() -> Int {
        return currentState
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
