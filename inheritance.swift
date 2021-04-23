//Наследование

class Vehicle {
  var currentSpeed = 0.0
  var description: String {
    return "движется на скорости \(currentSpeed) миль в час"
  }
  func makeNoise() {
    //ничего не делаем, так как не каждый транспорт шумит
  }
}

let someVehicle = Vehicle()

print("Транспорт: \(someVehicle.description)")
//Транспорт: движется на скорости 0.0 миль в час

class SomeSubclass: SomeSuperclass {
  // определение подкласса проводится тут
}
//синтаксис наследования

class Bicycle: Vehicle {
  var hasBasket = false
}

//по умолчанию свойство фолс но можно поменять при создании экземпляра

let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
print("Велосипед: \(bicycle.description)")
//Велосипед: движется на скорости 15.0 миль в час

//подклассы могут создавать подклассы

class Tandem: Bicycle {
  var currentNumberOfPassengers = 0
}

//Класс Tandem наследует все свойства и методы Bicycle, который в свою очередь наследует все свойства и методы от Vehicle. 
//Подкласс Tandem так же добавляет новое хранимое свойство currentNumberOfPassengers, которое по умолчанию равно 0.

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Тандем: \(tandem.description)")
// Тандем: движется на скорости 22.0 миль в час

//Подклассы могут проводить свои собственные реализации методов экземпляра, методов класса, свойств экземпляра, свойств класса или индекса, который в противном случае будет наследовать от суперкласса. 
//Это известно как переопределение.

//Для переопределения характеристик, которые все равно будут унаследованы, вы приписываете к переписываемому определению ключевое слово override.

//Там, где это уместно, вы можете получить доступ к методу, свойству, индексу версии суперкласса, если будете использовать префикс super

//Переопределенный метод someMethod может вызвать версию суперкласса метода someMethod, написав super.someMethod() внутри переопределения реализации метода.
//Переопределённое свойство someProperty может получить доступ к свойству версии суперкласса someProperty как super.someProperty внутри переопределения реализации геттера или сеттера.
//Переопределенный индекс для someIndex может получить доступ к версии суперкласса того же индекса как super[someIndex] изнутри переопределения реализации индекса.


class Train: Vehicle {
  override func makeNoise() {
    print("Чу-чу")
  }
}

 let train = Train()
train.makeNoise()
// Выведет "Чу-чу"

//Вы можете представить унаследованное свойство только для чтения, как свойство, которое можно читать и редактировать, прописывая и геттер и сеттер в вашем переопределяемом свойстве подкласса. 
//Однако вы не можете сделать наоборот, то есть сделать свойство редактируемое и читаемое только свойством для чтения.


class Car: Vehicle {
  var gear = 1
  override var description: String {
    return super.description + " на передаче \(gear)"
  }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Машина: \(car.description)")
// Выведет "Машина: движется на скорости 25.0 миль в час на передаче 3"


class AutomaticCar: Car {
  override var currentSpeed: Double {
    didSet {
      gear = Int(currentSpeed / 10.0) + 1
    }
  }
}


let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("Машина с автоматом: \(automatic.description)")
//Выведет "Машина с автоматом: движется на скорости 35.0 миль в час на передаче 4"

//Вы можете предотвратить переопределение метода, свойства или индекса, обозначив его как конечный.
//Сделать это можно написав ключевое слово final перед ключевым словом метода, свойства или индекса (final var, final func, final class func, и final subscript ).

//Вы можете отметить целый класс как конечный или финальный, написав слово final перед ключевым словом class (final class). 
//Любая попытка изменить класс так же приведет к ошибке компиляции.


