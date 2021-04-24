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







































