//
//  SampleCellView.swift
//  Game-of-Life
//
//  Created by Austin Cole on 7/17/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

class SampleCellConfigurationView: UIView {
    
    private var cellArray: [GridCell] = []

    override func draw(_ rect: CGRect) {
        // Double for loop. I each row and then each column
        for y in 0...Int(self.frame.height / 10) - 1 {
            for x in 0...Int(self.frame.width / 10) - 1 {
                //Multiply x by 10 and y by 10
                let cell = GridCell(frame: CGRect(x: x * 10, y: y * 10, width: 10, height: 10), index: (x, y))
                cellArray.append(cell)
                cell.layer.borderColor = UIColor.gray.cgColor
                cell.layer.borderWidth = 0.5
                cell.isUserInteractionEnabled = false
                self.addSubview(cell)
            }
            
        }
    }
    
    public func getCell(index: Int) -> GridCell {
        return cellArray[index]
    }
}
