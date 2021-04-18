//Замыкания

//sorted(by:)

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
   return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames равен ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

Синтаксис замыкающего выражения имеет следующую общую форму:
{ (параметры) -> тип результата in
выражения
}

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
   return s1 > s2
})

//короткие замыкания пишутся в одну строчку
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })

//можно опустить так как параметр sorted ожидает функцию
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 })

//можно опустить ключевое слово возвращения результата
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 })

//сокращенные имена параметров
reversedNames = names.sorted(by: { $0 > $1 })

//или вообще так
reversedNames = names.sorted(by: >)


//последующее замыкание
func someFunctionThatTakesAClosure(closure: () -> Void) {
   // тело функции
}
 
// Вот как вы вызываете эту функцию без использования последующего замыкания:
 
someFunctionThatTakesAClosure(closure: {
   // тело замыкания
})
 
// Вот как вы вызываете эту функцию с использованием последующего замыкания:
 
someFunctionThatTakesAClosure() {
   // тело последующего замыкания
}


reversedNames = names.sorted() { $0 > $1 }

reversedNames = names.sorted { $0 > $1 }

//изменение массива с помощью map
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

//тип строк был выведен как [String]
//значения ["OneSix", "FiveEight", "FiveOneZero"]


//Если функция принимает несколько последующих замыканий, вы можете пропустить ярлык параметра для первого из них, а для остальных уже указать нужно. 
func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
    if let picture = download("photo.jpg", from: server) {
        completion(picture)
    } else {
        onFailure()
    }
}


loadPicture(from: someServer) { picture in
    someView.currentPicture = picture
} onFailure: {
    print("Couldn't download the next picture.")
}



//захват значений
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
   var runningTotal = 0
   func incrementer() -> Int {
      runningTotal += amount
      return runningTotal
   }
   return incrementer
}


//функция в действии

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
// возвращает 10
incrementByTen()
// возвращает 20
incrementByTen()
// возвращает 30


let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
//возвращает значение 7

incrementByTen()
//возвращает 40

//функции и замыкания являются ссылочными типами.

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
//возвращает 50

incrementByTen()
//возвращает 60

//сбегающие замыкания

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
  completionHandlers.append(completionHandler)
}


//замыкание ссылющееся на self
//осторожно, если сделать сбегающее замыкание с сылкой на self - может появится зацикленность сильных сылок

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
 
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}
 
let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Выведет "200"
 
completionHandlers.first?()
print(instance.x)
// Выведет "100"


class SomeOtherClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

//Если self является экземпляром структуры или перечисления, то вы можете всегда ссылаться на self неявно

struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }  // Ok
        someFunctionWithEscapingClosure { x = 100 }     // Error
    }
}


//автозамыкания

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Выведет "5"
 
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Выведет "5"
 
print("Now serving \(customerProvider())!")
// Выведет "Now serving Chris!"
print(customersInLine.count)
// Выведет "4"

// customersInLine равен ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Выведет "Now serving Alex!"


// customersInLine равен ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Выведет "Now serving Ewa!"

// customersInLine равен ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))
 
print("Collected \(customerProviders.count) closures.")
// Выведет "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Выведет "Now serving Barry!"
// Выведет "Now serving Daniella!"

