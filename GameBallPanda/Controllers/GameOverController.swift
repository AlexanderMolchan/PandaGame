//
//  GameOverController.swift
//  GameBallPanda
//
//  Created by Александр Молчан on 14.04.24.
//

import UIKit
import SnapKit

final class GameOverController: UIViewController {
    
    private var score: Int
    var backToMenuClosure: (() -> ())?
    var startAgainClosure: (() -> ())?
    
    private lazy var backgroundShadow = {
        let imageView = UIImageView()
        imageView.image = .shadow
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var menuBanner = {
        let imageView = UIImageView()
        imageView.image = .youWin
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var menuRect = {
        let imageView = UIImageView()
        imageView.image = .menuRect
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var scoreLabel = {
        let label = UILabel()
        label.text = "SCORE"
        label.textColor = .white
        label.font = .systemFont(ofSize: 27, weight: .heavy)
        return label
    }()
    
    private lazy var bestScoreLabel = {
        let label = UILabel()
        label.text = "BEST"
        label.textColor = .white
        label.font = .systemFont(ofSize: 27, weight: .heavy)
        return label
    }()
    
    private lazy var scoreCounter = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.text = "\(self.score)"
        label.font = .systemFont(ofSize: 27, weight: .heavy)
        return label
    }()
    
    private lazy var bestScoreCounter = {
        let label = UILabel()
        label.text = "\(DefaultsManager.bestScore)"
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 27, weight: .heavy)
        return label
    }()
    
    private lazy var startAgainButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(resource: .startAgain), for: .normal)
        button.setImage(UIImage(resource: .startAgain), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var backToMenuButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(resource: .backToMenu), for: .normal)
        button.setImage(UIImage(resource: .backToMenu), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    // MARK: -
    // MARK: - Lifecycle:
    
    init(score: Int) {
        self.score = score
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerConfigurate()
    }
    
    // MARK: -
    // MARK: - Configuration:
    
    private func controllerConfigurate() {
        layoutElements()
        makeConstraints()
        addTargets()
        addScaleAnimationsTo(button: backToMenuButton)
        addScaleAnimationsTo(button: startAgainButton)
    }
    
    private func layoutElements() {
        view.addSubview(backgroundShadow)
        view.addSubview(menuRect)
        view.addSubview(menuBanner)
        menuRect.addSubview(scoreLabel)
        menuRect.addSubview(bestScoreLabel)
        menuRect.addSubview(scoreCounter)
        menuRect.addSubview(bestScoreCounter)
        view.addSubview(startAgainButton)
        view.addSubview(backToMenuButton)
    }
    
    private func makeConstraints() {
        backgroundShadow.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(150)
        }
        
        menuRect.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview().inset(70)
            make.height.equalTo(160)
        }
        
        menuBanner.snp.makeConstraints { make in
            make.bottom.equalTo(menuRect.snp.top).inset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(270)
            make.width.equalTo(300)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview().offset(-15)
        }
        
        bestScoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview().offset(15)
        }
        
        scoreCounter.snp.makeConstraints { make in
            make.centerY.equalTo(scoreLabel)
            make.leading.equalTo(scoreLabel.snp.trailing).offset(5)
        }
        
        bestScoreCounter.snp.makeConstraints { make in
            make.centerY.equalTo(bestScoreLabel)
            make.leading.equalTo(bestScoreLabel.snp.trailing).offset(5)
        }
        
        startAgainButton.snp.makeConstraints { make in
            make.top.equalTo(menuRect.snp.bottom).offset(20)
            make.trailing.equalTo(menuRect.snp.centerX).inset(20)
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
        
        backToMenuButton.snp.makeConstraints { make in
            make.top.equalTo(menuRect.snp.bottom).offset(20)
            make.leading.equalTo(menuRect.snp.centerX).inset(-20)
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
    }
    
    private func addScaleAnimationsTo(button: UIButton) {
        button.addTarget(self, action: #selector(buttonTapped(sender: )), for: .touchDown)
        button.addTarget(self, action: #selector(buttonScale(sender: )), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonScale(sender: )), for: .touchDragOutside)
    }
    
    @objc private func buttonScale(sender: UIButton) {
        sender.transform = CGAffineTransformMakeScale(1, 1)
        }
    
    @objc private func buttonTapped(sender: UIButton) {
        sender.transform = CGAffineTransformMakeScale(0.9, 0.9)
    }
    
    // MARK: -
    // MARK: - Logic:
        
    private func addTargets() {
        backToMenuButton.addTarget(self, action: #selector(backToMenuAction), for: .touchUpInside)
        startAgainButton.addTarget(self, action: #selector(startAgainAction), for: .touchUpInside)
    }
    
    @objc private func backToMenuAction() {
        dismiss(animated: false)
        backToMenuClosure?()
    }
    
    @objc private func startAgainAction() {
        dismiss(animated: false)
        startAgainClosure?()
    }
    
}
