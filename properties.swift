//Свойства

//Вычисляемые свойства обеспечиваются классами, структурами или перечислениями. 
//Свойства хранения обеспечиваются только классами или структурами.

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// диапазон чисел 0, 1, 2
rangeOfThreeItems.firstValue = 6
// сейчас диапазон чисел 6, 7, 8


//Если вы создаете экземпляр структуры и присваиваете его константе, то вы не можете изменять его свойства, даже если они объявлены как переменные

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// теперь диапазон чисел выглядит как  0, 1, 2, 3
rangeOfFourItems.firstValue = 6
// это вызовет ошибку, даже несмотря на то, что firstValue переменная

//Когда экземпляр типа значений отмечен как константа, то все его свойства так же считаются константами.

//Такое поведение не применимо к классам, так как они являются ссылочным типом

//Ленивые свойства
class DataImporter {
    /*  
     DataImporter - класс для импорта данных с внешних источников
     Считаем, что классу требуется большое количество времени для инициализации
     */
    var fileName = "data.txt"
    // класс DataImporter функционал данных будет описан тут
}
 
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // класс DataManager обеспечит необходимую функциональность тут
}
 
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// экземпляр класса DataImporter для свойства importer еще не создано

print(manager.importer.fileName)
// экземпляр DataImporter для свойства importer только что был создан
// Выведет "data.txt"


//Вычисляемые свойства

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Выведет "square.origin is now at (10.0, 10.0)"


//Сокращенный сеттер
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}



//вычисляемое свойство только для чтения

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Выведет "the volume of fourByFiveByTwo is 40.0"



//Наблюдатели свойства
willSet вызывается прямо перед сохранением значения
didSet вызывается сразу после сохранения значения

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("Вот-вот значение будет равно \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Добавлено \(totalSteps - oldValue) шагов")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// Вот-вот значение будет равно 200
// Добавлено 200 шагов
stepCounter.totalSteps = 360
// Вот-вот значение будет равно 360
// Добавлено 160 шагов
stepCounter.totalSteps = 896
// Вот-вот значение будет равно 896
// Добавлено 536 шагов


//Свойства типа

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overridableComputedTypeProperty: Int {
        return 107
    }
}
//Чтобы объявить свойства типа, используйте ключевое слово static . 
//Для вычисляемых свойств самого класса, вы должны использовать ключевое слово class, чтобы разрешать подклассам переопределение инструкций суперкласса.


print(SomeStructure.storedTypeProperty)
// Выведет "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Выведет "Another value."
print(SomeEnumeration.computedTypeProperty)
// Выведет "6"
print(SomeClass.computedTypeProperty)
// Выведет "27"


struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // ограничиваем уровень звука максимально допустимым уровнем 
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // храним значение в качестве максимального уровня 
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}


var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

eftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// Выведет "7"
print(AudioChannel.maxInputLevelForAllChannels)
// Выведет "7"

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// Выведет "10"
print(AudioChannel.maxInputLevelForAllChannels)
// Выведет "10"



