//классы и структуры

class SomeClass {
    // здесь пишется определение класса
}
struct SomeStructure {
    // здесь пишется определение структуры
}

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//обьявление экземпляра структуры
let someResolution = Resolution()
let someVideoMode = VideoMode()

//доступ к свойствам черех точечный индекс
print("The width of someResolution is \(someResolution.width)")
// Выведет "The width of someResolution is 0"

print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// Выведет "The width of someVideoMode is 0"


//изменение свойства
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
// Выведет "The width of someVideoMode is now 1280"

//поэлементные инициализаторы для структур
let vga = Resolution(width: 640, height: 480)


//структуры и перечисления - значимые типы

//при обьявлении переменной другой структуре - структура копируется и создает новый экземпляра
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

 cinema.width = 2048
 print("cinema is now \(cinema.width) pixels wide")
// Выведет "cinema is now 2048 pixels wide"

print("hd is still \(hd.width) pixels wide")
// Выведет "hd is still 1920 pixels wide"

enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("Текущее направление - \(currentDirection)")
// Выведет "Текущее направление - north"

//Когда мы присваиваем rememberedDirection значение currentDirection, мы фактически копируем это значение.


//Классы - ссылочный тип

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

//В отличие от типа значений, ссылочный тип не копируется, когда его присваивают переменной или константе, или когда его передают функции. 

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Выведет "The frameRate property of tenEighty is now 30.0"

//Операторы тожественности

Идентичен (===)
Не идентичен ( !== )

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// Выведет "tenEighty and alsoTenEighty refer to the same VideoMode instance."