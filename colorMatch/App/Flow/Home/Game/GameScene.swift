//
//  GameScene.swift


import SnapKit
import SpriteKit
import GameplayKit

enum GameState {
    case back
    case updateScoreBackEnd
    case noCoints
    case gameBack
}

struct bingo{
    var name: String
    var color: UIColor
    var number: Int
}

class GameScene: SKScene {
    
        private var popupActive: Bool = false
        private var coints: Int = 0
        private var dropButton = CustomSKButton(texture: SKTexture(imageNamed: "playBtn"))
        private var greenSprite: SKSpriteNode!
        private let storage = UD.shared
        private var bingoItems: [bingo] = []
        private var bingoItemsAppend: [bingo] = []
        private var createBallTimer: Timer?
        private var timerLabel: SKLabelNode!
        private var remainingTime: Int = 4 // Например, 60 секунд
        private var timerUpdate: Timer?
        private var progressCircle: SKShapeNode!
        private var currentAngle: CGFloat = 0
    
        private var redBall: SKSpriteNode!
        private var orangeBall: SKSpriteNode!
        private var greenBall: SKSpriteNode!
        private var blueBall: SKSpriteNode!
        private var pinkBall: SKSpriteNode!

        private var redFinal: SKSpriteNode!
        private var orangeFinal: SKSpriteNode!
        private var greenFinal: SKSpriteNode!
        private var blueFinal: SKSpriteNode!
        private var pinkFinal: SKSpriteNode!



    public var resultTransfer: ((GameState) -> Void)?
    
    
    override func didMove(to view: SKView) {
        addSettingsScene()
        setupGameSubviews()
        initializeBingoItems() // Инициализация массива при запуске сцены
        createBingoSquares() // Создание квадратов на основании массива
        setupTimerLabel() // Настройка метки таймера
        setupProgressCircle() // Настройка кругового прогресс-бара

        startTimers() // Запуск таймеров
    }

    private func startTimers() {
           createBallTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(createBall), userInfo: nil, repeats: true)
           timerUpdate = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
       }
       
       private func setupTimerLabel() {
           timerLabel = SKLabelNode(text: "\(remainingTime)")
           timerLabel.fontName = "system-Bold"
           timerLabel.fontSize = 24
           timerLabel.fontColor = .white
           timerLabel.position = CGPoint(x: greenSprite.frame.minX + 40, y: greenSprite.frame.midY - 10)
           timerLabel.zPosition = 21
           addChild(timerLabel)
       }
       
    private func setupProgressCircle() {
           let radius: CGFloat = 20
           let circlePath = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: CGFloat(-Double.pi / 2), endAngle: CGFloat(3 * Double.pi / 2), clockwise: true)
           
           progressCircle = SKShapeNode(path: circlePath.cgPath)
           progressCircle.position = CGPoint(x: greenSprite.frame.minX + 40, y: greenSprite.frame.midY)
           progressCircle.strokeColor = .clear
           progressCircle.lineWidth = 0
           progressCircle.fillColor = .clear
           progressCircle.zPosition = 20
           
           addChild(progressCircle)
       }

       @objc private func updateTimer() {
           guard !bingoItems.isEmpty else {
               timerUpdate?.invalidate()
               timerUpdate = nil
               print("Нет элементов")
               return
           }
           
           remainingTime -= 1
           timerLabel.text = "\(remainingTime)"
           
           if remainingTime >= 0 {
               let angle = CGFloat(Double.pi / 2 * Double(4 - remainingTime))
               let path = UIBezierPath(arcCenter: CGPoint.zero, radius: 20, startAngle: currentAngle - CGFloat(Double.pi / 2), endAngle: currentAngle - CGFloat(Double.pi / 2) + CGFloat(Double.pi / 2), clockwise: true)
               path.addLine(to: CGPoint.zero)
               path.close()
               
               let sector = SKShapeNode(path: path.cgPath)
               sector.fillColor = .black
               sector.strokeColor = .clear
               sector.position = CGPoint(x: greenSprite.frame.minX + 40, y: greenSprite.frame.midY)
               sector.zPosition = 21
               sector.name = "sector"
               
               addChild(sector)
               
               currentAngle += CGFloat(Double.pi / 2)
           }
           
           if remainingTime <= 0 {
               remainingTime = 4 // Сброс времени на 4 секунды или нужное вам значение
               timerLabel.text = "\(remainingTime)"
               currentAngle = 0 // Сброс угла
               
               // Очистка старых секторов
               self.enumerateChildNodes(withName: "sector") { (node, stop) in
                   node.removeFromParent()
               }
           }
       }
       
       @objc private func createBall() {
           guard !bingoItems.isEmpty else {
               createBallTimer?.invalidate()
               createBallTimer = nil
               print("Нет элементов")
               return
           }
           
           let randomIndex = Int.random(in: 0..<bingoItems.count)
           let item = bingoItems.remove(at: randomIndex)
           bingoItemsAppend.append(item)
           
           let ball = SKShapeNode(circleOfRadius: 20)
           ball.name = "ball"
           ball.fillColor = item.color
           ball.strokeColor = .clear
           ball.position = CGPoint(x: greenSprite.position.x - 50, y: greenSprite.position.y)
           ball.zPosition = 12
           addChild(ball)
           
           let label = SKLabelNode(text: "\(item.number)")
           label.fontName = "system-Bold"
           label.fontSize = 24
           label.fontColor = .black
           label.verticalAlignmentMode = .center
           label.horizontalAlignmentMode = .center
           ball.addChild(label)
           
           moveExistingBalls(ballWidth: ball.frame.width)
           
           print("bingoItemsAppend содержит: \(bingoItemsAppend.map { $0.name })")
       }


       private func moveExistingBalls(ballWidth: CGFloat) {
           for child in children {
               if let shapeNode = child as? SKShapeNode, shapeNode.name == "ball" {
                   shapeNode.run(SKAction.moveBy(x: ballWidth, y: 0, duration: 0.3))
               }
           }
       }

    
    private func addSettingsScene() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
    }
    
    private func setupGameSubviews() {
        setupBackground()
        setupNavigation()
    }
    
    private func initializeBingoItems() {
          bingoItems = [
              bingo(name: "Red_58", color: .red, number: 58),
              bingo(name: "Red_27", color: .red, number: 27),
              bingo(name: "Red_56", color: .red, number: 56),
              bingo(name: "Red_84", color: .red, number: 84),
              bingo(name: "Red_45", color: .red, number: 45),
              
              bingo(name: "Orange_34", color: .orange, number: 34),
              bingo(name: "Orange_18", color: .orange, number: 18),
              bingo(name: "Orange_14", color: .orange, number: 14),
              bingo(name: "Orange_66", color: .orange, number: 66),
              bingo(name: "Orange_25", color: .orange, number: 25),

              bingo(name: "Green_46", color: .green, number: 46),
              bingo(name: "Green_84", color: .green, number: 84),
              bingo(name: "Green_8", color: .green, number: 8),
              bingo(name: "Green_10", color: .green, number: 10),
              bingo(name: "Green_77", color: .green, number: 77),

              bingo(name: "Blue_36", color: .blue, number: 36),
              bingo(name: "Blue_25", color: .blue, number: 25),
              bingo(name: "Blue_90", color: .blue, number: 90),
              bingo(name: "Blue_28", color: .blue, number: 28),
              bingo(name: "Blue_18", color: .blue, number: 18),

              bingo(name: "SystemPink_33", color: .systemPink, number: 33),
              bingo(name: "SystemPink_78", color: .systemPink, number: 78),
              bingo(name: "SystemPink_55", color: .systemPink, number: 55),
              bingo(name: "SystemPink_19", color: .systemPink, number: 19),
              bingo(name: "SystemPink_91", color: .systemPink, number: 91)
          ]
      }
    
    private func createBingoSquares() {
        let squareSize = CGSize(width: 60, height: 60)
        let centerX = size.width / 2
        let centerY = size.height / 2 - 90
        
        for (index, item) in bingoItems.enumerated() {
            let col = index / 5
            let row = index % 5
            
            let xOffset = CGFloat(col - 2) * (squareSize.width + 10)
            let yOffset = CGFloat(row - 2) * (squareSize.height + 10)
            
            let square = SKSpriteNode(color: item.color, size: squareSize)
            square.position = CGPoint(x: centerX + xOffset, y: centerY - yOffset)
            square.name = item.name
            
            addChild(square)
            
            let label = SKLabelNode(text: "\(item.number)")
            label.fontName = "system-Bold"
            label.fontSize = 20
            label.fontColor = .black
            label.verticalAlignmentMode = .center
            label.horizontalAlignmentMode = .center
            label.name = "label"
            square.addChild(label)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = self.atPoint(location)
        
        var nodeName: String?
        var parentNode: SKNode?
        
        if let squareName = touchedNode.name, squareName == "label", let parent = touchedNode.parent {
            nodeName = parent.name
            parentNode = parent
        } else if touchedNode is SKSpriteNode {
            nodeName = touchedNode.name
            parentNode = touchedNode
        }

        if let name = nodeName, bingoItemsAppend.contains(where: { $0.name == name }) {
            parentNode?.isHidden = true
            print("Элемент \(name) найден и скрыт")
        } else {
            print("Неправильный элемент")
        }
        
        // Проверка количества элементов с определенными цветами в bingoItemsAppend
        let redItemsCount = bingoItemsAppend.filter { $0.color == .red }.count
        if redItemsCount == 5 {
            moveBall(ball: redBall, to: redFinal.position, finalNode: redFinal, finalImageName: "redFinalOne")
        }

        let orangeItemsCount = bingoItemsAppend.filter { $0.color == .orange }.count
        if orangeItemsCount == 5 {
            moveBall(ball: orangeBall, to: orangeFinal.position, finalNode: orangeFinal, finalImageName: "orangeFinalOne")
        }

        let greenItemsCount = bingoItemsAppend.filter { $0.color == .green }.count
        if greenItemsCount == 5 {
            moveBall(ball: greenBall, to: greenFinal.position, finalNode: greenFinal, finalImageName: "greenFinalOne")
        }

        let blueItemsCount = bingoItemsAppend.filter { $0.color == .blue }.count
        if blueItemsCount == 5 {
            moveBall(ball: blueBall, to: blueFinal.position, finalNode: blueFinal, finalImageName: "blueFinalOne")
        }

        let pinkItemsCount = bingoItemsAppend.filter { $0.color == .systemPink }.count
        if pinkItemsCount == 5 {
            moveBall(ball: pinkBall, to: pinkFinal.position, finalNode: pinkFinal, finalImageName: "pinkFinalOne")
        }
    }

    private func moveBall(ball: SKSpriteNode, to position: CGPoint, finalNode: SKSpriteNode, finalImageName: String) {
        let moveAction = SKAction.moveTo(y: position.y, duration: 1.0)
//        let waitAction = SKAction.wait(forDuration: 2.0)
        let changeTextureAction = SKAction.run {
            finalNode.texture = SKTexture(imageNamed: finalImageName)
        }
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveAction, changeTextureAction, removeAction])
        ball.run(sequence)
    }

    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
//        let touchedNode = self.atPoint(location)
//        
//        var nodeName: String?
//        var parentNode: SKNode?
//        
//        if let squareName = touchedNode.name, squareName == "label", let parent = touchedNode.parent {
//            nodeName = parent.name
//            parentNode = parent
//        } else if touchedNode is SKSpriteNode {
//            nodeName = touchedNode.name
//            parentNode = touchedNode
//        }
//
//        if let name = nodeName, bingoItemsAppend.contains(where: { $0.name == name }) {
//            parentNode?.isHidden = true
//            print("Элемент \(name) найден и скрыт")
//        } else {
//            print("Неправильный элемент")
//        }
//        
//        // Проверка на отсутствие элементов с определенными цветами
//        let hasRedItems = bingoItems.contains(where: { $0.color == .red })
//        if !hasRedItems {
//            moveBall(ball: redBall, to: redFinal.position)
//            redFinal.texture = SKTexture(imageNamed: "redFinalOne")
//        }
//
//        let hasOrangeItems = bingoItems.contains(where: { $0.color == .orange })
//        if !hasOrangeItems {
//            moveBall(ball: orangeBall, to: orangeFinal.position)
//            orangeFinal.texture = SKTexture(imageNamed: "orangeFinalOne")
//        }
//
//        let hasGreenItems = bingoItems.contains(where: { $0.color == .green })
//        if !hasGreenItems {
//            moveBall(ball: greenBall, to: greenFinal.position)
//            greenFinal.texture = SKTexture(imageNamed: "greenFinalOne")
//        }
//
//        let hasBlueItems = bingoItems.contains(where: { $0.color == .blue })
//        if !hasBlueItems {
//            moveBall(ball: blueBall, to: blueFinal.position)
//            blueFinal.texture = SKTexture(imageNamed: "blueFinalOne")
//        }
//
//        let hasPinkItems = bingoItems.contains(where: { $0.color == .systemPink })
//        if !hasPinkItems {
//            moveBall(ball: pinkBall, to: pinkFinal.position)
//            pinkFinal.texture = SKTexture(imageNamed: "pinkFinalOne")
//        }
//    }
//
//
//    
//    private func moveBall(ball: SKSpriteNode, to position: CGPoint) {
//        let moveAction = SKAction.moveTo(y: position.y, duration: 1.0)
//        let removeAction = SKAction.removeFromParent()
//        let sequence = SKAction.sequence([moveAction, removeAction])
//        ball.run(sequence)
//    }

    func updateCoinsBalance() {

    }
    
    private func setupBackground() {
        let hpNode = SKSpriteNode(imageNamed: "bgGame")
        hpNode.anchorPoint = .init(x: 0, y: 0)
        hpNode.size = .init(width: size.width, height: size.height)
        hpNode.position = CGPoint(x: 0, y: 0)
        hpNode.zPosition = -1
        addChild(hpNode)
    }
    
    
    private func setupNavigation() {
        let backBtn = CustomSKButton(texture: SKTexture(imageNamed: "btnBack"))
        backBtn.size = .init(width: 75, height: 44)
        backBtn.anchorPoint = .init(x: 0, y: 1.0)
        backBtn.position = CGPoint(x: 24.autoSize, y: size.height - 58.autoSize)
        backBtn.normal = UIImage(named: "btnBack")
        backBtn.highlighted = UIImage(named: "btnBackTapped")
        backBtn.zPosition = 50
        backBtn.action = { self.backButtonAction() }
        addChild(backBtn)
        
        let titleLabel = SKLabelNode(text: "Game")
        titleLabel.fontName = "system-Bold"
        titleLabel.fontSize = 20
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height - 100.autoSize)
        titleLabel.zPosition = 50
        addChild(titleLabel)
        
        redBall = SKSpriteNode(imageNamed: "ballRed")
        redBall.size = .init(width: 48, height: 48)
        redBall.anchorPoint = .init(x: 0, y: 1.0)
        redBall.position = CGPoint(x: 32, y: size.height / 2 + 150)
        redBall.zPosition = 50
        addChild(redBall)

        orangeBall = SKSpriteNode(imageNamed: "ballOrange")
        orangeBall.size = .init(width: 48, height: 48)
        orangeBall.anchorPoint = .init(x: 0, y: 1.0)
        orangeBall.position = CGPoint(x: 104, y: size.height / 2 + 150)
        orangeBall.zPosition = 50
        addChild(orangeBall)
        
        greenBall = SKSpriteNode(imageNamed: "ballGreen")
        greenBall.size = .init(width: 48, height: 48)
        greenBall.anchorPoint = .init(x: 0, y: 1.0)
        greenBall.position = CGPoint(x: 170, y: size.height / 2 + 150)
        greenBall.zPosition = 50
        addChild(greenBall)
        
        blueBall = SKSpriteNode(imageNamed: "ballBlue")
        blueBall.size = .init(width: 48, height: 48)
        blueBall.anchorPoint = .init(x: 0, y: 1.0)
        blueBall.position = CGPoint(x: 240, y: size.height / 2 + 150)
        blueBall.zPosition = 50
        addChild(blueBall)
        
        pinkBall = SKSpriteNode(imageNamed: "ballPink")
        pinkBall.size = .init(width: 48, height: 48)
        pinkBall.anchorPoint = .init(x: 0, y: 1.0)
        pinkBall.position = CGPoint(x: 312, y: size.height / 2 + 150)
        pinkBall.zPosition = 50
        addChild(pinkBall)
        
        greenSprite = SKSpriteNode(color: .brown, size: CGSize(width: size.width, height: 48.autoSize))
        greenSprite.position = CGPoint(x: size.width / 2, y: size.height - 190)
        greenSprite.zPosition = 10
        addChild(greenSprite)
        
        redFinal = SKSpriteNode(imageNamed: "redFinal")
        redFinal.position = CGPoint(x: 60, y: size.height / 2 - 330)
        redFinal.zPosition = 10
        addChild(redFinal)

        orangeFinal = SKSpriteNode(imageNamed: "orangeFinal")
        orangeFinal.position = CGPoint(x: 130, y: size.height / 2 - 330)
        orangeFinal.zPosition = 10
        addChild(orangeFinal)
        
        greenFinal = SKSpriteNode(imageNamed: "greenFinal")
        greenFinal.position = CGPoint(x: 200, y: size.height / 2 - 330)
        greenFinal.zPosition = 10
        addChild(greenFinal)
        
        blueFinal = SKSpriteNode(imageNamed: "blueFinal")
        blueFinal.position = CGPoint(x: 270, y: size.height / 2 - 330)
        blueFinal.zPosition = 10
        addChild(blueFinal)
        
        pinkFinal = SKSpriteNode(imageNamed: "pinkFinal")
        pinkFinal.position = CGPoint(x: 340, y: size.height / 2 - 330)
        pinkFinal.zPosition = 10
        addChild(pinkFinal)
    }
}
extension GameScene {
    
    
//    private func showGameOverViewScore() {
//        storage.scoreCoints += coints
//        storage.scorePoints += points
//        
//        let gameOverNode = SKSpriteNode(color: .cDarkBlue.withAlphaComponent(0.6), size: self.size)
//        gameOverNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
//        gameOverNode.zPosition = 100
//        gameOverNode.name = "gameOverNode"
//        
//        let square = SKSpriteNode(imageNamed: "scoreContImg")
//        square.size = CGSize(width: 346.autoSize, height: 674.autoSize)
//        square.position = CGPoint(x: 0, y: -80.autoSize)
//        square.zPosition = 101
//        gameOverNode.addChild(square)
//        
//        let titleLabel = SKLabelNode()
//          let titleText = "Well done!".uppercased()
//          let titleAttributes: [NSAttributedString.Key: Any] = [
//              .font: UIFont(name: "Unbounded-Bold", size: 24)!,
//              .foregroundColor: UIColor.cYellow,
//              .kern: 1.2
//          ]
//          let attributedTitle = NSAttributedString(string: titleText, attributes: titleAttributes)
//          titleLabel.attributedText = attributedTitle
//          titleLabel.position = CGPoint(x: 0, y: 280.autoSize)
//          titleLabel.zPosition = 102
//          square.addChild(titleLabel)
//          
//          let subTitleLabel = SKLabelNode()
//          let subTitleText = "Your response is excellent\n            You've earned"
//          let subTitleAttributes: [NSAttributedString.Key: Any] = [
//              .font: UIFont(name: "Unbounded-Regular", size: 12)!,
//              .foregroundColor: UIColor.white,
//              .kern: 1.2
//          ]
//          let attributedSubTitle = NSAttributedString(string: subTitleText, attributes: subTitleAttributes)
//          subTitleLabel.attributedText = attributedSubTitle
//          subTitleLabel.horizontalAlignmentMode = .center
//          subTitleLabel.verticalAlignmentMode = .center
//          subTitleLabel.numberOfLines = 0
//          subTitleLabel.position = CGPoint(x: 0, y: 246.autoSize)
//          subTitleLabel.zPosition = 102
//        square.addChild(subTitleLabel)
//
//        
//        let scoreImg = SKSpriteNode(imageNamed: "scoreImg")
//        scoreImg.size = CGSize(width: 200.autoSize, height: 50.autoSize)
//        scoreImg.position = CGPoint(x: 0, y: 184.autoSize)
//        scoreImg.zPosition = 102
//        square.addChild(scoreImg)
//        
//        let pointsLabel = SKLabelNode()
//            let pointsText = "\(points)"
//            let pointsAttributes: [NSAttributedString.Key: Any] = [
//                .font: UIFont(name: "Unbounded-Bold", size: 20)!,
//                .foregroundColor: UIColor.white,
//                .kern: 5.0
//            ]
//            let attributedPoints = NSAttributedString(string: pointsText, attributes: pointsAttributes)
//            pointsLabel.attributedText = attributedPoints
//            pointsLabel.position = CGPoint(x: 64.autoSize, y: -8.autoSize)
//            pointsLabel.zPosition = 102
//            scoreImg.addChild(pointsLabel)
//            
//            let cointsLabel = SKLabelNode()
//            let cointsText = "\(coints)"
//            let cointsAttributes: [NSAttributedString.Key: Any] = [
//                .font: UIFont(name: "Unbounded-Bold", size: 20)!,
//                .foregroundColor: UIColor.white,
//                .kern: 5.0
//            ]
//            let attributedCoints = NSAttributedString(string: cointsText, attributes: cointsAttributes)
//            cointsLabel.attributedText = attributedCoints
//            cointsLabel.position = CGPoint(x: -30.autoSize, y: -8.autoSize)
//            cointsLabel.zPosition = 102
//            scoreImg.addChild(cointsLabel)
//        
//        let imgYouWin = SKSpriteNode(imageNamed: "scoreCenterImg")
//        imgYouWin.size = CGSize(width: 250.autoSize, height: 250.autoSize)
//        imgYouWin.position = CGPoint(x: -4, y: 24.autoSize)
//        imgYouWin.zPosition = 101
//        square.addChild(imgYouWin)
//                
//        let thanksBtn = CustomSKButton(texture: SKTexture(imageNamed: "thanksBtn"))
//        thanksBtn.size = .init(width: 250.autoSize, height: 84.autoSize)
//        thanksBtn.position =  CGPoint(x: 0, y: -142.autoSize)
//        thanksBtn.zPosition = 40
//        thanksBtn.normal = UIImage(named: "thanksBtn")
//        thanksBtn.action = { self.backHomeAction() }
//        square.addChild(thanksBtn)
//        
//        self.addChild(gameOverNode)
//        self.enumerateChildNodes(withName: "\(playItems)") { (node, _) in
//            node.removeFromParent()
//        }
//    }
    
//    private func showGameOverView() {
//        let gameOverNode = SKSpriteNode(color: .cDarkBlue.withAlphaComponent(0.6), size: self.size)
//        gameOverNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
//        gameOverNode.zPosition = 100
//        gameOverNode.name = "gameOverNode"
//        
//        let square = SKSpriteNode(imageNamed: "scoreContImg")
//        square.size = CGSize(width: 346.autoSize, height: 674.autoSize)
//        square.position = CGPoint(x: 0, y: -80.autoSize)
//        square.zPosition = 101
//        gameOverNode.addChild(square)
//        
//        let titleLabel = SKLabelNode()
//          let titleText = "cheer up!".uppercased()
//          let titleAttributes: [NSAttributedString.Key: Any] = [
//              .font: UIFont(name: "Unbounded-Bold", size: 24)!,
//              .foregroundColor: UIColor.cYellow,
//              .kern: 1.4
//          ]
//          let attributedTitle = NSAttributedString(string: titleText, attributes: titleAttributes)
//          titleLabel.attributedText = attributedTitle
//          titleLabel.position = CGPoint(x: 0, y: 280.autoSize)
//          titleLabel.zPosition = 102
//          square.addChild(titleLabel)
//          
//          let subTitleLabel = SKLabelNode()
//          let subTitleText = "Put in more effort in your\ntraining and aim to break\n            new records!"
//          let subTitleAttributes: [NSAttributedString.Key: Any] = [
//              .font: UIFont(name: "Unbounded-Regular", size: 12)!,
//              .foregroundColor: UIColor.white,
//              .kern: 1.4
//          ]
//          let attributedSubTitle = NSAttributedString(string: subTitleText, attributes: subTitleAttributes)
//          subTitleLabel.attributedText = attributedSubTitle
//          subTitleLabel.horizontalAlignmentMode = .center
//          subTitleLabel.verticalAlignmentMode = .center
//          subTitleLabel.numberOfLines = 0
//          subTitleLabel.position = CGPoint(x: 0, y: 246.autoSize)
//          subTitleLabel.zPosition = 102
//        square.addChild(subTitleLabel)
//    
//        
//        let imgYouLose = SKSpriteNode(imageNamed: "scoreCenterImgLose")
//        imgYouLose.size = CGSize(width: 268.autoSize, height: 300.autoSize)
//        imgYouLose.position = CGPoint(x: -4, y: 52.autoSize)
//        imgYouLose.zPosition = 101
//        square.addChild(imgYouLose)
//                
//        let thanksBtn = CustomSKButton(texture: SKTexture(imageNamed: "thanksBtn"))
//        thanksBtn.size = .init(width: 250.autoSize, height: 84.autoSize)
//        thanksBtn.position =  CGPoint(x: 0, y: -142.autoSize)
//        thanksBtn.zPosition = 40
//        thanksBtn.normal = UIImage(named: "thanksBtn")
//        thanksBtn.action = { self.backHomeAction() }
//        square.addChild(thanksBtn)
//        
//        self.addChild(gameOverNode)
//        self.enumerateChildNodes(withName: "\(playItems)") { (node, _) in
//            node.removeFromParent()
//        }
//    }
    

    @objc private func settingsButtonAction() {
        guard popupActive == false else { return }
        resultTransfer?(.updateScoreBackEnd)
    }
    
    @objc private func backHomeAction() {
        guard popupActive == false else { return }
        resultTransfer?(.gameBack)
    }
    
    @objc private func backButtonAction() {
        guard popupActive == false else { return }
        resultTransfer?(.back)
        createBallTimer?.invalidate()
        createBallTimer = nil
        print("Нет элементов")
        timerUpdate?.invalidate()
        timerUpdate = nil
        print("таймер счетчика закончен")
        return
    }
    
    @objc private func dropButtonButtonAction() {
        guard popupActive == false else { return }
    }
    
 
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}

extension GameScene {
    
    
}
