//Автоматический подсчет ссылок

//Приведем пример того, как работает ARC. Наш пример начнем с класса Person, который определяет константное свойство name:

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) инициализируется")
    }
    deinit {
        print("\(name) деинициализируется")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

//Так как эти переменные опционального типа (Person?, а не Person), 
//они автоматически инициализируются со значением nil, и не имеют никаких ссылок на экземпляр Person.

reference1 = Person(name: "John Appleseed")
// Выведет "John Appleseed инициализируется"

//Так как новый экземпляр класса Person был присвоен переменной reference1, 
//значит теперь существует сильная ссылка между reference1 и новым экземпляром класса Person.

reference2 = reference1
reference3 = reference1

//Теперь экземпляр класса Person имеет три сильные ссылки.

//Если вы сломаете две из этих трех ссылок (включая и первоначальную ссылку), 
//присвоив nil двум переменным, то останется одна сильная ссылка, и экземпляр Person не будет освобожден:

reference1 = nil
reference2 = nil

//ARC не освободит экземпляр класса Person до тех пор, пока остается последняя сильная ссылка, уничтожив которую мы укажем на то, что наш экземпляр больше не используется:
reference3 = nil
// Выведет "John Appleseed деинициализируется"

//Ниже приведен пример того, как сильный ссылочный цикл может быть создан по ошибке. 
//В этом примере мы определяем два класса Person и Apartment, которые создают модель блока квартир с их жителями:

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) освобождается") }
}
 
class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Апартаменты \(unit) освобождаются") }
}

var john: Person?
var unit4A: Apartment?

//Теперь вы можете создать свои экземпляры Person и Apartment и присвоить их этим переменным john, unit4A:
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

//К сожалению, соединяя таким образом, образуется цикл сильных ссылок между экземплярами. Экземпляр Person имеет сильную ссылку на экземпляр Apartment, экземпляр Apartment имеет сильную ссылку на экземпляр Person. 
//Таким образом, когда вы разрушаете сильные ссылки, принадлежащие переменным john и unit4A, их количество все равно не падает до нуля, и экземпляры не освобождаются:

john = nil
unit4A = nil

//Обратите внимание, что ни один деинициализатор не был вызван, когда вы присваивали nil. 

//Слабые (weak) ссылки


//Когда ARC устанавливает слабую ссылку на nil, наблюдатели свойств не вызываются.

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) деинициализируется") }
}
 
class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) деинициализируется") }
}

var john: Person?
var unit4A: Apartment?
 
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
 
john!.apartment = unit4A
unit4A!.tenant = john

john = nil
// Выведет "John Appleseed деинициализируется"

unit4A = nil
// выводит "Апартаменты 4A деинициализируется"

//Там, где используются сборщики "мусора", слабые указатели иногда используются для реализации простого механизма кеширования, 
//потому что объекты без сильных связей сразу отпускаются, как только у памяти появляется необходимость избавится от "мусора". Однако со включенной ARC значения удаляются только тогда, когда уходит последняя сильная связь на них, делая слабые связи не подходящими для текущей задачи.

//Бесхозные ссылки

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) деинициализируется") }
}
 
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Карта #\(number) деинициализируется") }
}

//Свойство number класса CreditCard определено как значение типа UInt64, а не Int, для того, чтобы оно было достаточно большим, чтобы хранить числа с 16 цифрами и на 32, и на 64 разрядных системах.

var john: Customer?

john = Customer(name: "John Appleseed")
john!.card = CreditCard(number: 1234567890123456, customer: john!)

john = nil
// Выведет "John Appleseed деинициализируется"
// Выведет "Карта #1234567890123456 деинициализируется"

//Бесхозные опциональные ссылки

class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
}

class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

let department = Department(name: "Horticulture")

let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]

//Бесхозные ссылки и неявно извлеченные опциональные свойства

class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
 
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Россия", capitalName: "Москва")
print("Столицей страны \(country.name) является \(country.capitalCity.name)")
// Выведет "Столицей страны Россия является Москва"

//Циклы сильных ссылок в замыканиях

class HTMLElement {
 
    let name: String
    let text: String?
 
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
 
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
 
    deinit {
        print("\(name) деинициализируется")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
   return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// Выведет "<h1>some default text</h1>"

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Выведет "<p>hello, world</p>"


//Даже несмотря на то, что замыкание ссылается на self несколько раз, оно захватывает лишь одну сильную ссылку на экземпляр HTMLElement.

paragraph = nil

//Определение списка захвата

lazy var someClosure: (Int, String) -> String = {
      [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
   // тело замыкания
}

lazy var someClosure: () -> String = {
      [unowned self, weak delegate = self.delegate!] in
    // тело замыкания
}

//Слабые (weak) или бесхозные (unowned) ссылки

//Если захваченная ссылка никогда не будет nil, то она должна быть всегда захвачена как unowned ссылка, а не weak ссылка.

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) освобождается")
    }
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Выведет "<p>hello, world</p>"

paragraph = nil
// Выведет "p освобождается"







































































