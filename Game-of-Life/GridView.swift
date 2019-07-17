//
//  UIView.swift
//  Game-of-Life
//
//  Created by Austin Cole on 7/15/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    //MARK: Private Properties
    public var gridCellGraph = GridCellGraph()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Double for loop. I each row and then each column
        for y in 0...Int(self.frame.height / 10) - 1 {
            for x in 0...Int(self.frame.width / 10) - 1 {
                //Multiply x by 10 and y by 10
                let cell = GridCell(frame: CGRect(x: x * 10, y: y * 10, width: 10, height: 10), index: (x, y))
    
                
                self.addSubview(cell)
                gridCellGraph.addCellToGraph(cell: cell)
            }
        }
    }
    //MARK: Public Methods
    public func getGridCells() -> [GridCell] {
        return gridCellGraph.getGridCellArray()
    }
    
}
