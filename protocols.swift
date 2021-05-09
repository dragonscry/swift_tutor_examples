// Протоколы

protocol SomeProtocol {
    // определение протокола…
}

//Пользовательские типы утверждают, что они принимают протокол, когда они помещают 
//имя протокола после имени типа и разделяются с этим именем двоеточием, то есть указывают эти протоколы как часть их определения. 

struct SomeStructure: FirstProtocol, AnotherProtocol {
    // определение структуры…
}

//Если у класса есть суперкласс, то вписывайте имя суперкласса до списка протоколов, которые он принимает, также разделите имя суперкласса и имя протокола запятой:

class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // определение класса…
}

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

//Пример протокола с единственным требуемым свойством экземпляра:
protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
// john.fullName равен "John Appleseed"

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName равен "USS Enterprise"


protocol SomeProtocol {
    static func someTypeMethod()
}
//Следующий пример определяет протокол с единственным требуемым методом экземпляра:
protocol RandomNumberGenerator {
    func random() -> Double
}


class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Выведет "Случайное число: 0.37464991998171"
print("And another one: \(generator.random())")
// Выведет "Другое случайное число: 0.729023776863283"


//Если вы поставили ключевое слово mutating перед методом требуемым протоколом экземпляра, то вам не нужно писать слово mutating при реализации этого метода для класса. 
//Слово mutating используется только структурами или перечислениями.

protocol Togglable {
    mutating func toggle()
}


enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch теперь равен .on

//Требование инициализатора

protocol SomeProtocol {
    init(someParameter: Int)
}

class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        // реализация инициализатора…
    }
}


//Вам не нужно обозначать реализацию инициализаторов протокола модификатором required в классах, где стоит модификатор final, 
//потому что конечные классы не могут иметь подклассы.

protocol SomeProtocol {
    init()
}
 
class SomeSuperClass {
    init() {
        // реализация инициализатора…
    }
}
 
class SomeSubClass: SomeSuperClass, SomeProtocol {
    // "required" от соответсвия протоколу SomeProtocol; "override" от суперкласса SomeSuperClass
    required override init() {
        // реализация инициализатора…
    }
}

//Из-за того что протоколы являются типами, то их имена начинаются с заглавной буквы (как в случае FullyNamed или RandomNumberGenerator) 
//для соответствия имен с другими типами Swift (Int, String, Bool, Double…)

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}


var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Бросок игральной кости равен \(d6.roll())")
}
// Бросок игральной кости равен 3
// Бросок игральной кости равен 5
// Бросок игральной кости равен 4
// Бросок игральной кости равен 5
// Бросок игральной кости равен 4



//Делегирование

protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}



class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}



class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Начали новую игру Змеи и лестницы")
        }
        print("У игральной кости \(game.dice.sides) граней")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Выкинули \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("Длительность игры \(numberOfTurns) хода")
    }

 //DiceGameTracker реализует все три метода, которые требует DiceGameDelegate.
 //он использует эти методы для отслеживания количества ходов, которые были сделаны в игре. 


let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
// Начали новую игру Змеи и лестницы
// У игральной кости 6 граней
// Выкинули 3
// Выкинули 5
// Выкинули 4
// Выкинули 5
// Длительность игры 4 хода


//Добавление реализации протокола через расширение

//Существующие экземпляры типа автоматически принимают и отвечают требованиям протокола, 
//когда опции, необходимые для соответствия добавляются через расширение типа.

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "Игральная кость с \(sides) гранями"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)
// Выведет "Игральная кость с 12 гранями"


extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "Игра Змеи и Лестницы с полем в \(finalSquare) клеток"
    }
}
print(game.textualDescription)
// Выведет "Игра Змеи и Лестницы с полем в 25 клеток"

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let myDice = [d6, d12]
print(myDice.textualDescription)
// Prints "[A 6-sided dice, A 12-sided dice]"


//Принятие протокола через расширение


//Если тип уже соответствует всем требованиям протокола, но еще не заявил, что он принимает этот протокол, то вы можете сделать это через пустое расширение
struct Hamster {
    var name: String
    var textualDescription: String {
        return "Хомяка назвали \(name)"
    }
}
extension Hamster: TextRepresentable {}


let simonTheHamster = Hamster(name: "Фруша")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// Выведет "Хомяка назвали Фруша"

//Типы не принимают протоколы автоматически, если они удовлетворяют их требованиям. Принятие протокола должно быть объявлено в явной форме.


//Принятие протокола через синтезированную реализацию

struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("Эти два вектора эквивалентны.")
}
// Выведет "Эти два вектора эквивалентны."

enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(stars: Int)
}
var levels = [SkillLevel.intermediate, SkillLevel.beginner,
              SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
for level in levels.sorted() {
    print(level)
}
// Выведет "beginner"
// Выведет "intermediate"
// Выведет "expert(stars: 3)"
// Выведет "expert(stars: 5)"


//Коллекции типов протокола

let things: [TextRepresentable] = [game, d12, simonTheHamster]


for thing in things {
    print(thing.textualDescription)
}
// Игра Змеи и Лестницы с полем в 25 клеток
// Игральная кость с 12 гранями
// Хомяка назвали Фруша


//Наследование протокола

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // определение протокола…
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

//Этот пример определяет новый протокол PrettyTextRepresentable, который наследует из TextRepresentable. 

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

print(game.prettyTextualDescription)
// Игра Змеи и Лестницы с полем в 25 клеток:
// ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○



//Классовые протоколы

//Вы можете ограничить протокол так, чтобы его могли принимать только классы (но не структуры или перечисления), добавив AnyObject протокол к списку реализации протоколов.

protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
    // определение протокола типа class-only
}

//Используйте протоколы class-only, когда поведение, определяемое протоколом, предполагает или требует, что соответствующий протоколу тип должен быть ссылочного типа, а не типом значения. 




//Композиция протоколов

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("С Днем Рождения, \(celebrator.name)! Тебе уже \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Сашка", age: 21)
wishHappyBirthday(to: birthdayPerson)
// Выведет "С Днем Рождения, Сашка! Тебе уже 21!"

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}
 
let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)
// Выведет "Hello, Seattle!"


//Проверка соответствия протоколу

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]


for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Площадь равна \(objectWithArea.area)")
    } else {
        print("Что-то такое, что не имеет площади")
    }
}
// Площадь равна 12.5663708
// Площадь равна 243610.0
// Что-то такое, что не имеет площади

//Опциональные требования протокола

//Вы можете определить опциональные требования для протокола. Эти требования не обязательно должны быть реализованы для соответствия протоколу. 
//Опциональные требования должны иметь префиксный модификатор optional в качестве части определения протокола. 

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

//Строго говоря, вы можете написать пользовательский класс, который соответствует протоколу CounterDataSource без реализации какого-либо требования этого протокола. 
//Они оба опциональные, в конце концов. Хотя технически это допускается, но это не будет реализовываться для хорошего источника данных.

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}


var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}
// 3
// 6
// 9
// 12

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}
// -3
// -2
// -1
// 0
// 0


//Расширения протоколов

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator = LinearCongruentialGenerator()
print("Рандомное число: \(generator.random())")
// Выведет "Рандомное число: 0.37464991998171"
print("Рандомное логическое значение: \(generator.randomBool())")
// Выведет "Рандомное логическое значение: true"


//Обеспечение реализации по умолчанию (дефолтной реализации)

//Требования протокола с реализацией по умолчанию, предоставляемой расширениями, отличаются от опциональных требований протокола. 
//Хотя соответствующие типы не должны предоставлять свою собственную реализацию, требования с реализацией по умолчанию могут быть вызваны без опциональных последовательностей.


extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}



//Добавление ограничений к расширениям протоколов

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]


print(equalNumbers.allEqual())
// Prints "true"
print(differentNumbers.allEqual())
// Prints "false"

//Если подписанный тип удовлетворяет требованиям нескольких ограничивающих расширений, которые предоставляют реализации 
//для одного и того же метода или свойства, то Swift будет использовать самое строгое ограничение.













































































































































































































