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
    private let index: (Int, Int)
    
    init(frame: CGRect, index: (Int, Int)) {
        self.index = index
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    public func changeState() {
        if currentState == 0 {
            self.backgroundColor = .black
        }
        else {
            self.backgroundColor = .white
        }
    }
    
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
    
}
