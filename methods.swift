//Методы

//функции в классах и структурах

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
// начальное значение counter равно 0
counter.increment()
// теперь значение counter равно 1
counter.increment(by: 5)
// теперь значение counter равно 6
counter.reset()
// теперь значение counter равно 0


//Каждый экземпляр типа имеет неявное свойство self, которое является абсолютным эквивалентом самому экземпляру. 
//Вы используете свойство self для ссылки на текущий экземпляр, внутри методов этого экземпляра.

func increment() {
    self.count += 1
}

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("Эта точка находится справа от линии, где x == 1.0")
}
// Выведет "Эта точка находится справа от линии, где x == 1.0"

//Без префикса self, Swift будет думать, что в обоих случаях x будет как раз параметром метода, который так же называется x.


//Изменение структур методами
struct Point {
   var x = 0.0, y = 0.0
   mutating func moveBy(x deltaX: Double, y deltaY: Double) {
      x += deltaX
      y += deltaY
   }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("Сейчас эта точка на (\(somePoint.x), \(somePoint.y))")
// Выведет "Сейчас эта точка на (3.0, 4.0)"

let fixedPoint = Point(x: 3.0, y: 3.0)
fixedPoint.moveBy(x: 2.0, y: 3.0)
// это вызовет сообщение об ошибке



//Изменяющие методы могут присваивать полностью новый экземпляр неявному свойству self. 
//Пример Point, приведенный выше, мог бы быть записан в такой форме:

struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

//Такая версия изменяющего метода moveBy(x:y:) создает абсолютно новую структуру, чьим значениям x, y присвоены значения конечной точки.


//Изменяющие методы для перечислений могут установить отдельный член перечисления как неявный параметр self:

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight равен .high
ovenLight.next()
// ovenLight равен .off


//Вы так же можете определить методы, которые вызываются самим типом. 
//Такие методы зовутся методами типа. Индикатор такого метода - ключевое слово static, которое ставится до ключевого слова метода func. 
//Классы так же могут использовать ключевое слово class, чтобы разрешать подклассам переопределение инструкций суперкласса этого метода.
//методы типа
class SomeClass {
    class func someTypeMethod(){
        //здесь идет реализация метода
    }
}
 
SomeClass.someTypeMethod()

//структура проверки уровня и класс игрока взаимодействующий с структурой

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel 
    } 

    @discardableResult mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("Самый последний доступный уровень сейчас равен \(LevelTracker.highestUnlockedLevel)")
//Выведет "Самый последний доступный уровень сейчас равен 2"

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("Игрок на уровне 6")
} else {
    print("Уровень 6 еще не разблокирован")
}
// Выведет "Уровень 6 еще не разблокирован"



