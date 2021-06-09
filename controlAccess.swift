//Контроль доступа

//Различные аспекты вашего кода, к которым применим контроль уровня доступа (свойства, типы, функции и т.д.) 
//будем называть “сущности”, для краткости.

//Swift предлагает пять различных уровней доступа для объектов вашего кода. Эти уровни доступа относительны исходному файлу

//Открытый доступ и публичный доступ (open access и public access). Этот уровень доступа позволяет использовать объекты внутри любого исходного файла из определяющего их модуля 
//и так же в любом исходном файле из другого модуля, который импортирует определяющий модуль.

//Внутренний (internal access). Этот уровень доступа позволяет использовать объекты внутри любого исходного файла из их определяющего модуля, 
//но не исходного файла не из этого модуля. 

//Файл-частный (file private). Этот уровень доступа позволяет использовать объект в пределах его исходного файла. 

//Частный (private). Этот уровень доступа позволяет использовать сущность только в пределах области ее реализации. 

//Уровни доступа в Swift следуют общему руководящему принципу: никакой объект не может быть определен в пределах другого объекта, который имеет более низкий (более строгий) уровень доступа

//Все сущности вашего кода (кроме двух исключений, о которых мы поговорим чуточку позже) имеют дефолтный уровень доступа - внутренний (internal), если вы явно не указываете другой уровень.

//Синтаксис контроля доступа

public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}
 
public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

//Если вы не укажете уровень доступа, то он будет internal по умолчанию

class SomeInternalClass {}              // неявно internal
let someInternalConstant = 0            // неявно internal

//Пользовательские типы

//Если вы хотите указать явно уровень доступа для пользовательского типа, то делайте это на этапе определения типа. 

public class SomePublicClass {                  // явный public класс
    public var somePublicProperty = 0            // явный public член класса
    var someInternalProperty = 0                 // неявный internal член класса
    fileprivate func someFilePrivateMethod() {}  // явный file-private член класса
    private func somePrivateMethod() {}          // явный private член класса
}
 
class SomeInternalClass {                       // неявный internal класс
    var someInternalProperty = 0                 // неявный internal член класса
    fileprivate func someFilePrivateMethod() {}  // явный file-private член класса
    private func somePrivateMethod() {}          // явный private член класса
}
 
fileprivate class SomeFilePrivateClass {        // явный file-private класс
    func someFilePrivateMethod() {}              // неявный file-private член класса
    private func somePrivateMethod() {}          // явный private член класса
}
 
private class SomePrivateClass {                // явный private класс
    func somePrivateMethod() {}                  // неявный private член класса
}


//Кортежи типов

//если вы скомпонуете кортеж из двух разных типов, один из которых будет иметь уровень доступа как internal, другой как private, то кортеж будет иметь уровень доступа как private.

//Кортежи типов не имеют отдельного определения в отличии от классов, структур, перечислений или функций. Уровень доступа кортежей типов вычисляется автоматически, когда используется кортеж, и не может быть указан явно.

//Типы функций

//Уровень доступа для типов функции вычисляется как самый строгий уровень доступа из типов параметров функции и типа возвращаемого значения. 

func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // реализация функции…
}

private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // реализация функции…
}

//Это неправильно ставить маркер уровня доступа функции someFunction как public или internal, или использовать уровень доступа по умолчанию, потому что пользователи функции с уровнем доступа public или internal не смогут получить соответствующий доступ к private классу


//Типы перечислений

public enum CompassPoint {
    case north
    case south
    case east
    case west
}
//В примере ниже перечисление CompassPoint имеет явный уровень доступа public. Случаи перечисления north, south, east и west так же получают такой же уровень доступа, то есть public


//Уровень доступа класса и подкласса

public class A {
    fileprivate func someMethod() {}
}
 
internal class B: A {
    override internal func someMethod() {}
}

public class A {
    fileprivate func someMethod() {}
}
 
internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

//Константы, переменные, свойства и сабскрипт

private var privateInstance = SomePrivateClass()

//Если константа, переменная, свойство или сабскрипт используют тип private, то они должны быть отмечены ключевым словом private

//Геттеры и сеттеры

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("Количество изменений равно \(stringToEdit.numberOfEdits)")
// Выведет "Количество изменений равно 3"

public struct TrackedString {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}


//Private свойства и методы в расширениях

protocol SomeProtocol {
    func doSomething()
}

//Вы можете использовать расширение, чтобы реализовать требование протокола:

struct SomeStruct {
    private var privateVariable = 12
}
 
extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}




































