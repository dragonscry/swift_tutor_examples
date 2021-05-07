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















