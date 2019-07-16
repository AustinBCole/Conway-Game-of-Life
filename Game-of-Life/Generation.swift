//
//  Generation.swift
//  Game-of-Life
//
//  Created by Austin Cole on 7/16/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import Foundation

class GenerationController {
    
    init(generationNumber: Int, firstGridView: GridView, secondGridView: GridView) {
        self.generationNumber = generationNumber
        self.firstGridView = firstGridView
        self.secondGridView = secondGridView
        self.currentGeneration = firstGridView
    }
    
    //MARK: Private Properties
    private let firstGridView: GridView
    private let secondGridView: GridView
    private let currentGeneration: GridView
    private var generationNumber: Int
    
    //MARK: Public Properties
    
    //MARK: Private Methods
    
    
    //MARK: Public Methods
    public func getGenerationNumber() -> Int {
        return generationNumber
    }
    public func advanceGeneration() {
        generationNumber += 1
        // Advance generation algo here
    }
    

    
}

