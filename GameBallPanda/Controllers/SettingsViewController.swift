//
//  SettingsViewController.swift
//  GameBallPanda
//
//  Created by Александр Молчан on 14.04.24.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    // MARK: -
    // MARK: - UI Elements:
    
    private lazy var backgroundShadow = {
        let imageView = UIImageView()
        imageView.image = .shadow
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var settingsLogo = {
        let imageView = UIImageView()
        imageView.image = .settingsLogo
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var settingsFrame = {
        let imageView = UIImageView()
        imageView.image = .settingsFrame
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var settingsBanner = {
        let imageView = UIImageView()
        imageView.image = .settingsBanner
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var soundBanner = {
        let imageView = UIImageView()
        imageView.image = .bannerForSettings
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var soundLabel = {
        let label = UILabel()
        label.text = "Sounds"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    private lazy var hapticBanner = {
        let imageView = UIImageView()
        imageView.image = .bannerForSettings
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var hapticLabel = {
        let label = UILabel()
        label.text = "Vibrations"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    private lazy var soundSwitch = {
        let switcher = UIButton(type: .custom)
        switcher.setImage(.switchOn, for: .selected)
        switcher.setImage(.switchOff, for: .normal)
        switcher.imageView?.contentMode = .scaleAspectFit
        switcher.isSelected = DefaultsManager.isSoundEnabled
        return switcher
    }()
    
    private lazy var hapticSwitch = {
        let switcher = UIButton(type: .custom)
        switcher.setImage(.switchOn, for: .selected)
        switcher.setImage(.switchOff, for: .normal)
        switcher.imageView?.contentMode = .scaleAspectFit
        switcher.isSelected = DefaultsManager.isHapticEnabled
        return switcher
    }()
    
    private lazy var backToMenuButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(resource: .backToMenu), for: .normal)
        button.setImage(UIImage(resource: .backToMenu), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var topTapArea = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var bottomTapArea = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: -
    // MARK: - Closures:
    
    var backToMenuClosure: (() -> ())?
    var resumeGameClosure: (() -> ())?
    
    // MARK: -
    // MARK: - Lifecycle:

    override func viewDidLoad() {
        super.viewDidLoad()
        controllerConfigurate()
    }
    
    // MARK: -
    // MARK: - Configuration:
    
    private func controllerConfigurate() {
        layoutElements()
        makeConstraints()
        addGesture()
        addScaleAnimationsTo(button: backToMenuButton)
        addTargets()
        self.view.backgroundColor = .clear
    }
    
    
    
    private func layoutElements() {
        view.addSubview(backgroundShadow)
        view.addSubview(settingsLogo)
        view.addSubview(settingsFrame)
        view.addSubview(settingsBanner)
        view.addSubview(soundBanner)
        view.addSubview(hapticBanner)
        view.addSubview(backToMenuButton)
        view.addSubview(topTapArea)
        view.addSubview(bottomTapArea)
        
        soundBanner.addSubview(soundLabel)
        view.addSubview(soundSwitch)
        hapticBanner.addSubview(hapticLabel)
        view.addSubview(hapticSwitch)
    }
    
    private func makeConstraints() {
        backgroundShadow.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(150)
        }
        
        settingsLogo.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-70)
            make.leading.trailing.equalToSuperview().inset(-60)
            make.height.equalTo(230)
        }
        
        settingsFrame.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview().inset(70)
            make.height.equalTo(160)
        }
        
        settingsBanner.snp.makeConstraints { make in
            make.top.equalTo(settingsFrame.snp.top).inset(10)
            make.leading.trailing.equalTo(settingsFrame).inset(35)
            make.height.equalTo(50)
        }
        
        soundBanner.snp.makeConstraints { make in
            make.leading.trailing.equalTo(settingsFrame).inset(35)
            make.top.equalTo(settingsLogo.snp.bottom)
            make.height.equalTo(30)
        }
        
        hapticBanner.snp.makeConstraints { make in
            make.leading.trailing.equalTo(settingsFrame).inset(35)
            make.bottom.equalTo(settingsFrame.snp.bottom).inset(20)
            make.height.equalTo(30)
        }
        
        soundLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        hapticLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        soundSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(soundBanner)
            make.trailing.equalTo(soundBanner).inset(15)
            make.height.equalTo(15)
            make.width.equalTo(40)
        }
        
        hapticSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(hapticBanner)
            make.trailing.equalTo(hapticBanner).inset(15)
            make.height.equalTo(15)
            make.width.equalTo(40)
        }
        
        backToMenuButton.snp.makeConstraints { make in
            make.top.equalTo(settingsFrame.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
        
        topTapArea.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(settingsFrame.snp.top)
        }
        
        bottomTapArea.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(backToMenuButton.snp.bottom).offset(20)
        }
    }
    
    // MARK: -
    // MARK: - Logic:
    
    private func addGesture() {
        let topGesture = UITapGestureRecognizer(target: self, action: #selector(closeController))
        let botGesture = UITapGestureRecognizer(target: self, action: #selector(closeController))
        topTapArea.addGestureRecognizer(topGesture)
        bottomTapArea.addGestureRecognizer(botGesture)
    }
    
    @objc private func closeController() {
        dismiss(animated: false)
        resumeGameClosure?()
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
    
    private func addTargets() {
        backToMenuButton.addTarget(self, action: #selector(backToMainMenu), for: .touchUpInside)
        soundSwitch.addTarget(self, action: #selector(soundToggle), for: .touchUpInside)
        hapticSwitch.addTarget(self, action: #selector(hapticToggle), for: .touchUpInside)
    }
    
    @objc private func backToMainMenu() {
        closeController()
        backToMenuClosure?()
    }
    
    @objc private func soundToggle(sender: UIButton) {
        sender.isSelected.toggle()
        DefaultsManager.isSoundEnabled = sender.isSelected
    }
    
    @objc private func hapticToggle(sender: UIButton) {
        sender.isSelected.toggle()
        DefaultsManager.isHapticEnabled = sender.isSelected
    }
    
}
