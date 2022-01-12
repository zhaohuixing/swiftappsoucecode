//
//  IPuzzle.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/22/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

protocol IPuzzle {
    var puzzleType : enGridType { get }
    var layoutType : enGridLayout { get }
    var edge : Int { get }
    var number : Int { get }
    func Initialize(_ gridLayout : enGridLayout, _ nEdge : Int)
    func MatchCheck()-> Bool
}
