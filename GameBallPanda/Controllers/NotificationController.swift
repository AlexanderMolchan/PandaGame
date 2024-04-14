//
//  NotificationController.swift
//  GameBallPanda
//
//  Created by Александр Молчан on 14.04.24.
//

import UIKit
import SnapKit

final class NotificationViewController: UIViewController {
    
    private lazy var notificationLabel = {
        let label = UILabel()
        label.text = "Allow notifications about bonuses and promos"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 27, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var commentLabel = {
        let label = UILabel()
        label.text = "Stay tuned with best offers from our casino"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()

    private lazy var confirmButton = {
        let button = UIButton(type: .system)
        button.setTitle("Yes, I Want Bonuses!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.tintColor = .black
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var skipButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.tintColor = .lightGray
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    var controllerClosedClosure: (() -> ())?
    
    override func viewDidLoad() {
        addGradient()
        layoutElements()
        makeConstraints()
    }
    
    deinit {
        controllerClosedClosure?()
    }
    
    private func addGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.6)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func layoutElements() {
        view.addSubview(notificationLabel)
        view.addSubview(commentLabel)
        view.addSubview(confirmButton)
        view.addSubview(skipButton)
    }
    
    private func makeConstraints() {
        notificationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        commentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(notificationLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(45)
        }
        
        skipButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(skipButton.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
    }
    
}
