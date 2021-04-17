//Functions

func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print(greet(person: "Anna"))
// Выведет "Hello, Anna!"
print(greet(person: "Brian"))
// Выведет "Hello, Brian!"


//упрощенная запись
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
// Выведет "Hello again, Anna!"


//функция без параметров 
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// Выведет "hello, world"


//функции с несколькими параметрами
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))
// Выведет "Hello again, Tim!"


//функция которая не возвращает значение
func greet(person: String) {
    print("Hello, \(person)!")
}
greet(person: "Dave")
// Выведет "Hello, Dave!"

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// Выведет "hello, world" и возвращает значение 12
printWithoutCounting(string: "hello, world")
// Выведет "hello, world", но не возвращает значения

//функции возвращающие несколько значений
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// Выведет "min is -6 and max is 109"

func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}


if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
// Выведет "min is -6 and max is 109"


//ярлыки аргументов
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // Внутри тела функции firstParameterName и secondParameterName
    // ссылаются на значения аргументов, первого и второго параметров.
}
someFunction(firstParameterName: 1, secondParameterName: 2)



func someFunction(argumentLabel parameterName: Int) {
    // В теле функции parameterName относится к значению аргумента
    // для этого параметра.
}

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
// Выводит "Hello Bill!  Glad you could visit from Cupertino."

//пропуск ярлыка аргументов

func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // В теле функции firstParameterName и secondParameterName
    // ссылаются на значения аргументов для первого и второго параметров.
}
someFunction(1, secondParameterName: 2)


//значение по умолчанию

func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // Если вы пропускаете второй аргумент при вызове функции, то
    // значение parameterWithDefault будет равняться 12 внутри тела функции.
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault равен 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault равен 12



//Вариативные параметры

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// возвращает 3.0, что является средним арифметическим этих пяти чисел
arithmeticMean(3, 8.25, 18.75)
// возвращает 10.0, что является средним арифметическим этих трех чисел
// У функции может быть только один вариативный параметр.


//сквозные параметры
//Сквозные параметры не могут иметь значения по умолчанию, а вариативные параметры не могут быть сквозными, с ключевым словом inout.

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Выведет "someInt is now 107, and anotherInt is now 3"

//Сквозные параметры – это не то же самое, что возвращаемые функцией значения. В примере с функцией swapTwoInts нет ни возвращаемого типа, ни возвращаемого значения, но параметры someInt и anotherInt все равно изменяются. Сквозные параметры – это альтернативный способ передачи изменений, сделанных внутри функции, за пределы тела этой функции.


//функциональные типы

func addTwoInts(a: Int, _ b: Int) -> Int {
  return a + b
}
func multiplyTwoInts(a: Int, _ b: Int) -> Int {
  return a * b
}


var mathFunction: (Int, Int) -> Int = addTwoInts

print("Result: \(mathFunction(2, 3))")
// Выведет "Result: 5"

mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")
// Выведет "Result: 6"

let anotherMathFunction = addTwoInts
// для константы anotherMathFunction выведен тип (Int, Int) -> Int


func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Выведет "Result: 8"




func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}



var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero ссылается на функцию stepBackward()


print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!


//Вложенные функции

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero теперь ссылается на вложенную функцию stepForward() 
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!

