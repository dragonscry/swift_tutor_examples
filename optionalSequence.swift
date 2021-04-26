//Опциональная последовательность

class Person {
    var residence: Residence?
}
 
class Residence {
    var numberOfRooms = 1
}

//Экземпляры Residence имеют единственное свойство numberOfRooms типа Int, со значением по умолчанию 1. 
//Экземпляры Person имеют опциональное свойство residence типа Residence?.

//Если вы создаете новый экземпляр Person, то его свойство residence по умолчанию имеет значение nil, в силу того, что оно является опционалом. 
//В коде ниже john имеет свойство residence, значение которого nil:

let john = Person()

//Если вы попытаетесь получить доступ к свойству numberOfRooms свойства residence экземпляра Person, 
//поставив восклицательный знак после residence, для принудительного извлечения, то вы получите ошибку исполнения, 
//потому что residence не имеет значения для извлечения:

let roomCount = john.residence!.numberOfRooms
// ошибка runtime

//Опциональная последовательность предоставляет альтернативный способ получить доступ к значению numberOfRooms. 
//Для использования опциональной последовательности используйте вопросительный знак, на месте восклицательного знака:

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Выведет "Unable to retrieve the number of rooms."

//Вы можете присвоить экземпляр Residence в john.residence, так что оно больше не будет являться значением nil.

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Выведет "John's residence has 1 room(s)."




// Определение классовых моделей для ОП

class Person {
    var residence: Residence?
}

//Класс Residence стал намного сложнее, чем был раньше. 
//В этот раз класс Residence определяет переменное свойство rooms, которое инициализировано пустым массивом [Room]:

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("Общее количество комнат равно \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { 
        self.name = name 
    }
}


//Последний класс в этой модели Address. Этот класс имеет три опциональных свойства типа String?. 
//Первые два свойства buildingName, buildingNumber являются альтернативным вариантом определения конкретного здания как части адреса. 
//Третье свойство street используется для названия улицы, для этого адреса:


class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

//Вызов методов через ОП

func printNumberOfRooms() {
    print("Общее количество комнат равно \(numberOfRooms)")
}

//Если вы вызовите этот метод на опциональном значении в опциональной последовательности, то он вернет тип не Void, а Void?, 
//потому что возвращаемые значения всегда опционального типа, когда они вызываются через опциональную последовательность

if john.residence?.printNumberOfRooms() != nil {
    print("Есть возможность вывести общее количество комнат.")
} else {
    print("Нет возможности вывести общее количество комнат.")
}
// Выведет "Нет возможности вывести общее количество комнат."

if (john.residence?.address = someAddress) != nil {
    print("Была возможность установить адрес.")
} else {
    print("Не было возможности установить адрес.")
}
// Выведет "Не было возможности установить адрес."




//Доступ к свойствам через ОП

let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Выведет "Unable to retrieve the number of rooms."

//Так как john.residence равен nil, этот вызов опциональной последовательности не будет успешен как и ранее.

//Вы можете попробовать установить значение свойства через опциональную последовательность:

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress

//В этом примере попытка установить значение свойству address опциональному свойству residence? провалится, так как john.residence все еще nil.


func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
john.residence?.address = createAddress()

//Можно заметить, что функция createAddress() не вызывается, так как ничего в консоли у нас не выводится.



//Доступ к сабскриптам через ОП

//Когда вы получаете доступ к опциональному значению через опциональную последовательность, 
//вы размещаете вопросительный знак до скобок сабскрипта (индекса), а не после. 
//Вопросительный знак опциональной последовательности следует сразу после части выражения, которая является опционалом.


if let firstRoomName = john.residence?[0].name {
    print("Название первой комнаты \(firstRoomName).")
} else {
    print("Никак не получить название первой комнаты.")
}
// Выведет "Никак не получить название первой комнаты."

john.residence?[0] = Room(name: "Bathroom")

//Это попытка установки значения через сабскрипт так же не срабатывает, так как residence все еще nil.

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Гостиная"))
johnsHouse.rooms.append(Room(name: "Кухня"))
john.residence = johnsHouse
 
if let firstRoomName = john.residence?[0].name {
    print("Название первой комнаты \(firstRoomName).")
} else {
    print("Никак не получить название первой комнаты.")
}
// Выведет "Название первой комнаты Гостиная."


//Получение доступа к сабскрипту (индексу) опционального типа


var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// массив "Dave" теперь имеет вид [91, 82, 84], массив "Bev" - [80, 94, 81]


//Соединение нескольких уровней ОП

//Если тип, который вы пытаетесь получить не опциональный, то он станет опциональным из-за опциональной последовательности.
//Если тип, который вы пытаетесь получить, уже опциональный, то более опциональным он уже не станет, 
//аже по причине опциональной последовательности.


//Если вы пытаетесь получить значение типа Int через опциональную последовательность, 
//то получите Int?, и это не будет зависеть от того, сколько уровней в опциональной последовательности задействовано.
//Аналогично, если вы попытаетесь получить значение типа Int? через опциональную последовательность, то вы получите Int?, 
//что опять таки не зависит от количества уровней, которые задействованы в опциональной последовательности.

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Выведет "Unable to retrieve the address."

//Значение john.residence на данный момент содержит корректный экземпляр класса Residence. 
//Однако значение john.residence.address равно nil. Из-за этого вызов john.residence?.address?.street проваливается.

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress
 
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Выведет "John's street name is Laurel Street."



//Связывание методов в ОП с опциональными возвращаемыми значениями


if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
// Выведет "John's building identifier is The Larches."

//Если вы хотите продолжить свою опциональную привязку и на возвращаемое значение метода, 
//то разместите вопросительный знак после круглых скобок самого метода:

if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
// Выведет "John's building identifier begins with "The"."

//В примере выше вы разместили вопросительный знак опциональной привязки после круглых скобок метода, 
//потому что опциональная величина, которую вы присоединяете к последовательности, 
//является возвращаемой величиной метода buildingIdentifier, а не самим методом buildingIdentifier.





















