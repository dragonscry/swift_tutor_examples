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
















































