//Деиницализация

deinit {
  // проведение деинициализации
}

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

//Класс Player реализует деинициализатор, который вызывается сразу после того, как экземпляр освобождается.
//В примере ниже деинициализатор просто возвращает все монеты игрока в банк

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Выведет "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Выведет "There are now 9900 coins left in the bank"

playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// Выведет "PlayerOne won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left")
// Выведет "The bank now only has 7900 coins left"

playerOne = nil
print("PlayerOne has left the game")
// Выведет "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// Выведет "The bank now has 10000 coins"

//Игрок покинул игру. Это осуществимо, если мы присвоим опционалу playerOne значение nil, что значит, что игрока больше нет. 
//На этот момент мы больше не имеем доступа к свойствам или методам переменной playerOne, то есть у нас не стало ссылки на экземпляр класса Player, 
//так что экземпляр освобождается и освобождается память. 
//Прямо перед тем как это случится, автоматически вызывается деинициализатор, который возвращает монеты в банк.