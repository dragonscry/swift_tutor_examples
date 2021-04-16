//Циклы

//for in цикл для перебора по коллекциям или диапазонам

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
// Hello, Anna!
// Hello, Alex!
// Hello, Brian!
// Hello, Jack!


let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
// ants have 6 legs
// cats have 4 legs
// spiders have 8 legs

for index in 1...5 {
    print("\(index) умножить на 5 будет \(index * 5)")
}
// 1 умножить на 5 будет 5
// 2 умножить на 5 будет 10
// 3 умножить на 5 будет 15
// 4 умножить на 5 будет 20
// 5 умножить на 5 будет 25


//если не нужно значение переменной можно просто поставить нижнее подчеркивание
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) в степени \(power) равно \(answer)")
// Выведет "3 в степени 10 равно 59049"

let minutes = 60
for tickMark in 0..<minutes {
    // render the tick mark each minute (60 times)
}

//чтобы пропустить интервалы
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
}

let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // render the tick mark every 3 hours (3, 6, 9, 12)
}

//while цикл

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare {
  // бросок кубика
  diceRoll += 1
  if diceRoll == 7 { diceRoll = 1 }
  // начать ходить на выпавшее количество шагов
  square += diceRoll
  if square < board.count {
    // если мы все еще на поле, идти вверх или вниз по змеям или лестницам
    square += board[square]
  }
}
print("Game over!")
// с помощью цикла идет игра лестницы и змеи

//Инструкция if & switch 

var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
     print ("It's very cold. Consider wearing a scarf.")
}
// Выведет "It's very cold. Consider wearing a scarf.


temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// Выведет "It's not that cold. Wear a t-shirt."

temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// Выведет "It's really warm. Don't forget to wear sunscreen.


//else необязательный
temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}


//switch
switch значение для сопоставления {
     case значение 1: 
          инструкция для значения 1
     case значение 2, значение 3:
          инструкция для значения 2 или значения 3
     default: 
          инструкция, если совпадений с шаблонами не найдено
}

et someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}
// Выведет "The last letter of the alphabet"


let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a":  // ошибка, так как кейс имеет пустое тело
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// ошибка компиляции


let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// Выведет "The letter A"


//диапазоны в свич

let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// Выводит "There are dozens of moons orbiting Saturn."


//кортежи в свич
et somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// Выведет "(1, 1) is inside the box"

//связывание значения
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// Выведет "on the x-axis with an x value of 2


//where в switch инструкции
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// Выведет "(1, -1) is on the line x == -y"

//составные случаи
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}
// Напечатает "e is a vowel"


let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
// Напечатает "On an axis, 9 from the origin"

//оператор continue

//Оператор continue говорит циклу прекратить текущую итерацию и начать новую. Он как бы говорит: "Я закончил с текущей итерацией", но полностью из цикла не выходит.
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    } else {
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)
// Выведет "grtmndsthnklk"

//оператор break

//Оператор break останавливает выполнение всей инструкции управления потоком. Оператор break может быть использован внутри инструкции switch или внутри цикла, когда вы хотите остановить дальнейшее выполнение switch или цикла раньше, чем он должен закончиться сам по себе.

let numberSymbol: Character = "三"  // Цифра 3 в упрощенном Китайском языке
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}
// Выведет "The integer value of 三 is 3."

//оператор fallthrough

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
// Выведет "The number 5 is a prime number, and also an integer."


//маркированные инструкции

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        //после броска кубика мы попадаем на клетку 25, игра окончена
        break gameLoop
    case let newSquare where newSquare > finalSquare:
         //мы кинули кубик на слишком большое значение, значит нам нужно кинуть снова
        continue gameLoop
    default:
        //допустимое движение по игровому полю, двигаемся
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")

имя маркера : while условие {
     исполняемый код
}

//Если оператор break не использует маркер gameLoop, то он будет прерывать выполнение инструкции switch, а не всего цикла while. Но используя маркер gameLoop мы можем указать какое исполнение инструкции нужно прервать.


//ранний выход
func greet(person: [String: String]) {
  guard let name = person["name"] else {
    return
  }
  
  print("Привет \(name)!")
  
  guard let location = person["location"] else {
    print("Надеюсь у тебя там хорошая погода.")
    return
  }
  
  print("Надеюсь в \(location) хорошая погода.")
}

greet(person: ["name": "John"])
// Выведет "Привет John!"
// Выведет "Надеюсь у тебя там хорошая погода."
greet(person: ["name": "Jane", "location": "Cupertino"])
// Выведет "Привет Jane!"
// Выведет "Надеюсь в Cupertino хорошая погода.”


//доступность api

if #available (название платформы версия платформы, ..., * ) {
выражения для исполнения, если соответствующие условию API доступны
} else {
выражения для исполнения, если соответствующие условию API не доступны
}

if #available(iOS 10, macOS 10.12, *) {
    // Используйте API iOS 10 для iOS и используйте API macOS 10.12 на macOS
} else {
    // Используйте более старые API для iOS и macOS
}