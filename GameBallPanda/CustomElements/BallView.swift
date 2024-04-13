//
//  BallView.swift
//  GameBallPanda
//
//  Created by Александр Молчан on 13.04.24.
//

import UIKit
import SnapKit

final class BallView: UIView {
    private(set) var ballColor: GameColors
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    init(color: GameColors) {
        self.ballColor = color
        super.init(frame: .zero)
        configurateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurateUI() {
        layoutElements()
        makeConstraints()
    }
    
    private func layoutElements() {
        addSubview(imageView)
        setColor(color: ballColor)
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(70)
        }
    }
    
    func setColor(color: GameColors) {
        ballColor = color
        imageView.image = switch ballColor {
            case .red: .redBall
            case .yellow: .yellowBall
            case .blue: .blueBall
            case .green: .greenBall
        }
    }
    
}
