//
//  ViewController.swift
//  GameBallPanda
//
//  Created by Александр Молчан on 13.04.24.
//

import UIKit
import SnapKit

final class GameViewController: UIViewController {
    
    // MARK: -
    // MARK: - Properties:
    
    private var lastSwipeBeginningPoint: CGPoint?

    private var backgroundField = BackgroundFieldView()
    private var gameField = GameFieldView()
    private var ball = BallView(color: .red)
    
    private var currentBallColor: GameColors = .red
    private var currentBallPosition: BallPosition = .center
    private var currentCornerColor: GameColors = .blue
    
    private var fieldsArray = BackgroundFieldView.getFieldsArray()
    private var ballColorsArray = GameColors.allCases
    
    private var fieldOffset = 50
    
    private lazy var backgroundImage = {
        let imageView = UIImageView()
        imageView.image = .gameBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: -
    // MARK: - Lifecycle:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerConfiguration()
    }
    
    // MARK: -
    // MARK: - Configurations:
    
    private func controllerConfiguration() {
        layoutElements()
        makeConstraints()
        createGesture()
        view.backgroundColor = .magenta
        navigationItem.hidesBackButton = true
    }
    
    private func layoutElements() {
        backgroundField = BackgroundFieldView(image: .gbryField, leftUp: .green, rightUp: .blue, rightDown: .red, leftDown: .yellow)
        
        view.addSubview(backgroundImage)
        view.addSubview(backgroundField)
        view.addSubview(gameField)
        view.addSubview(ball)
        ball.center = CGPoint(x: view.center.x, y: view.center.y + CGFloat(fieldOffset))
    }
    
    private func makeConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(fieldOffset)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        backgroundField.layoutIfNeeded()
        
        let backgroundFieldWidth = backgroundField.frame.width
        let gameFieldWidth = backgroundFieldWidth * 0.4
        
        gameField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(fieldOffset)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(gameFieldWidth)
        }
        gameField.layoutIfNeeded()
        
        createFieldCorners()
    }
    
    private func createGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(ballSwipe(sender: )))
        self.view.addGestureRecognizer(gesture)
    }
    
    private func createFieldCorners() {
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        let gameFieldWidth = gameField.bounds.width
        let gameFieldHeight = gameField.bounds.height
        
        let minX = (screenWidth - gameFieldWidth) / 2
        let maxX = minX + gameFieldWidth
        let minY = ((screenHeight - gameFieldHeight) / 2) + CGFloat(fieldOffset)
        let maxY = minY + gameFieldHeight
                
        gameField.leftUpCorner = CGPoint(x: minX, y: minY)
        gameField.leftDownCorner = CGPoint(x: minX, y: maxY)
        gameField.rightUpCorner = CGPoint(x: maxX, y: minY)
        gameField.rightDownCorner = CGPoint(x: maxX, y: maxY)
    }
    
    // MARK: -
    // MARK: - Action functions:
    
    @objc func ballSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .began {
            lastSwipeBeginningPoint = sender.location(in: sender.view)
        } else if sender.state == .ended {
            guard let beginPoint = lastSwipeBeginningPoint else { return }
            let endPoint = sender.location(in: sender.view)
        
            if beginPoint.x  -  endPoint.x > 50 , lastSwipeBeginningPoint!.y - endPoint.y > 50 {
                print("leftUp")
                switch currentBallPosition {
                    case .rightDown: moveBallTo(position: .leftUp)
                    case .center: moveBallTo(position: .leftUp)
                    default: break
                }
            }
            
            if beginPoint.x  -  endPoint.x < -30 , lastSwipeBeginningPoint!.y - endPoint.y > 50 {
                print("rightUp")
                switch currentBallPosition {
                    case .leftDown: moveBallTo(position: .rightUp)
                    case .center: moveBallTo(position: .rightUp)
                    default: break
                }
            }
            
            if beginPoint.x  -  endPoint.x < -100 , lastSwipeBeginningPoint!.y - endPoint.y < -50 {
                print("rightDown")
                switch currentBallPosition {
                    case .leftUp: moveBallTo(position: .rightDown)
                    case .center: moveBallTo(position: .rightDown)
                    default: break
                }
            }
            
            if beginPoint.x  -  endPoint.x > 100 , lastSwipeBeginningPoint!.y - endPoint.y < -50 {
                print("leftDown")
                switch currentBallPosition {
                    case .rightUp: moveBallTo(position: .leftDown)
                    case .center: moveBallTo(position: .leftDown)
                    default: break
                }
            }
            
            if beginPoint.x  -  endPoint.x < -100 , lastSwipeBeginningPoint!.y - endPoint.y > -50 , lastSwipeBeginningPoint!.y - endPoint.y < 50 {
                print("right")
                switch currentBallPosition {
                    case .leftUp: moveBallTo(position: .rightUp)
                    case .leftDown: moveBallTo(position: .rightDown)
                    default: break
                }
            }
            
            if beginPoint.x  -  endPoint.x > 80 , lastSwipeBeginningPoint!.y - endPoint.y > -50 , lastSwipeBeginningPoint!.y - endPoint.y < 50 {
                print("left")
                switch currentBallPosition {
                    case .rightUp: moveBallTo(position: .leftUp)
                    case .rightDown: moveBallTo(position: .leftDown)
                    default: break
                }
            }
            
            if beginPoint.y  -  endPoint.y > 100 , lastSwipeBeginningPoint!.x - endPoint.x > -50 , lastSwipeBeginningPoint!.x - endPoint.x < 50 {
                print("up")
                switch currentBallPosition {
                    case .leftDown: moveBallTo(position: .leftUp)
                    case .rightDown: moveBallTo(position: .rightUp)
                    default: break
                }
            }
            
            if beginPoint.y  -  endPoint.y < -50 , lastSwipeBeginningPoint!.x - endPoint.x > -50 , lastSwipeBeginningPoint!.x - endPoint.x < 50 {
                print("down")
                switch currentBallPosition {
                    case .leftUp: moveBallTo(position: .leftDown)
                    case .rightUp: moveBallTo(position: .rightDown)
                    default: break
                }
            }
        }
    }
    
    private func moveBallTo(position: BallPosition) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self else { return }
            switch position {
                case .leftUp:
                    self.ball.center = self.gameField.leftUpCorner
                    self.currentCornerColor = backgroundField.leftUpCorner
                case .leftDown:
                    self.ball.center = self.gameField.leftDownCorner
                    self.currentCornerColor = backgroundField.leftDownCorner
                case .rightUp:
                    self.ball.center = self.gameField.rightUpCorner
                    self.currentCornerColor = backgroundField.rightUpCorner
                case .rightDown:
                    self.ball.center = self.gameField.rightDownCorner
                    self.currentCornerColor = backgroundField.rightDownCorner
                case .center:
                    self.ball.center = CGPoint(x: self.view.center.x, y: self.view.center.y + CGFloat(self.fieldOffset))
            }
            self.view.layoutIfNeeded()
        } completion: { isFinish in
            guard isFinish else { return }
            self.currentBallPosition = position
            self.backgroundField.ballPosition = position
            self.backgroundField.setActiveColor()
            
            if self.currentBallColor == self.currentCornerColor {
                let randomField = self.fieldsArray.shuffled().first(where: { $0.leftUpCorner != self.backgroundField.leftUpCorner })
                self.backgroundField.removeFromSuperview()
                self.backgroundField = randomField ?? BackgroundFieldView(image: .blueBall, leftUp: .red, rightUp: .red, rightDown: .red, leftDown: .red)
                self.backgroundField.ballPosition = position
                self.backgroundField.setActiveColor()
                self.view.addSubview(self.backgroundField)
                self.view.bringSubviewToFront(self.ball)
                self.backgroundField.snp.makeConstraints { make in
                    make.centerY.equalToSuperview().offset(self.fieldOffset)
                    make.centerX.equalToSuperview()
                    make.leading.trailing.equalToSuperview().inset(10)
                }
                self.currentCornerColor = self.backgroundField.activeCornerColor ?? .blue
            } else {
                print("ERRORERRORERRORGAMEOVERBUDDY")
            }
            
            guard let randomColor = self.ballColorsArray.shuffled().first(where: { $0 != self.currentCornerColor }) else { return }
            self.ball.setColor(color: randomColor)
            self.currentBallColor = randomColor
        }
    }
    
}
                                            
