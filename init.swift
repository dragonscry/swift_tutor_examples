// //Инициализация

// init() {
//     // инициализация проводится тут
// }

// struct Fahrenheit {
//     var temperature: Double
//     init() {
//         temperature = 32.0
//     }
// }
// var f = Fahrenheit()
// print("Значение температуры по умолчанию \(f.temperature)° по Фаренгейту")
// // Выведет "Значение температуры по умолчанию 32.0° по Фаренгейту"

// //Структура определяет один инициализатор, init, без параметров, который инициализирует хранимую температуру равную 32.0 (температура замерзания воды по Фаренгейту).

// struct Fahrenheit {
//   var temperature = 32.0
// }
// //более простая форма

// struct Celsius {
//     var temperatureInCelsius: Double
//     init(fromFahrenheit fahrenheit: Double) {
//         temperatureInCelsius = (fahrenheit - 32.0) / 1.8
//     }
//     init(fromKelvin kelvin: Double) {
//         temperatureInCelsius = kelvin - 273.15
//     }
// }
// let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// // boilingPointOfWater.temperatureInCelsius is 100.0
// let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// // freezingPointOfWater.temperatureInCelsius is 0.0


// struct Color {
//     let red, green, blue: Double
//     init(red: Double, green: Double, blue: Double) {
//         self.red   = red
//         self.green = green
//         self.blue  = blue
//     }
//     init(white: Double) {
//         red   = white
//         green = white
//         blue  = white
//     }
// }

// //Оба инициализатора могут быть использованы для создания нового экземпляра Color, передав значения в каждый параметр инициализатора

// let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
// let halfGray = Color(white: 0.5)

// let veryGreen = Color(0.0, 1.0, 0.0)
// // этот код вызовет ошибку компиляции, так как здесь нет внешних имен

// //Если вы не хотите использовать внешние имена для параметров инициализации, 
// //напишите подчеркивание (_) вместо явного указания внешнего имени для этого параметра, чтобы переопределить поведение по умолчанию.


// struct Celsius {
//     var temperatureInCelsius: Double
//     init(fromFahrenheit fahrenheit: Double) {
//         temperatureInCelsius = (fahrenheit - 32.0) / 1.8
//     }
//     init(fromKelvin kelvin: Double) {
//         temperatureInCelsius = kelvin - 273.15
//     }
//     init(_ celsius: Double) {
//         temperatureInCelsius = celsius
//     }
// }
// let bodyTemperature = Celsius(37.0)
// // bodyTemperature.temperatureInCelsius is 37.0

// //Инициализатор вызывает Celsius(37.0), что понятно и без внешнего имени параметра. Поэтому целесообразно написать init(_ celsius: Double), для того, чтобы предоставить безымянное значение типа Double.

// //Опциональные свойства
// class SurveyQuestion {
//     var text: String
//     var response: String?
//     init(text: String) {
//         self.text = text
//     }
//     func ask() {
//         print(text)
//     }
// }
// let cheeseQuestion = SurveyQuestion(text: "Нравится ли вам сыр?")
// cheeseQuestion.ask()
// // Выведет "Нравится ли вам сыр?"
// cheeseQuestion.response = "Да, я люблю сыр"


// //Вы можете присвоить значения постоянных (когда свойство константа) свойств в любой точке вашего процесса инициализации. 
// //Как только для свойства константы присваивается значение, оно не может быть далее изменено.

// class SurveyQuestion {
//   let text: String
//   var response: String?
//   init(text: String) {
//     self.text = text
//   }
//   func ask() {
//     print(text)
//   }
// }
// let beetsQuestion = SurveyQuestion(text: "Что насчет свеклы?")
// beetsQuestion.ask()
// // Выведет "Что насчет свеклы?"
// beetsQuestion.response = "Я люблю свеклу, но не в сыром виде!"


// //Дефолтные инициализаторы

// class ShoppingListItem {
//     var name: String?
//     var quantity = 1
//     var purchased = false
// }
// var item = ShoppingListItem()

// //Почленны инициализатор или инициализатор структуры по умолчанию
// //для свойств у которых нет значения (но есть тип)

// struct Size {
//     var width = 0.0, height = 0.0
// }
// let twoByTwo = Size(width: 2.0, height: 2.0)


// //Делегирования инициализатора

// struct Size {
//     var width = 0.0, height = 0.0
// }
// struct Point {
//     var x = 0.0, y = 0.0
// }

// struct Rect {
//     var origin = Point()
//     var size = Size()
//     init() {}
//     init(origin: Point, size: Size) {
//         self.origin = origin
//         self.size = size
//     }
//     init(center: Point, size: Size) {
//         let originX = center.x - (size.width / 2)
//         let originY = center.y - (size.height / 2)
//         self.init(origin: Point(x: originX, y: originY), size: size)
//     }
// }

// //Первый инициализатор Rect - init() функционально тот же самый, что и дефолтный инициализатор

// let basicRect = Rect()
// //исходная точка Rect (0.0, 0.0) и его размер (0.0, 0.0)

// //Второй инициализатор Rect - init(origin:size:) 
// //функционально то же самое что и почленный инициализатор, который могла бы иметь структура, если бы не имела пользовательских инициализаторов.

// let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
// //исходная точка Rect (2.0, 2.0) и его размер (5.0, 5.0)

// //Третий инициализатор Rect - init(center:size:) немного более сложный. 
// //Он начинается с вычисления соответствующей исходной точки, основываясь на точке center и значении size. 
// //Только потом он вызывает ( или делегирует) init(origin:size:) инициализатор, который хранит новую исходную точку и значения размеров соответствующих свойств:


// let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// //исходная точка centerRect’а равна (2.5, 2.5) и его размер (3.0, 3.0)

// //Назначенный и вспомогательный инициализатор

// //Синтаксис назначенных и вспомогательных инициализаторов

// init(параметры) {
//      выражения
// }

// convenience init(параметры) {
//      выражения
// }

// //Делегирование инициализатора для классовых типов

// // Правило 1
// // Назначенный инициализатор должен вызывать назначенный инициализатор из суперкласса.

// // Правило 2
// // Вспомогательный инициализатор должен вызывать другой инициализатор из того же класса.

// // Правило 3
// // Вспомогательный инициализатор в конечном счете должен вызывать назначенный инициализатор.

// // Вот как можно просто это запомнить:
// // Назначенные инициализаторы должны делегировать наверх
// // Вспомогательные инициализаторы должны делегировать по своему уровню (классу).



// //Двухфазная инициализация

// Проверка 1. Назначенный инициализатор должен убедиться в том, что все 
//свойства представленные его классом инициализированы до того, как он делегирует наверх, в инициализатор суперкласса.
// Как было сказано выше, память для объекта считается полностью инициализированной только для полностью инициализированного объекта, 
//где все значения хранимых свойств известны. Для того чтобы удовлетворить этому правилу, назначенный инициализатор должен убедиться, 
//что все его собственные свойства инициализированы до того, как будут переданы вверх по цепочке.
// Проверка 2. Назначенный инициализатор должен делегировать суперклассу инициализатор до присваивания значений унаследованным свойствам. 
//Если этого сделано не будет, то новое значение, которое присвоит назначенный инициализатор будет переписано суперклассом, как часть инициализации суперкласса.
// Проверка 3. Вспомогательный инициализатор должен делегировать другому инициализатору до того, как будут присвоены значения любым свойствам 
//(включая свойства определенные тем же классом). Если этого сделано не будет, то новое значение, которое присваивает вспомогательный инициализатор, 
//будет перезаписано его собственным назначенным инициализатором класса.
// Проверка 4. Инициализатор не может вызывать методы экземпляра, читать значения любого свойства экземпляра или ссылаться на self как на значение до тех пор, 
//пока не будет закончена первая фаза инициализации.
// Экземпляр класса является не совсем корректным до тех пор, пока не закончится первая фаза. 
//К свойствам можно получить доступ и можно вызывать методы только тогда, как стало известно, что экземпляр валиден (корректен) к концу первой фазы.

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) колес(о)"
    }
}

let vehicle = Vehicle()
print("Транспортное средство \(vehicle.description)")
//Транспортное средство 0 колес(о)

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Велосипед: \(bicycle.description)")
//Велосипед: 2 колес(а)

// Назначенные и вспомогательные инициализаторы в действии

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Бекон")
//имя namedMeat является "Бекон"

let mysteryMeat = Food()
//mysteryMeat называется "[Unnamed]"

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)


class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6)
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
// 1 x Orange juice ✔
// 1 x Bacon ✘
// 6 x Eggs ✘

//Проваливаюшиеся инициализаторы

let wholeNumber: Double = 12345.0
let pi = 3.14159
 
if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) преобразование в Int поддерживает значение \(valueMaintained)")
}
// Выведет "12345.0 преобразование в Int поддерживает значение 12345"
 
let valueChanged = Int(exactly: pi)
// valueChanged is of type Int?, not Int
 
if valueChanged == nil {
    print("\(pi) преобразование в Int невозможно")
}
// Выведет "3.14159 преобразование в Int невозможно"

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Жираф")
// someCreature имеет тип Animal?, но не Animal
 
if let giraffe = someCreature {
 print("Мы инициализировали животное типа \(giraffe.species) ")
}
// Выведет "Мы инициализировали животное типа Жираф "

let anonymousCreature = Animal(species: "")
// someCreature имеет тип Animal?, но не Animal
 
if anonymousCreature == nil {
    print("Неизвестное животное не может быть инициализировано")
}
 
// Выведет "Неизвестное животное не может быть инициализировано"

//Проваливающиеся инициализаторы для перечислений

enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}


let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
  print("Эта единица измерения температуры определена, а значит наша инициализация прошла успешно!")
}
 
// Выведет "Эта единица измерения температуры определена, а значит наша инициализация прошла успешно!"
 
let unknownUnit = TemperatureUnit(symbol: "X")
if  unknownUnit == nil {
  print("Единица измерения температуры не определена, таким образом мы зафейлили инициализацию")
}
 
// Выведет "Единица измерения температуры не определена, таким образом мы зафейлили инициализацию"



//Проваливающиеся инициализаторы для перечислений с начальными значениями

//Перечисления с начальными значениями по умолчанию получают проваливающийся инициализатор init?(rawValue:), 
//который принимает параметр rawValue подходящего типа и выбирает соответствующий член перечисления,
//если он находит подходящий, или срабатывает сбой инициализации, если существующее значение не находит совпадения среди членов перечисления.

enum TemperatureUnit: Character {
  case kelvin = "K", celsius = "C", fahrenheit = "F"
}
 
let fahrenheitUnit = TemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil {
  print("Эта единица измерения температура определена, а значит наша инициализация прошла успешно!")
}
 
// Выведет "Эта единица измерения температура определена, а значит наша инициализация прошла успешно!"
 
let unknownUnit = TemperatureUnit(rawValue: "X")
if  unknownUnit == nil {
  print("Единица измерения температуры не определена, таким образом мы зафейлили инициализацию.")
}
 
// Выведет "Единица измерения температуры не определена, таким образом мы зафейлили инициализацию."




//Распространение проваливающегося инициализатора

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
 
class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}


//Если вы создаете экземпляр CartItem с name не равной пустой строке и quantity равному 1 или более, то инициализация проходит успешно:


if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// Выведет "Item: sock, quantity: 2"

//Если вы попытаетесь создать экземпляр CartItem с quantity со значением 0, то инициализация провалится:

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Невозможно инициализировать ноль футболок")
}
// Выведет "Невозможно инициализировать ноль футболок"

//Аналогично, если вы попытаетесь создать экземпляр CartItem с name равным пустой строке, то инициализатор суперкласса Product вызовет неудачу инициализации:
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Невозможно инициализировать товар без имени")
}
// Выведет "Невозможно инициализировать товар без имени"



//Переопределение проваливающегося инициализатора

//Вы можете переопределить проваливающийся инициализатор непроваливающимся инициализатором, но не наоборот.

class Document {
    var name: String?
    //этот инициализатор создает документ со значением nil свойства name
    init(){}
    //этот инициализатор создает документ с не пустым свойством name
    init?(name: String) {
      if name.isEmpty { return nil }
      self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

//AutomaticallyNamedDocument переопределяет проваливающийся инициализатор init?(name:) суперкласса непроваливающимся инициализатором init(name:). 


//Вы можете использовать принудительное извлечение внутри инициализатора для вызова проваливающегося инициализатора из суперкласса, в качестве части реализации непроваливающегося инициализатора подкласса. 
//Например, подкласс класса UntitledDocument всегда имеет имя "[Untitled]", и он использует проваливающийся init(name:) из суперкласса во время инициализации.
class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

//В этом случае инициализатор суперкласса init(name:) каждый раз будет вызывать ошибку исполнения, если в него будет передана пустая строка. 
//Однако, так как этот инициализатор теперь имеет строковую константу, то этот инициализатор больше не провалится, то есть ошибки исполнения больше не будет.


//Инициализатор init!

//Обычно вы определяете проваливающийся инициализатор, который создает опциональный экземпляр соответствующего типа путем размещения знака вопроса после ключевого слова init (init?). 
//Альтернативно, вы можете определить проваливающийся инициализатор, который создает экземпляр неявно извлекаемого опционала соответствующего типа. 
//Сделать это можно, если вместо вопросительного знака поставить восклицательный знак после ключевого слова init (init!).


//Вы можете делегировать от init? в init! и наоборот, а так же вы можете переопределить init? с помощью init! и наоборот. 
//Вы так же можете делегировать от init в init!, хотя, делая таким образом, мы заставим сработать утверждение, если init! провалит инициализацию.


//ребуемые инициализаторы

class SomeClass {
    required init() {
      //пишем тут реализацию инициализатора
    }
}

//Вы также должны писать модификатор required перед каждой реализацией требуемого инициализатора класса для индикации того, что последующий подкласс так же должен унаследовать этот инициализатор по цепочке. 
//Вы не пишите override, когда переопределяете требуемый инициализатор:


class SomeSubclass: SomeClass {
    required init() {
      //пишем тут реализацию инициализатора подкласса
    }
}


//Начальное значение свойства в виде функции или замыкания

class SomeClass {
    let someProperty: SomeType = {
      // создаем начальное значения для SomeProperty внутри этого замыкания
      // someValue должен быть того же типа, что и SomeType
      return someValue
    }()
} 

//Обратите внимание, что после закрывающей фигурной скобки замыкания идут пустая пара круглых скобок. 
//Это означает, что нужно исполнить это замыкание немедленно. 
//Если вы пропустите эти скобки, то вы присваиваете само значение замыкания свойству, а не возвращаете значения замыкания.


struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
// Выведет "true"
print(board.squareIsBlackAt(row: 7, column: 7))
// Выведет "false"























