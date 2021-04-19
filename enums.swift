//Перечисления

enum SomeEnumeration {
    //здесь будет объявление перечисления
}

enum CompassPoint {
    case north
    case south
    case east
    case west
}

//можно записывать в одну строку
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//обьявление переменной перечисления
var directionToHead = CompassPoint.west

//если обьявление переменной было названно CompassPoint
directionToHead = .east


//перечисление с конструкцией switch
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// Выводит "Watch out for penguins"


let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Выведет "Mostly harmless"


//Итерация по перечеслению
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Выведет "3 beverages available"

for beverage in Beverage.allCases {
    print(beverage)
}
// coffee
// tea
// juice


//перечисления для штрихкода с ассоциативными значениями
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)

productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Выводит "QR code: ABCDEFGHIJKLMNOP."

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Выведет "QR code: ABCDEFGHIJKLMNOP."

//Исходные значения
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//неявно установленные значения

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//В приведенном выше примере, Planet.mercury имеет явное исходное значение 1, Planet.venus имеет неявное исходное значение 2, и так далее.

enum CompassPoint: String {
    case north, south, east, west
}

//В приведенном выше примере, CompassPoint.south имеет неявное исходное значение "south" и так далее.

//Для доступа к исходному значению кейса перечисления существует свойство rawValue:
let earthsOrder = Planet.earth.rawValue
// значение earthsOrder равно 3
 
let sunsetDirection = CompassPoint.west.rawValue
// значение sunsetDirection равно "west"


//Инициализация черех исходное значение
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet имеет тип Planet? и его значение равно Planet.uranus

let positionToFind = 11
if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// Выведет "There isn't a planet at position 11"

//Этот пример использует привязку опционалов для попытки добраться до Planet с исходным значением 11. 
//Выражение if let somePlanet = Planet(rawValue: 11) создает опциональную Planet 
//и устанавливает значение somePlanet опциональной Planet, если она может быть восстановлена. 
//В этом случае невозможно добраться до планеты с позицией 11, таким образом срабатывает ветка else.


//Рекурсивные перечисления
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

//Вы так же можете написать indirect прямо перед самим перечислением, что позволит обозначить то, что все члены перечисления поддерживают индиректность:

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
 
print(evaluate(product))
// Выведет "18"





