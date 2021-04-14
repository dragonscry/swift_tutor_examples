//Типы коллекций

//Массивы
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")
// Выведет "someInts is of type [Int] with 0 items."

omeInts.append(3)
// массив someInts теперь содержит одно значение типа Int
someInts = []
// массив someInts теперь пуст, но все равно имеет тип [Int]

var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles имеет тип [Double] и равен [0.0, 0.0, 0.0]

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles имеет тип [Double] и равен [2.5, 2.5, 2.5]
 
var sixDoubles = threeDoubles + anotherThreeDoubles
// тип sixDoubles выведен как [Double] и равен [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]

var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList был инициализирован с двумя элементами

print("The shopping list contains \(shoppingList.count) items.")
// Выведет "The shopping list contains 2 items."

if shoppingList.isEmpty {
print("The shopping list is empty.")
} else {
print("The shopping list is not empty.")
}
// Выведет "The shopping list is not empty."

shoppingList.append("Flour")
​// shoppingList теперь содержит 3 элемента, а кое-кто делает блины

shoppingList += ["Baking Powder"]
​// shoppingList теперь хранит 4 элемента
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
​// shoppingList теперь хранит 7 элементов

var firstItem = shoppingList[0]
// firstItem равен "Eggs"

shoppingList[0] = "Six eggs"
​// первый элемент в списке теперь равен "Six eggs", а не "Eggs"

shoppingList[4...6] = ["Bananas", "Apples"]
​// shoppingList теперь содержит 6 элементов

shoppingList.insert("Maple Syrup", at: 0)
​// shoppingList теперь содержит 7 элементов
​// "Maple Syrup" теперь первый элемент списка

let mapleSyrup = shoppingList.remove(at: 0)
​// элемент который имел индекс 0 был удален
// shoppingList теперь содержит 6 элементов, и нет Maple Syrup
​// константа mapleSyrup теперь равна удаленной строке "Maple Syrup"

let​ ​apples​ = ​shoppingList​.​removeLast​()
// последний элемент массива был удален
// shoppingList теперь содержит 5 элементов, и нет яблок
// константа apples теперь равна удаленной строке "Apples"


//Итерация по массиву

for item in shoppingList {
  print(item)
}
// Six eggs
// Milk
// Flour
// Baking Powder
// Bananas

//Чтобы вывести и значение и индекс
for (index, value) in shoppingList.enumerated() {
  print("Item \(index + 1): \(value)")
}
// Item 1: Six eggs
// Item 2: Milk
// Item 3: Flour
// Item 4: Baking Powder
// Item 5: Bananas


//Множества Set

var letters = Set<Character>()
print("letters имеет тип Set<Character> с \(letters.count) элементами.")
// Выведет "letters имеет тип Set<Character> с 0 элементами."

letters.insert("a")
// letters теперь содержит 1 элемент типа Character
letters = []
// letters теперь является пустым множеством, но все еще имеет тип Set<Character>

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
// favoriteGenres был инициализирован при помощи трех начальных элементов

var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
// краткая запись без обозначения типа Множества

print("У меня есть \(favoriteGenres.count) любимых музыкальных жанра.")
// Выведет "У меня есть 3 любимых музыкальных жанра."

if favoriteGenres.isEmpty {
    print("Мне все равно какая музыка играет. Я не придирчив.")
} else {
    print("У меня есть свои музыкальные предпочтения.")
}
// Выведет "У меня есть свои музыкальные предпочтения."

favoriteGenres.insert("Jazz")
// теперь в favoriteGenres находится 4 элемента

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? С меня хватит.")
} else {
    print("Меня это не сильно заботит.")
}
// Выведет "Rock? С меня хватит."

if favoriteGenres.contains("Funk") {
    print("О! Да я встал с правильной ноги!")
} else {
    print("Слишком много Funk'а тут.")
}
// Выведет "Слишком много Funk'а тут."

//итерация по множеству
for genre in favoriteGenres {
    print("\(genre)")
}
// Classical
// Jazz
// Hip hop

//итерация по сортированному множеству
for genre in favoriteGenres.sorted() {
    print("\(genre)")
}
// Classical
// Hip hop
// Jazz


//Базовоые операции с множествами
// Используйте метод union (_:) для создания нового множества состоящего из всех значений обоих множеств.
// Используйте метод intersection(_:) для создания нового множества из общих значений двух входных множеств.
// Используйте метод subtracting (_:) для создания множества со значениями не принадлежащих указанному множеству из двух входных.
// Используйте метод symmetricDifference(_:) для создания нового множества из значений, которые не повторяются в двух входных множествах.

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
 
oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]


// Используйте оператор равенства (==) для определения все ли значения двух множеств одинаковы.
// Используйте метод isSubset(of:) для определения все ли значения множества содержатся в указанном множестве.
// Используйте метод isSuperset(of:), чтобы определить содержит ли множество все значения указанного множества.
// Используйте методы isStrictSubset(of:) или isStrictSuperset(of:) для определения является ли множество подмножеством или надмножеством, но не равным указанному сету.
// Используйте метод isDisjoint(with:) для определения того, отсутствуют ли общие значения в двух множествах или нет.

let houseAnimals: Set = ["собака", "кошка"]
let farmAnimals: Set = ["корова", "курица", "баран", "собака", "кошка"]
let cityAnimals: Set = ["ворона", "мышь"]
 
houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true

//Пустые словари

var namesOfIntegers = [Int: String]()
// namesOfIntegers является пустым [Int: String] словарем

namesOfIntegers[16] = "sixteen"
// namesOfIntegers теперь содержит 1 пару ключ-значение
namesOfIntegers = [:]
// namesOfIntegers теперь опять пустой словарь с типом [Int: String]

//обьявление словаря сразу с значениями
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

print("The airports dictionary contains \(airports.count) items.")
// Выведет "The airports dictionary contains 2 items."


if airports.isEmpty {
  print("The airports dictionary is empty.")
} else {
  print("The airports dictionary is not empty.")
}
// Выведет "The airports dictionary is not empty."

airports["LHR"] = "London"
// словарь airports теперь содержит 3 элемента

airports["LHR"] = "London Heathrow"
// значение для "LHR" поменялось на "London Heathrow"

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
  print("The old value for DUB was \(oldValue).")
}
// Выведет "The old value for DUB was Dublin."

if let airportName = airports["DUB"] {
  print("The name of the airport is \(airportName).")
} else {
  print("That airport is not in the airports dictionary.")
}
// Выведет "The name of the airport is Dublin Airport."

airports["APL"] = "Apple International"
// "Apple International" несуществующий аэропорт для APL, так что удалим его
airports["APL"] = nil
// APL теперь был удален из словаря


if let removedValue = airports.removeValue(forKey: "DUB") {
  print("The removed airport's name is \(removedValue).")
} else {
  print("The airports dictionary does not contain a value for DUB.")
}
// Выведет "The removed airport's name is Dublin Airport."

//Итерация по словарю

for (airportCode, airportName) in airports {
  print("\(airportCode): \(airportName)")
}
// LHR: London Heathrow
// YYZ: Toronto Pearson

for airportCode in airports.keys {
  print("Airport code: \(airportCode)")
}
// Airport code: LHR
// Airport code: YYZ

for airportName in airports.values {
  print("Airport name: \(airportName)")
}
// Airport name: London Heathrow
// Airport name: Toronto Pearson

let airportCodes = [String](airports.keys)
// airportCodes теперь ["YYZ", "LHR"]

let airportNames = [String](airports.values)
// airportNames теперь ["Toronto Pearson", "London Heathrow"]




