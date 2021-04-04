//Операторы

let b = 10
var a = 5
a = b
// теперь a равно 10 , "=" оператор присваивания или изменения

let (x, y) = (1, 2)
// x равно 1, а y равно 2

// операторы арифметические 

1 + 2 // равно 3
5 - 3 // равно 2
2 * 3 // равно 6
10.0 / 2.5 // равно 4.0

"hello, " + "world"  // равно "hello, world"

9 % 4    // равно 1
-9 % 4   // равно -1

//a = (b × множитель) + остаток
//Если b отрицательно, его знак отбрасывается. Это означает, что выражения a % b и a % -b всегда будут давать одинаковый результат.

let three = 3
let minusThree = -three // minusThree равно -3
let plusThree = -minusThree // plusThree равно 3, т. е. "минус минус три"

let minusSix = -6
let alsoMinusSix = +minusSix // alsoMinusSix равно -6

var a = 1
a += 2
// теперь a равно 3

// равно (a == b)
// не равно (a != b)
// больше (a > b)
// меньше (a < b)
// больше или равно (a >= b)
// меньше или равно (a <= b)

1 == 1 // истина, так как 1 равно 1
2 != 1 // истина, так как 2 не равно 1
2 > 1 // истина, так как 2 больше чем 1
1 < 2 // истина, так как 1 меньше 2
1 >= 1 // истина, так как 1 больше либо равно 1
2 <= 1 // ложь, так как 2 не меньше либо равно 1

let name = "world"
if name == "world" {
 print("hello, world")
} else {
 print("Мне жаль, \(name), но я тебя не узнаю")
}
// напечатает "hello, world", так как name очевидно равно "world"


(1, "zebra") < (2, "apple")   // true, потому что 1 меньше 2, "zebra" и "apple" не сравниваются
(3, "apple") < (3, "bird")    // true , потому что 3 равно 3, а "apple" меньше чем "bird"
(4, "dog") == (4, "dog")      // true , потому что 4 равно 4 и "dog" равен "dog"

("blue", -1) < ("purple", 1) // OK, расценивается как true
("blue", false) < ("purple", true) // Ошибка так как < не может применяться к значениям типа Bool 

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20) //тернарный оператор
// rowHeight равно 90


//Оператор объединения по nil (a ?? b) извлекает опционал a, если он содержит значение, или возвращает значение по умолчанию b, если a равно nil
//объединения по nil является краткой записью следующего кода:
a != nil ? a! : b 

let defaultColorName = "red"
var userDefinedColorName: String? // по умолчанию равно nil
        
var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName равен nil, поэтому colorNameToUse получит значение по умолчанию — "red"

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName не равно nil, поэтому colorNameToUse получит значение "green"

//Операторы диапазона

for index in 1...5 { //замкнутый диапазон от 1 до 5 включительно
 print("\(index) умножить на 5 будет \(index * 5)")
}
// 1 умножить на 5 будет 5
// 2 умножить на 5 будет 10
// 3 умножить на 5 будет 15
// 4 умножить на 5 будет 20
// 5 умножить на 5 будет 25


//Оператор полузамкнутого диапазона (a..<b) задает диапазон от a до b, исключая значение b. 

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
 print("Person \(i + 1) будет \(names[i])")
}
// Person 1 будет Anna
// Person 2 будет Alex
// Person 3 будет Brian
// Person 4 будет Jack

// оператор одностороннего диапазона
for name in names[2...] {
    print(name)
}
// Brian
// Jack
 
for name in names[...2] {
    print(name)
}
// Anna
// Alex
// Brian


for name in names[..<2] { // односторонний до 2ого значения
    print(name)
}
// Anna
// Alex

let range = ...5
range.contains(7)   // false
range.contains(4)   // true
range.contains(-1)  // true

//Логические операторы
// логическое НЕ (!a)
// логическое И (a && b)
// логическое ИЛИ (a || b)


let allowedEntry = false
if !allowedEntry {
 print("ACCESS DENIED")
}
// Выведет "ACCESS DENIED"

let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
 print("Welcome!")
} else {
 print("ACCESS DENIED")
}
// Выведет "ACCESS DENIED"
//  a && b будет истиной если оба истина

let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
 print("Welcome!")
} else {
 print("ACCESS DENIED")
}
// Выведет "Welcome!"
// a || b будет истина если хотябы один операнд истина

if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
 print("Welcome!")
} else {
 print("ACCESS DENIED")
}
// Выведет "Welcome!"

if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
 print("Welcome!")
} else {
 print("ACCESS DENIED")
}
// Выведет "Welcome!" 
// Читаемость кода важнее краткости



