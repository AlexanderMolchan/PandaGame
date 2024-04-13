//
//  BackgroundField.swift
//  GameBallPanda
//
//  Created by Александр Молчан on 14.04.24.
//

import UIKit
import SnapKit

final class BackgroundFieldView: UIView {
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let fieldImage: UIImage
    var ballPosition: BallPosition = .center
    var activeCornerColor: GameColors?
    
    let leftUpCorner: GameColors
    let rightUpCorner: GameColors
    let rightDownCorner: GameColors
    let leftDownCorner: GameColors
    
    override init(frame: CGRect) {
        self.fieldImage = .blueBall
        self.leftUpCorner = .blue
        self.rightUpCorner = .blue
        self.rightDownCorner = .blue
        self.leftDownCorner = .blue
        super.init(frame: .zero)
    }
    
    init(image: UIImage, leftUp: GameColors, rightUp: GameColors, rightDown: GameColors, leftDown: GameColors) {
        self.fieldImage = image
        self.leftUpCorner = leftUp
        self.rightUpCorner = rightUp
        self.rightDownCorner = rightDown
        self.leftDownCorner = leftDown
        super.init(frame: .zero)
        configurateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func getFieldsArray() -> [BackgroundFieldView] {
        var fieldsArray = [BackgroundFieldView]()
        
        let firstField = BackgroundFieldView(image: .rygbField, leftUp: .red, rightUp: .yellow, rightDown: .green, leftDown: .blue)
        let secondField = BackgroundFieldView(image: .brygField, leftUp: .blue, rightUp: .red, rightDown: .yellow, leftDown: .green)
        let thirdField = BackgroundFieldView(image: .gbryField, leftUp: .green, rightUp: .blue, rightDown: .red, leftDown: .yellow)
        let fourField = BackgroundFieldView(image: .ygbrField, leftUp: .yellow, rightUp: .green, rightDown: .blue, leftDown: .red)
        
        fieldsArray.append(firstField)
        fieldsArray.append(secondField)
        fieldsArray.append(thirdField)
        fieldsArray.append(fourField)
        
        return fieldsArray
    }
    
    private func configurateUI() {
        layoutElements()
        makeConstraints()
    }
    
    private func layoutElements() {
        addSubview(imageView)
        imageView.image = fieldImage
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
    }
    
    func setActiveColor() {
        switch ballPosition {
            case .leftUp: activeCornerColor = leftUpCorner
            case .leftDown: activeCornerColor = leftDownCorner
            case .rightUp: activeCornerColor = rightUpCorner
            case .rightDown: activeCornerColor = rightDownCorner
            case .center: break
        }
    }
    
}
