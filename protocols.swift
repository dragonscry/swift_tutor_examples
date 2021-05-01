// Протоколы

protocol SomeProtocol {
    // определение протокола…
}

//Пользовательские типы утверждают, что они принимают протокол, когда они помещают 
//имя протокола после имени типа и разделяются с этим именем двоеточием, то есть указывают эти протоколы как часть их определения. 

struct SomeStructure: FirstProtocol, AnotherProtocol {
    // определение структуры…
}

//Если у класса есть суперкласс, то вписывайте имя суперкласса до списка протоколов, которые он принимает, также разделите имя суперкласса и имя протокола запятой:

class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // определение класса…
}

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

//Пример протокола с единственным требуемым свойством экземпляра:
protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
// john.fullName равен "John Appleseed"

