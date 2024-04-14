//
//  LoadingViewController.swift
//  GameBallPanda
//
//  Created by Александр Молчан on 14.04.24.
//

import UIKit
import SnapKit
import SafariServices

final class MenuViewController: UIViewController {
    
    private lazy var backgroundImage = {
        let imageView = UIImageView()
        imageView.image = .backgroundLoadMenu
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var loadingElement = {
        let imageView = UIImageView()
        imageView.image = .loadingElement
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var loadingBanner = {
        let imageView = UIImageView()
        imageView.image = .loadingBanner
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var bounceAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.y"
        animation.values = [0, -50, 0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 1
        animation.isAdditive = true
        return animation
    }()
    
    private lazy var pandaImage = {
        let imageView = UIImageView()
        imageView.image = .pandaLogo
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var playNowButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(resource: .playNowButton), for: .normal)
        button.setImage(UIImage(resource: .playNowButton), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var privacyButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(resource: .privacyButton), for: .normal)
        button.setImage(UIImage(resource: .privacyButton), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private var timer = Timer()
    private var loadingTime = 3
    private var notificationTime = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurate()
        addTimers()
        addActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotificationControllerTimer()
    }
    
    private func configurate() {
        layoutElements()
        makeConstraints()
        addScaleAnimationsTo(button: playNowButton)
        addScaleAnimationsTo(button: privacyButton)
    }
    
    private func layoutElements() {
        view.addSubview(backgroundImage)
        view.addSubview(loadingElement)
        view.addSubview(loadingBanner)
    }
    
    private func makeConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingElement.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(120)
        }
        
        loadingBanner.snp.makeConstraints { make in
            make.top.equalTo(loadingElement.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
    }
    
    private func layoutMenuElements() {
        view.addSubview(pandaImage)
        view.addSubview(playNowButton)
        view.addSubview(privacyButton)
        pandaImage.alpha = 0
        playNowButton.alpha = 0
        privacyButton.alpha = 0
        
    }
    
    private func makeMenuConstraints() {
        pandaImage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(350)
            make.centerY.equalToSuperview().offset(-100)
        }
        
        playNowButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pandaImage.snp.bottom).offset(15)
            make.width.equalTo(240)
            make.height.equalTo(60)
        }
        
        privacyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(playNowButton.snp.bottom).offset(10)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
    }
    
    private func addTimers() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAnimation), userInfo: nil, repeats: true)
    }
    
    private func addNotificationControllerTimer() {
        notificationTime = 5
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(notificationControllerPresent), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAnimation() {
        loadingTime -= 1
        loadingElement.layer.add(bounceAnimation, forKey: nil)
        if loadingTime == 0 {
            timer.invalidate()
            transitionToMenu()
        }
    }
    
    @objc private func notificationControllerPresent() {
        notificationTime -= 1
        if notificationTime == 0 {
            timer.invalidate()
            let notificationController = NotificationViewController()
            notificationController.controllerClosedClosure = {
                UIView.animate(withDuration: 0.4) { [weak self] in
                    guard let self else { return }
                    self.playNowButton.alpha = 1
                    self.privacyButton.alpha = 1
                }
            }
            notificationController.modalPresentationStyle = .pageSheet
            guard let sheet = notificationController.sheetPresentationController else { return }
            let viewHeight = Double(view.frame.size.height)
            let multiplier = 0.4
            let customDetend = UISheetPresentationController.Detent.custom { context in
                viewHeight * multiplier
            }
            sheet.detents = [customDetend]
            UIView.animate(withDuration: 0.4) { [weak self] in
                guard let self else { return }
                self.playNowButton.alpha = 0
                self.privacyButton.alpha = 0
            } completion: { isFinish in
                guard isFinish else { return }
                self.navigationController?.present(notificationController, animated: true)
            }
        }
    }
    
    private func transitionToMenu() {
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self else { return }
            self.loadingBanner.alpha = 0
            self.loadingElement.alpha = 0
        } completion: { isFinish in
            guard isFinish else { return }
            self.loadingBanner.removeFromSuperview()
            self.loadingElement.removeFromSuperview()
            self.layoutMenuElements()
            self.makeMenuConstraints()
            UIView.animate(withDuration: 0.4) { [weak self] in
                guard let self else { return }
                self.pandaImage.alpha = 1
                self.playNowButton.alpha = 1
                self.privacyButton.alpha = 1
            } completion: { isFinish in
                self.addNotificationControllerTimer()
            }
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
    
    private func addActions() {
        playNowButton.addTarget(self, action: #selector(playNowAction), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(privacyAction), for: .touchUpInside)
    }
    
    @objc private func playNowAction() {
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
    @objc private func privacyAction() {
        if let url = URL(string: "https://en.wikipedia.org/wiki/Quentin_Tarantino") {
            let config = SFSafariViewController.Configuration()
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
}
