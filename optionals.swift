//Опционалы

var serverCode : Int? = 404 // Int? - опционал (значение или nil)

serverCode = nil

var answer : String? // значение будет сразу nil

// Инструкция if для извлечения опционала
if serverCode != nil {
    print("serverCode contains some integer value.")
}

serverCode! // принудительное извлечение опционала 

//Optional Binding - Привязка опционалов
if let constantName = someOptional {
    statements
}


let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// для convertedNumber выведен тип "Int?", или "опциональный Int"

if let actualNumber = Int(possibleNumber) {
    print("\(possibleNumber) has an integer value of \(actualNumber)")
} else {
    print("\(possibleNumber) could not be converted to an integer")
}
// Выведет "123" has an integer value of 123


//Неявно извлеченные опционалы

let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // необходим восклицательный знак

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // восклицательный знак не нужен
