//Универсальные шаблоны

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

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}
 
func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//Во всех трех функциях есть важный момент того, что типы a и b должны быть одинаковыми по отношению друг к другу. Если a и b не являются значениями одного типа, то будет невозможно поменять их значения местами. 
//Swift является типо-безопасным языком и не позволяет (например) переменным с типом String меняться значениями с типом Double. Попытка сделать это приведет к ошибке компиляции.


//Универсальные функции

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoInts(_ a: inout Int, _ b: inout Int){}
func swapTwoValues<T>(_ a: inout T, _ b: inout T){}

//Универсальная версия использует заполнитель имени типа (называется T в нашем случае) вместо текущего имени типа (Int, String, Double…)

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
// someInt равен 107, а anotherInt равен 3
 
var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString равна "world", а anotherString равна "hello"

//Указанная выше функция swapTwoValues(_:_:) появилась под влиянием функции, называемой swap, которая является частью стандартной бибилиотеки Swift и предоставляется для использования в ваших приложениях. 
//Если вам требуется поведение функции swapTwoValues(_:_:) в вашем коде, вы можете использовать существующую в Swift функцию swap(_:_:), а не писать свою собственную реализацию.


//Всегда давайте параметрам типа имена "горбатого" верхнего регистра (например, T и MyTypeParameter), чтобы указать, что они являются заполнителем для типа, а не значением.

//Вот как написать неуниверсальную версию стека, в этом случае мы используем стек для хранения Int значений:

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//Вот универсальная версия структуры:
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// stack содержит 4 строки

let fromTheTop = stackOfStrings.pop()
// fromTheTop равен "cuatro", а stack содержит 3 строки

//Расширяем универсальный тип

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
// Выведет "The top item on the stack is tres."

//Cинтаксис ограничения типа

func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // тело функции…
}

//Выше описанная гипотетическая функция имеет два параметра типа. Первый параметр типа - T, имеет ограничение типа, которое требует чтобы T, было подклассом класса SomeClass. 
//Второй параметр типа - U, имеет ограничение типа, которое требует чтобы U соответствовал протоколу SomeProtocol.

//Ограничение типа в действии

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
// Выведет "The index of llama is 2"

//универсальная функция 

func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

//функция не будет компилироваться

//А вот теперь будет 
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex опциональный Int не имеющий значения, потому что значения 9.3 нет в массиве
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex опциональный Int равный 2

//Связанные типы

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//Протокол Container определяет три требуемых возможности, которые должен иметь любой контейнер:
//Должна быть возможность добавлять новый элемент в контейнер при помощи метода append(_:).
//Должна быть возможность получить доступ к количеству элементов в контейнере через свойство count, которое возвращает значение типа Int.
//Должна быть возможность получить значение через индекс элемента, который принимает значение типа Int.


//структура для Int
struct IntStack: Container {
    // исходная реализация IntStack
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // удовлетворение требований протокола Container
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


//универсальная структура

struct Stack<Element>: Container {
    // исходная реализация Stack<Element>
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // удовлетворение требований протокола Container
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//Вы можете добавить ограничение к связанному типу в протоколе, чтобы требовать, чтобы соответствующие типы удовлетворяли этим ограничениям.

protocol Container {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//Протокол может выступать как часть собственных требований. Например, ниже в примере, есть протокол, который уточняет протокол Container, 
//добавляя метод suffix(_:). Метод suffix(_:) возвращает заданное количество элементов из конца контейнера, сохраняя их в экземпляре типа Suffix.

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

//Ниже расширение типа Stack, которое добавляет соответствие протоколу SuffixableContainer:

extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Определено, что Suffix является Stack.
}
var stackOfInts = Stack()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)
// suffix содержит 20 и 30


//Оговорка where

//Контейнеры не должны быть одного типа для того чтобы их проверить, хотя они и могут, но они должны содержать элементы одного и того же типа. 
//Это требование выражается через комбинацию ограничений типа и оговоркой where:

func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
        
        // Проверяем одинаковое ли количество элементов находится в контейнерах.
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // Проверяем все ли значения попарно равны.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // Все элементы совпадают, так что возвращаем true.
        return true
}

//Вот как выглядит функция allItemsMatch(_:_:) в действии:
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
 
var arrayOfStrings = ["uno", "dos", "tres"]
 
if allItemsMatch(stackOfStrings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
// Выведет "All items match."



//Расширения с оговоркой where

extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

//Новый метод isTop(_:) сначала проверяет, что наш стек не пустой, а затем сравнивает верхний элемент стека с данным нам item. 
//Если вы попытаетесь сделать то же самое без универсальной where, то у вас будут проблемы. 


//Вот как будет выглядеть наш метод isTop(_:) в действии:
if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}
// Выведет "Top element is tres."

//Если вы попытаетесь вызвать метод isTop(_:) в стеке, то те, элементы, которые не реализуют протокол Equatable вызовут ошибку компиляции:
struct NotEquatable { }
var notEquatableStack = Stack<NotEquatable>()
let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
notEquatableStack.isTop(notEquatableValue)  // Error

//Вы можете использовать универсальную where с расширениями протоколов. Пример ниже расширяет протокол Container из прошлого примера, добавляя ему новый метод startsWith(_:).

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}
// Выведет "Starts with something else."

//Универсальная оговорка where в примере выше требует, чтобы Item соответствовал протоколу Container, 
//но вы так же можете использовать where для указания конкретного типа для Item. Например:

extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
print([1260.0, 1200.0, 98.6, 37.0].average())
// Выведет "648.9"



//Контекстуальная оговорка Where

extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}
let numbers = [1260, 1200, 98, 37]
print(numbers.average())
// Выведет "648.75"
print(numbers.endsWith(37))
// Выведет "true"
print(numbers.endsWith(37))
// Выведет "true"

//В этом примере мы добавляем методы average() в структуру Container, когда элементы имеют целочисленный тип, 
//а так же мы добавляем метод endsWith(_:), если элементы соответствуют протоколу Equatable. 

//Если вы хотите написать этот код без контекстуальной оговорки where, 
//вам нужно написать два расширения, по одному для каждой оговорки where. 

extension Container where Item == Int {
    func average() -> Double {
        var sum = 0.0
        for index in 0..< count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
}
extension Container where Item: Equatable {
    func endsWith(_ item: Item) -> Bool {
        return count >= 1 && self[count-1] == item
    }
}

//Связанные типы с универсальной оговоркой where

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

protocol ComparableContainer: Container where Item: Comparable { }

//Универсальные сабскрипты

extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}





























