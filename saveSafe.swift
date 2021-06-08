//Доступ к памяти происходит в вашем коде, когда вы, например, устанавливаете значение переменной или передаете аргумент функции. Так следующий код содержит доступ и на чтение и на запись:

// Доступ к памяти с правами записи, где хранится данная переменная
var one = 1

// Доступ к памяти с правами чтения, где хранится данная переменная
print("We're number \(one)!")

//Существует три характеристики доступа к памяти

//По крайней мере, один из них является доступом на запись.
//Они получают доступ к одному и тому же фрагменту в памяти.
//Их длительность перекрывается друг другом.

//все доступы для чтения и записи в приведенном ниже коде являются мгновенными:

func oneMore(than number: Int) -> Int {
    return number + 1
}
 
var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)
// Выведет "2"

//Конфликт доступа к сквозным параметрам

var stepSize = 1
 
func increment(_ number: inout Int) {
    number += stepSize
}
 
increment(&stepSize)
// Ошибка: conflicting accesses to stepSize


//Один из способов решения этого конфликта - сделать явную копию stepSize:

// Создадим явную копию
var copyOfStepSize = stepSize
increment(&copyOfStepSize)
 
// Обновим оригинал
stepSize = copyOfStepSize
// stepSize равен 2


func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)  // OK
balance(&playerOneScore, &playerOneScore)
// Ошибка: Conflicting accesses to playerOneScore

//Так как операторы это функции, то они также могут иметь долгосрочный доступ к своим сквозным параметрам. 
//Например, если balance(_:_:) это операторная функция с именем <^>, то запись playerOneScore <^> playerOneScore приведет к такому же конфликту, что и balance(&playerOneScore, &playerOneScore)



//Конфликт доступа к self в методах

struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

//Метод shareHealth(with:) (см. ниже) принимает другой экземпляр Player как сквозной параметр, создавая возможность перекрытия доступа.

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}
 
var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // OK


//Конфликт доступа к свойствам

//перекрывающиеся доступы для записи к элементам кортежа приводят к конфликту:

var playerInformation = (health: 10, energy: 20)
balance(&playerInformation.health, &playerInformation.energy)
// Ошибка: conflicting access to properties of playerInformation

//В приведенном ниже коде показано, что такая же ошибка появляется при перекрытии доступа для записи к свойствам структуры, 
//которая хранится в глобальной переменной.

var holly = Player(name: "Holly", health: 10, energy: 10)
balance(&holly.health, &holly.energy)  // Ошибка

//если переменная holly в приведенном выше примере изменена на локальную переменную вместо глобальной переменной, 
//то компилятор может доказать, что перекрывающий доступ к сохраненным свойствам структуры безопасен:

func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)  // OK
}

































