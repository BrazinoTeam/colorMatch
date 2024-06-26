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
    var imageName: String
}

class GameScene: SKScene {
    
        private var popupActive: Bool = false
        private var coints: Int = 0
        private var dropButton = CustomSKButton(texture: SKTexture(imageNamed: "playBtn"))
        private var greenSprite: SKSpriteNode!
        private var containerBall: SKSpriteNode!
        private var count = 25
    
        private let storage = UD.shared
        private var bingoItems: [bingo] = []
        private var bingoItemsAppend: [bingo] = []
        private var bingoItemsBall: [bingo] = []
        private var bingoItemsBallTapped: [bingo] = []


        private var createBallTimer: Timer?
        private var timerLabel: SKLabelNode!
        private var countLabel: SKLabelNode!

        private var remainingTime: Int = 4
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
           timerLabel.fontName = "SquadaOne-Regular"
           timerLabel.fontSize = 24
           timerLabel.fontColor = .white
           timerLabel.position = CGPoint(x: greenSprite.frame.minX + 60, y: greenSprite.frame.midY - 10)
           timerLabel.zPosition = 21
           addChild(timerLabel)
       }
       
    private func setupProgressCircle() {
           let radius: CGFloat = 20
           let circlePath = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: CGFloat(-Double.pi / 2), endAngle: CGFloat(3 * Double.pi / 2), clockwise: true)
           
           progressCircle = SKShapeNode(path: circlePath.cgPath)
           progressCircle.position = CGPoint(x: greenSprite.frame.minX + 100, y: greenSprite.frame.midY)
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
               sector.fillColor = .cLight
               sector.strokeColor = .clear
               sector.position = CGPoint(x: greenSprite.frame.minX + 60, y: greenSprite.frame.midY)
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
            if count == 0 {
                  print("Вы выиграли!")
                  createBallTimer?.invalidate()
                  createBallTimer = nil
                showGameOverViewScore()
                  return
            } else {
                print("Проиграли")
                showGameOverLose()
            }
            
            createBallTimer?.invalidate()
            createBallTimer = nil
            print("Нет элементов")
            return
        }

        let randomIndex = Int.random(in: 0..<bingoItems.count)
        let item = bingoItems.remove(at: randomIndex)
        bingoItemsBall.append(item)
        if bingoItemsAppend.count == 5 {
               bingoItemsAppend.removeFirst()
           }
        
        bingoItemsAppend.append(item)
        print("bingoItemsAppend содержит: \(bingoItemsAppend.map { $0.name })")
        // Создаем новый шар с радиусом 30
        let ballRadius: CGFloat = 30
        let ball = SKShapeNode(circleOfRadius: ballRadius)
        ball.name = "ball"
        ball.fillColor = item.color
        ball.strokeColor = .clear
        ball.position = CGPoint(x: greenSprite.position.x - 70, y: greenSprite.position.y)
        ball.zPosition = 12
        addChild(ball)

        let label = SKLabelNode(text: "\(item.number)")
        label.fontName = "SquadaOne-Regular"
        label.fontSize = 36
        label.fontColor = .white
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.name = "label" // Убедитесь, что имя установлено
        ball.addChild(label)

        // Перемещаем существующие шары
        moveExistingBalls()
    }

    
    private func moveExistingBalls() {
        let newBallWidth: CGFloat = 40 // Новый шар с радиусом 30 имеет ширину 60
        let spacing: CGFloat = 12 // Отступ между шарами

        children.compactMap { $0 as? SKShapeNode }.forEach { shapeNode in
            if shapeNode.name == "ball" && shapeNode !== children.last {
                let scaleAction = SKAction.scale(to: 20/30, duration: 0.3) // Уменьшаем до радиуса 20
                let moveAction = SKAction.moveBy(x: newBallWidth + spacing, y: 0, duration: 0.3) // Перемещаем на ширину нового шара плюс отступ
                let alphaAction = SKAction.fadeAlpha(to: 0.4, duration: 0.3) // Уменьшаем альфа-канал до 0.4
                let groupAction = SKAction.group([scaleAction, moveAction, alphaAction])
                shapeNode.run(groupAction)

                // Изменяем цвет текста у лейбла внутри шара
                if let label = shapeNode.childNode(withName: "label") as? SKLabelNode {
                    label.fontColor = .black // Меняем цвет текста на белый
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
         super.update(currentTime)
         // Проверяем шары на выход за пределы containerBall
         for child in children {
             if let shapeNode = child as? SKShapeNode, shapeNode.name == "ball" {
                 if shapeNode.position.x > containerBall.frame.maxX {
                     shapeNode.removeFromParent()
                 }
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
            bingo(name: "Red_58", color: .cRed, number: 58, imageName: "red58"),
              bingo(name: "Red_27", color: .cRed, number: 27, imageName: "red27"),
              bingo(name: "Red_56", color: .cRed, number: 56, imageName: "red56"),
              bingo(name: "Red_84", color: .cRed, number: 84, imageName: "red84"),
              bingo(name: "Red_45", color: .cRed, number: 45, imageName: "red45"),

              bingo(name: "Orange_34", color: .cYellow, number: 34, imageName: "yellow34"),
              bingo(name: "Orange_18", color: .cYellow, number: 18, imageName: "yellow18"),
              bingo(name: "Orange_14", color: .cYellow, number: 14, imageName: "yellow14"),
              bingo(name: "Orange_66", color: .cYellow, number: 66, imageName: "yellow66"),
              bingo(name: "Orange_25", color: .cYellow, number: 25, imageName: "yellow25"),

              bingo(name: "Green_46", color: .cGreen, number: 46, imageName: "green46"),
              bingo(name: "Green_84", color: .cGreen, number: 84, imageName: "green84"),
              bingo(name: "Green_8", color: .cGreen, number: 8, imageName: "green8"),
              bingo(name: "Green_10", color: .cGreen, number: 10, imageName: "green10"),
              bingo(name: "Green_77", color: .cGreen, number: 77, imageName: "green77"),

              bingo(name: "Blue_36", color: .cBlue, number: 36, imageName: "blue36"),
              bingo(name: "Blue_25", color: .cBlue, number: 25, imageName: "blue25"),
              bingo(name: "Blue_90", color: .cBlue, number: 90, imageName: "blue90"),
              bingo(name: "Blue_28", color: .cBlue, number: 28, imageName: "blue28"),
              bingo(name: "Blue_18", color: .cBlue, number: 18, imageName: "blue18"),

              bingo(name: "SystemPink_33", color: .cPurple, number: 33, imageName: "purple33"),
              bingo(name: "SystemPink_78", color: .cPurple, number: 78, imageName: "purple78"),
              bingo(name: "SystemPink_55", color: .cPurple, number: 55, imageName: "purple55"),
              bingo(name: "SystemPink_19", color: .cPurple, number: 19, imageName: "purple19"),
              bingo(name: "SystemPink_91", color: .cPurple, number: 91, imageName: "purple91")
          ]
      }
    
    private func createBingoSquares() {
        let squareSize = CGSize(width: 60, height: 60)
        let centerX = size.width / 2
        let centerY = size.height / 2 - 90
        
        for (index, item) in bingoItems.enumerated() {
            let col = index / 5
            let row = index % 5
            
            let xOffset = CGFloat(col - 2) * (squareSize.width)
            let yOffset = CGFloat(row - 2) * (squareSize.height)
            
            let square = SKSpriteNode(imageNamed: "\(item.imageName)")
            square.position = CGPoint(x: centerX + xOffset, y: centerY - yOffset)
            square.size = .init(width: 60, height: 60)
            square.name = item.name
            addChild(square)
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

        if let name = nodeName, let item = bingoItemsAppend.first(where: { $0.name == name }) {
            parentNode?.alpha = 0.1
            count -= 1
            print("Элемент \(name) найден и скрыт")
            bingoItemsBallTapped.append(item)
            print("Tapped содержит: \(bingoItemsBallTapped.map { $0.name })")

        } else {
            print("Неправильный элемент")
        }
        checkForWinningCombination()
      
    }

    private func checkForWinningCombination() {
        let redItemsTappedCount = bingoItemsBallTapped.filter { $0.color == .cRed }.count
        if redItemsTappedCount == 5 {
            moveBall(ball: redBall, to: redFinal.position, finalNode: redFinal, finalImageName: "redFinalOne")
            redFinal.position = CGPoint(x: 75, y: size.height / 2 - 285)
        }

        let orangeItemsTappedCount = bingoItemsBallTapped.filter { $0.color == .cYellow }.count
        if orangeItemsTappedCount == 5 {
            moveBall(ball: orangeBall, to: orangeFinal.position, finalNode: orangeFinal, finalImageName: "orangeFinalOne")
            orangeFinal.position = CGPoint(x: 135, y: size.height / 2 - 285)
        }

        let greenItemsTappedCount = bingoItemsBallTapped.filter { $0.color == .cGreen }.count
        if greenItemsTappedCount == 5 {
            moveBall(ball: greenBall, to: greenFinal.position, finalNode: greenFinal, finalImageName: "greenFinalOne")
            greenFinal.position = CGPoint(x: 195, y: size.height / 2 - 285)
        }

        let blueItemsTappedCount = bingoItemsBallTapped.filter { $0.color == .cBlue }.count
        if blueItemsTappedCount == 5 {
            moveBall(ball: blueBall, to: blueFinal.position, finalNode: blueFinal, finalImageName: "blueFinalOne")
            blueFinal.position = CGPoint(x: 255, y: size.height / 2 - 285)
        }

        let pinkItemsTappedCount = bingoItemsBallTapped.filter { $0.color == .cPurple }.count
        if pinkItemsTappedCount == 5 {
            moveBall(ball: pinkBall, to: pinkFinal.position, finalNode: pinkFinal, finalImageName: "pinkFinalOne")
            pinkFinal.position = CGPoint(x: 315, y: size.height / 2 - 285)
        }
    }
    
    private func moveBall(ball: SKSpriteNode, to position: CGPoint, finalNode: SKSpriteNode, finalImageName: String) {
        let moveAction = SKAction.moveTo(y: position.y, duration: 1.0)
        let changeTextureAction = SKAction.run {
            finalNode.texture = SKTexture(imageNamed: finalImageName)
            finalNode.size = .init(width: 60, height: 50)
        }
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveAction, changeTextureAction, removeAction])
        ball.run(sequence)
    }

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
        backBtn.size = .init(width: 56, height: 56)
        backBtn.anchorPoint = .init(x: 0, y: 1.0)
        backBtn.position = CGPoint(x: 20.autoSize, y: size.height - 58.autoSize)
        backBtn.normal = UIImage(named: "btnBack")
        backBtn.highlighted = UIImage(named: "btnBackTapped")
        backBtn.zPosition = 50
        backBtn.action = { self.backButtonAction() }
        addChild(backBtn)
        
        let titleLabel = SKLabelNode(text: "Game")
        titleLabel.fontName = "SquadaOne-Regular"
        titleLabel.fontSize = 36
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height - 100.autoSize)
        titleLabel.zPosition = 50
        addChild(titleLabel)
        
        redBall = SKSpriteNode(imageNamed: "ballRed")
        redBall.size = .init(width: 48, height: 48)
        redBall.anchorPoint = .init(x: 0, y: 1.0)
        redBall.position = CGPoint(x: 54, y: size.height / 2 + 150)
        redBall.zPosition = 50
        addChild(redBall)

        orangeBall = SKSpriteNode(imageNamed: "ballYellow")
        orangeBall.size = .init(width: 48, height: 48)
        orangeBall.anchorPoint = .init(x: 0, y: 1.0)
        orangeBall.position = CGPoint(x: 114, y: size.height / 2 + 150)
        orangeBall.zPosition = 50
        addChild(orangeBall)
        
        greenBall = SKSpriteNode(imageNamed: "ballGreen")
        greenBall.size = .init(width: 48, height: 48)
        greenBall.anchorPoint = .init(x: 0, y: 1.0)
        greenBall.position = CGPoint(x: 174, y: size.height / 2 + 150)
        greenBall.zPosition = 50
        addChild(greenBall)
        
        blueBall = SKSpriteNode(imageNamed: "ballBlue")
        blueBall.size = .init(width: 48, height: 48)
        blueBall.anchorPoint = .init(x: 0, y: 1.0)
        blueBall.position = CGPoint(x: 234, y: size.height / 2 + 150)
        blueBall.zPosition = 50
        addChild(blueBall)
        
        pinkBall = SKSpriteNode(imageNamed: "ballPurple")
        pinkBall.size = .init(width: 48, height: 48)
        pinkBall.anchorPoint = .init(x: 0, y: 1.0)
        pinkBall.position = CGPoint(x: 294, y: size.height / 2 + 150)
        pinkBall.zPosition = 50
        addChild(pinkBall)
        
        greenSprite = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: 48.autoSize))
        greenSprite.position = CGPoint(x: size.width / 2, y: size.height - 190)
        greenSprite.zPosition = 10
        addChild(greenSprite)
        
        containerBall = SKSpriteNode(imageNamed: "containerBall")
        containerBall.position = CGPoint(x: size.width / 2 + 46, y: size.height - 190)
        containerBall.zPosition = 11
        addChild(containerBall)
        
        redFinal = SKSpriteNode(imageNamed: "redFinal")
        redFinal.position = CGPoint(x: 75, y: size.height / 2 - 290)
        redFinal.zPosition = 10
        addChild(redFinal)

        orangeFinal = SKSpriteNode(imageNamed: "orangeFinal")
        orangeFinal.position = CGPoint(x: 135, y: size.height / 2 - 290)
        orangeFinal.zPosition = 10
        addChild(orangeFinal)
        
        greenFinal = SKSpriteNode(imageNamed: "greenFinal")
        greenFinal.position = CGPoint(x: 195, y: size.height / 2 - 290)
        greenFinal.zPosition = 10
        addChild(greenFinal)
        
        blueFinal = SKSpriteNode(imageNamed: "blueFinal")
        blueFinal.position = CGPoint(x: 255, y: size.height / 2 - 290)
        blueFinal.zPosition = 10
        addChild(blueFinal)
        
        pinkFinal = SKSpriteNode(imageNamed: "pinkFinal")
        pinkFinal.position = CGPoint(x: 315, y: size.height / 2 - 290)
        pinkFinal.zPosition = 10
        addChild(pinkFinal)
    }
}
extension GameScene {
    
    
    private func showGameOverViewScore() {
        storage.scoreCoints += 500
        let gameOverNode = SKSpriteNode(color: .black.withAlphaComponent(0.6), size: self.size)
        gameOverNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        gameOverNode.zPosition = 100
        gameOverNode.name = "gameOverNode"
        
        let square = SKSpriteNode(imageNamed: "contWinGame")
        square.size = CGSize(width: 353.autoSize, height: 522.autoSize)
        square.position = CGPoint(x: 0, y: -20.autoSize)
        square.zPosition = 101
        gameOverNode.addChild(square)
        
        let imgYouWin = SKSpriteNode(imageNamed: "imgYouWin")
        imgYouWin.size = CGSize(width: 267.autoSize, height: 230.autoSize)
        imgYouWin.position = CGPoint(x: 0, y: 100.autoSize)
        imgYouWin.zPosition = 101
        square.addChild(imgYouWin)
        
        let titleLabel = SKLabelNode()
          let titleText = "Good Game. You won".uppercased()
          let titleAttributes: [NSAttributedString.Key: Any] = [
              .font: UIFont(name: "SquadaOne-Regular", size: 24)!,
              .foregroundColor: UIColor.white,
          ]
          let attributedTitle = NSAttributedString(string: titleText, attributes: titleAttributes)
          titleLabel.attributedText = attributedTitle
          titleLabel.position = CGPoint(x: 0, y: -72.autoSize)
          titleLabel.zPosition = 102
          square.addChild(titleLabel)

        let scoreImg = SKSpriteNode(imageNamed: "imgBallWin")
        scoreImg.size = CGSize(width: 40.autoSize, height: 40.autoSize)
        scoreImg.position = CGPoint(x: -40, y: -122.autoSize)
        scoreImg.zPosition = 102
        square.addChild(scoreImg)
        
        let cointsLabel = SKLabelNode()
        let cointsText = "+500"
        let cointsAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "SquadaOne-Regular", size: 36)!,
                .foregroundColor: UIColor.cYellow,
            ]
            let attributedCoints = NSAttributedString(string: cointsText, attributes: cointsAttributes)
            cointsLabel.attributedText = attributedCoints
            cointsLabel.position = CGPoint(x: 20.autoSize, y: -136.autoSize)
            cointsLabel.zPosition = 102
        square.addChild(cointsLabel)

        let thanksBtn = CustomSKButton(texture: SKTexture(imageNamed: "btnThanks"))
        thanksBtn.size = .init(width: 321.autoSize, height: 56.autoSize)
        thanksBtn.position =  CGPoint(x: 0, y: -200.autoSize)
        thanksBtn.zPosition = 40
        thanksBtn.normal = UIImage(named: "btnThanks")
        thanksBtn.highlighted = UIImage(named: "btnThanksTapped")
        thanksBtn.action = { self.backHomeAction() }
        square.addChild(thanksBtn)
        
        self.addChild(gameOverNode)
       
    }
    
    private func showGameOverLose() {
        
        let gameOverNode = SKSpriteNode(color: .black.withAlphaComponent(0.6), size: self.size)
        gameOverNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        gameOverNode.zPosition = 100
        gameOverNode.name = "gameOverNode"
        
        let square = SKSpriteNode(imageNamed: "contLoseGame")
        square.size = CGSize(width: 357.autoSize, height: 434.autoSize)
        square.position = CGPoint(x: 0, y: -20.autoSize)
        square.zPosition = 101
        gameOverNode.addChild(square)
        
        let thanksBtn = CustomSKButton(texture: SKTexture(imageNamed: "btnOK"))
        thanksBtn.size = .init(width: 321.autoSize, height: 56.autoSize)
        thanksBtn.position =  CGPoint(x: 0, y: -180.autoSize)
        thanksBtn.zPosition = 40
        thanksBtn.normal = UIImage(named: "btnOK")
        thanksBtn.highlighted = UIImage(named: "btnOKTapped")
        thanksBtn.action = { self.backHomeAction() }
        square.addChild(thanksBtn)
        
        self.addChild(gameOverNode)
       
    }
    
    @objc private func settingsButtonAction() {
        guard popupActive == false else { return }
        resultTransfer?(.updateScoreBackEnd)
    }
    
    @objc private func backHomeAction() {
        guard popupActive == false else { return }
        resultTransfer?(.gameBack)
        createBallTimer?.invalidate()
        createBallTimer = nil
        print("Нет элементов")
        timerUpdate?.invalidate()
        timerUpdate = nil
        print("таймер счетчика закончен")

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
