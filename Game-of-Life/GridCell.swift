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


