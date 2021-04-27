//Обработка ошибок

//Отображение и генерация ошибок

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

//Перечисления в Swift особенно хорошо подходят для группировки схожих между собой условий возникновения ошибок и соответствующих им значений, 
//что позволяет получить дополнительную информацию о природе самой ошибки. 


//Обработка ошибок

//Передача ошибки с помощью генерирующей функции

func canThrowErrors() throws -> String
func cannotThrowErrors() -> String

struct Item {
    var price: Int
    var count: Int
}
 
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

//Реализация vend(itemNamed: ) метода использует оператор guard для раннего выхода из метода и генерации соответствующих ошибок, если какое-либо требование для приобретения закуски не будет выполнено. 
//Потому что инструкция throw мгновенно изменяет управление программой, и выбранная позиция будет куплена, только если все эти требования будут выполнены.

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels"
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}


struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

//Генерирующие ошибку инициализаторы могут распространять ошибки таким же образом, как генерирующие ошибку функции. 
//Например, инициализатор структуры PurchasedSnack в списке ниже вызывает генерирующую ошибку функции как часть процесса инициализации, 
//и он обрабатывает любые ошибки, с которыми сталкивается, путем распространения их до вызывающего его объекта.


//Обработка ошибок с использованием do-catch

//Используйте инструкцию do-catch для обработки ошибок, запуская блок кода. 
//Если выдается ошибка в коде условия do, она соотносится с условием catch для определения того, кто именно сможет обработать оши



do {
    try выражение
    выражение
} catch шаблон 1 {
    выражение
} catch шаблон 2  where условие{
    выражение
} catch шаблон 3, шаблон 4 where условие {
    выражение
} catch {
    выражение
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("Ошибка выбора.")
} catch VendingMachineError.outOfStock {
    print("Нет в наличии.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Недостаточно средств. Пожалуйста вставьте еще \(coinsNeeded) монетки.")
} catch {
    print("Неожиданная ошибка: \(error).")
}
// Выведет "Недостаточно средств. Пожалуйста вставьте еще 2 монетки.

//В приведенном выше примере, buyFavoriteSnack(person:vendingMachine: ) функция вызывается в выражении try, потому что она может сгенерировать ошибку. 
//Если генерируется ошибка, выполнение немедленно переносится в условия catch, которые принимают решение о продолжении передачи ошибки. 
//Если ошибка не генерируется, остальные операторы do выполняются.

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Некорректный вывод, нет в наличии или недостаточно денег.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}
// Выведет "Некорректный вывод, нет в наличии или недостаточно денег."

//В nourish(with: ), если vend(itemNamed : ) выдает ошибку, которая является одним из кейсов перечисления VendingMachineError, nourish(with: ) 
//обрабатывает ошибку, печатая сообщение. 
//В противном случае, nourish(with: ) распространяет ошибку на свое место вызова. Ошибка затем попадает в общее условие catch.


//Преобразование ошибок в опциональные значения

func someThrowingFunction() throws -> Int {
    // ...
}
 
let x = try? someThrowingFunction()
 
let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

//Если someThrowingFunction() генерирует ошибку, значение x и y равно nil. В противном случае значение x и y - это возвращаемое значение функции. 

//Использование try? позволяет написать краткий код обработки ошибок, если вы хотите обрабатывать все ошибки таким же образом. 
//Например, следующий код использует несколько попыток для извлечения данных или возвращает nil, если попытки неудачные.

func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

//Запрет на передачу ошибок

let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")


//Установка действий по очистке (Cleanup)

//Оператор defer откладывает выполнение, пока не происходит выход из текущей области. 
//Этот оператор состоит из ключевого слова defer и выражений, которые должны быть выполнены позже. 
//Отложенные выражения могут не содержать кода, изменяющего контроль исполнения изнутри наружу, при помощи таких операторов как break или return, 
//или просто генерирующего ошибку. Отложенные действия выполняются в обратном порядке, как они указаны, то есть, 
//код в первом операторе defer выполняется после кода второго, и так далее.

func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // работаем с файлом.
        }
        // close(file) вызывается здесь, в конце зоны видимости.
    }
}

//Вы можете использовать оператор defer, даже если не используете кода обработки ошибок.










