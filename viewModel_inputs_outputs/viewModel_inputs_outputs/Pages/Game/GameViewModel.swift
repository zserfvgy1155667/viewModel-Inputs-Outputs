//
//  GameViewModel.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import UIKit


// viewModel
class GameViewModel: GameViewModelType, GameViewModelInputs, GameViewModelOutputs {
    
    typealias Input = GameViewModelInputs
    typealias Output = GameViewModelOutputs
    
    
    weak var inputs: Input? { self }
    weak var outputs: Output? { self }
    
    /// 玩家總數量
    var playerTotalCount: Int {
        playerNames.count
    }
    
    
    /// 卡片提示的 viewModel
    let cardTipViewModel = CardTipViewModel()
    /// 管理 選擇卡片的 viewModel
    let selectCardViewModel: SelectCardViewModel
    /// 玩家提示 viewModel
    let playerTipViewModel = PlayerTipViewModel()
    
    
    /// 原始目前玩家數量
    private let playerNames: [String]
    /// 贏的玩家名稱
    private var winPlayerNames: [String] = []
    /// 未挑戰的玩家名稱
    private var noPkPlayerNames: [String] = []
    /// 需要 pk 的勝局次數
    private let pkRaceCount: Int
    /// 預設需要 pk 的玩家數量
    private let defaultPkPlayerCount: Int

    // MARK: 每局遊戲紀錄
    /// 紀錄挑戰資訊 (key: playerName, value: 勝局次數)
    private var currentPkRaceCountInfo = [String: Int]()
    /// 目前決鬥是否已經有贏過的
    private var currentPkHasWin: Bool = false
    /// 目前決鬥卡片類型 (key: playerName, value: 卡片類型)
    private var currentCardType = [String: CardType]()
    /// 需要 pk 的玩家數量
    private var pkPlayerCount: Int
    
    /// 遊戲狀態
    private var gameStatus = GameStatus.start
    
    
    /// 建構子
    /// - Parameters:
    ///   - playerNames: 玩家名稱
    ///   - pkRaceCount: 需要 pk 的勝局次數
    ///   - pkPlayerCount: 需要 pk 的玩家數量
    ///   - cardTypeMinCount: 卡片每個類型的最小數量
    ///   - cardTotalCount: 卡片總數量
    init(
        playerNames: [String],
        pkRaceCount: Int,
        pkPlayerCount: Int,
        cardTypeMinCount: Int,
        cardTotalCount: Int
    ) {
       
        self.playerNames = playerNames
        self.noPkPlayerNames = playerNames.shuffled()
        self.pkRaceCount = pkRaceCount
        self.defaultPkPlayerCount = pkPlayerCount
        self.pkPlayerCount = pkPlayerCount
        self.selectCardViewModel = SelectCardViewModel(typeMinCount: cardTypeMinCount, totalCount: cardTotalCount)
        
        
        /// 綁定 viewModel
        setupBindings()
    }
    
    // MARK: Output
    var cardTipItems: ((NSDiffableDataSourceSnapshot<CardTipCollectionView.SectionType, Item>) -> Void)?
    var selectCardItems: ((NSDiffableDataSourceSnapshot<SelectCardCollectionView.SectionType, Item>) -> Void)?
    var playerTipItems: ((NSDiffableDataSourceSnapshot<PlayerTipCollectionView.SectionType, Item>) -> Void)?
    
    
    // MARK: Input
    /// view 加載完成
    func viewDidLoad() {
        nextTrun()
    }
    
    /// 下一局
    func nextTrun(isSamePlayer: Bool = false) {
        
        // 判斷是否為相同選手
        if isSamePlayer {
            
            // 設定顯示清單
            playerTipViewModel.inputs?.initPlayerTip(pkRaceCountInfo: currentPkRaceCountInfo)
            // 重置清單
            playerTipViewModel.inputs?.resetTurnPlayer()
        }
        else {
            // 隨機生成對手
            let pkPlayerNames = nextTrunPkList()
            // 紀錄贏的勝局局數
            initRaceCountInfo(pkPlayerNames)
            // 設定顯示清單
            playerTipViewModel.inputs?.initPlayerTip(pkRaceCountInfo: currentPkRaceCountInfo)
        }
        
        // 生成隨機牌面
        selectCardViewModel.createRandomCards()
        
        // 更新現在遊戲狀態
        gameStatus = .start
    }
    
    /// 選擇卡片結束
    func pickCardDone(itemIndex: Int, cardType: CardType) {
        
        guard case .start = gameStatus,
            let playerTurnInfo = playerTipViewModel.getCurrentPlayerTurn() else {
            
            return
        }
        
        
        let index = playerTurnInfo.index
        let playerName = playerTurnInfo.playerName
        
        // 顯示卡片
        selectCardViewModel.inputs?.selectCardByIndex(index: itemIndex, playerName: playerName)
        // 紀錄選擇的結果
        currentCardType.updateValue(cardType, forKey: playerName)
        
        
        // 一局結束，檢查勝負。
        if pkPlayerCount == (index + 1) {
            
            // 打開全部的卡
            selectCardViewModel.inputs?.allOpenCards()
            
            // 取得該局結果
            let turnResult = getTurnResult()
            // 清空猜拳緩存
            currentCardType = .init()
            
            // 沒有輸家，表示平手。
            if turnResult.losePlayerNames.isEmpty || turnResult.isDraw {
                gameStatus = .draw
                playerTipViewModel.inputs?.showGameResult(gameStatus)
                return
            }
            
            // 有贏家勝出
            var finalWinPlayerNames: [String] = []
            for winPlayerName in turnResult.winPlayerNames {
                if var count = currentPkRaceCountInfo[winPlayerName] {
                    count -= 1
                    currentPkRaceCountInfo.updateValue(count, forKey: winPlayerName)
                
                    // 勝局為 0，表示為最終勝利者。
                    if count <= 0 {
                        finalWinPlayerNames.append(winPlayerName)
                    }
                }
            }
            
            // 判斷是否要繼續比 (勝局次數沒有消完)
            if finalWinPlayerNames.isEmpty {
                gameStatus = .turnWin(playerName: turnResult.winPlayerNames.joined(separator: "、"), isPkDone: false)
                playerTipViewModel.inputs?.showGameResult(gameStatus)
            }
            else {
                
                // 該局贏家
                winPlayerNames.append(contentsOf: finalWinPlayerNames)
                
                if winPlayerNames.count == 1 && noPkPlayerNames.count == 0 {
                    gameStatus = .winner(playerName: winPlayerNames.first ?? "")
                    playerTipViewModel.inputs?.showGameResult(gameStatus)
                }
                else {
                    gameStatus = .turnWin(playerName: turnResult.winPlayerNames.joined(separator: "、"), isPkDone: true)
                    playerTipViewModel.inputs?.showGameResult(gameStatus)
                }
            }
        }
        else {
            // 換下一位玩家
            playerTipViewModel.nextPickPlayer()
        }
    }
    
    /// 點擊文字按鈕
    func tapTextButton() {
        
        switch gameStatus {
        case .winner:
            // 重置初始選手
            self.noPkPlayerNames = playerNames.shuffled()
            self.winPlayerNames = .init()
            self.pkPlayerCount = defaultPkPlayerCount
            
            // 下一輪
            nextTrun()
        case .turnWin(_, let isPkDone):
            nextTrun(isSamePlayer: !isPkDone)
        case .draw:
            nextTrun(isSamePlayer: true)
        default:
            break
        }
    }
    
    /// 開始綁定
    private func setupBindings() {
        
        cardTipViewModel.outputs?.updateItems = { [weak self] in
            self?.cardTipItems?($0)
        }
        
        selectCardViewModel.outputs?.updateItems = { [weak self] in
            self?.selectCardItems?($0)
        }
        selectCardViewModel.outputs?.updateCardTip = { [weak self] in
            for key in $0.keys {
                self?.cardTipViewModel.updateCardTip(key, count: $0[key] ?? 0)
            }
        }
        
        playerTipViewModel.outputs?.updateItems = { [weak self] in
            self?.playerTipItems?($0)
        }
    }
    
    /// 下一局 pk 清單
    private func nextTrunPkList() -> [(playerName: String, isWin: Bool)] {
        
        var pkPlayerNames: [(playerName: String, isWin: Bool)] = []
        
        // 人數調整
        if noPkPlayerNames.count == 0 { // 未挑戰為空，重新拉贏的人重新洗牌。
            self.noPkPlayerNames = winPlayerNames.shuffled()
            self.winPlayerNames = .init()
        }
        else if noPkPlayerNames.count < defaultPkPlayerCount {  // 未挑戰的人數不夠，先隨機洗牌一次，再重新加入未挑戰陣列。
            self.winPlayerNames = winPlayerNames.shuffled()
        }
        
        // 設定 pk 人數
        self.pkPlayerCount = min(pkPlayerCount, noPkPlayerNames.count + winPlayerNames.count)
        
        for _ in 0..<pkPlayerCount {
            
            if noPkPlayerNames.count > 0 {
                pkPlayerNames.append((playerName: noPkPlayerNames.removeFirst(), isWin: false))
            }
            else if winPlayerNames.count > 0 {
                pkPlayerNames.append((playerName: winPlayerNames.removeFirst(), isWin: true))
            }
        }
        
        return pkPlayerNames
    }
    
    /// 初始化勝局次數資訊
    private func initRaceCountInfo(_ pkPlayerNames: [(playerName: String, isWin: Bool)]) {
        
        self.currentPkRaceCountInfo = .init()
        
        let hasWin = pkPlayerNames.contains(where: { $0.isWin })
        for info in pkPlayerNames {
            
            // 贏過的玩家勝局次數以原本勝局次數為主，若未挑戰就改為兩倍(包含上一局次數)。
            var pkRaceCount = pkRaceCount
            if hasWin {
                pkRaceCount = info.isWin ? pkRaceCount : pkRaceCount * 2
            }
            
            currentPkRaceCountInfo.updateValue(pkRaceCount, forKey: info.playerName)
        }
    }
    
    /// 取得該局結果
    private func getTurnResult() -> TurnResult {
        
        var cardTypes: [CardType] = []
        
        var winPlayerNames: [String] = []
        var losePlayerNames: [String] = []
        
        var winCardType: CardType?
        
        var isDraw: Bool = false
        
        for (playerName, cardType) in currentCardType {
            
            // 紀錄是否平手 (所有卡牌都出現，表示該局平手)
            if !cardTypes.contains(where: { $0 == cardType }) {
                cardTypes.append(cardType)
                
                if cardTypes.count == CardType.allCases.count {
                    isDraw = true
                    break
                }
            }
            
            // 判斷結果
            if winPlayerNames.isEmpty {
                winPlayerNames = [playerName]
                winCardType = cardType
            }
            else if let currentWinCardType = winCardType {
                
                switch cardType.getGameTurnResult(currentWinCardType) {
                case .win:
                    losePlayerNames.append(contentsOf: winPlayerNames)
                    winPlayerNames = [playerName]
                    winCardType = cardType
                case .draw:
                    winPlayerNames.append(playerName)
                case .lost:
                    losePlayerNames.append(playerName)
                }
            }
        }
        
        return .init(winPlayerNames: winPlayerNames, losePlayerNames: losePlayerNames, isDraw: isDraw)
    }
}


// MARK: input/output
protocol GameViewModelInputs: AnyObject {
        
    /// view 加載完成
    func viewDidLoad()
    
    /// 下一局
    func nextTrun(isSamePlayer: Bool)
    
    /// 選擇卡片結束
    func pickCardDone(itemIndex: Int, cardType: CardType)
    
    /// 點擊文字按鈕
    func tapTextButton()
}

protocol GameViewModelOutputs: AnyObject {
        
    /// 更新項目
    var cardTipItems: ((NSDiffableDataSourceSnapshot<CardTipCollectionView.SectionType, Item>) -> Void)? { get set }
    /// 選擇卡片項目
    var selectCardItems: ((NSDiffableDataSourceSnapshot<SelectCardCollectionView.SectionType, Item>) -> Void)? { get set }
    /// 玩家提醒項目
    var playerTipItems: ((NSDiffableDataSourceSnapshot<PlayerTipCollectionView.SectionType, Item>) -> Void)? { get set }
}

protocol GameViewModelType {
    var inputs: GameViewModelInputs? { get }
    var outputs: GameViewModelOutputs? { get }
}

// MARK: display struct
extension GameViewModel {
    
    /// 每局結果
    struct TurnResult {
        
        /// 贏家資訊
        var winPlayerNames: [String] = []
        /// 輸家資訊
        var losePlayerNames: [String] = []
        /// 平手
        var isDraw: Bool = false
    }
}

