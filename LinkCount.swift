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




















