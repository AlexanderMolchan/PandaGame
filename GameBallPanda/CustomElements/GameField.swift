//
//  GameField.swift
//  GameBallPanda
//
//  Created by Александр Молчан on 13.04.24.
//

import UIKit
import SnapKit

final class GameFieldView: UIView {
    var leftUpCorner = CGPoint()
    var leftDownCorner = CGPoint()
    var rightUpCorner = CGPoint()
    var rightDownCorner = CGPoint()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
