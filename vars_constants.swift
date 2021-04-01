//Переменные и константы

var b = 5 //Переменная
b = 7 // ошибки не будет

let a = 4 // константа

var message : String // Аннотация типа (явное объявление типа переменной)
message = "hi"

var x = 0.0, y = 0.0, z = 0.0 // объявление нескольких переменных


var name, height weight : Int // Аннотация типа нескольким переменным

print("My message to uou is \(message)") // Пример интерполяции строки -  \(var or let) 

// это комментарий

/* это тоже комментарий,
но написанный на двух строках */

let cat = "?"; print(cat) // точка с запятой нужна если несколько выражений в одной строке

var int_var : Int = 5 // целочисленное значение 

let double_let : Double = 5.3 // с плавающей точкой до 15ти знаков (предпочтительнее)

let float_let : Float = 5.4 // с плавающей точкой до 6ти знаков (предпочтительнее)

let decimalInteger = 17
let binaryInteger = 0b10001 // 17 в двоичной нотации
let octalInteger = 0o21 // 17 в восмеричной нотации
let hexadecimalInteger = 0x11 // 17 в шестнадцатеричной нотации

typealias AudioSample = UInt16 // псвевдоним типа

let http404Error = (404, "Not Found") // http404Error имеет тип (Int, String), и равен (404, "Not Found") кортежи

let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// Выведет "The status code is 404" можно игнорировать части кортежа