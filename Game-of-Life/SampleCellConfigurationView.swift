//
//  SampleCellView.swift
//  Game-of-Life
//
//  Created by Austin Cole on 7/17/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

class SampleCellConfigurationView: UIView {

    enum sampleCellConfiguration {
        case glider
        case diamond
        case toad
    }
    
    override func draw(_ rect: CGRect) {
        // Double for loop. I each row and then each column
        for y in 0...Int(bounds.maxY / 10) {
            for x in 0...Int(bounds.maxX / 10) {
                // If this is the first cell we are making
                if y == 0 && x == 0 {
                    // Then put in x and y without modification so that we have a cell in the top left corner
                    let cell = GridCell(frame: CGRect(x: x, y: y, width: 10, height: 10), index: (x, y))
                    
                    self.addSubview(cell)
                }
                    // Else if we are still on the first row of cells
                else if y == 0 {
                    // We don't modify y, but we multiply x by 10.
                    let cell = GridCell(frame: CGRect(x: x * 10, y: y, width: 10, height: 10), index: (x, y))
                    
                    self.addSubview(cell)
                    
                }
                    // Else in the case that we are on the first column of cells
                else if x == 0 {
                    // We don't modify x, but we multiply y by 10
                    let cell = GridCell(frame: CGRect(x: x, y: y * 10, width: 10, height: 10), index: (x, y))
                    
                    self.addSubview(cell)
                }
                    // Else
                else {
                    //Multiply x by 10 and y by 10
                    let cell = GridCell(frame: CGRect(x: x * 10, y: y * 10, width: 10, height: 10), index: (x, y))
                    
                    self.addSubview(cell)
                }
            }
        }
    }

}
