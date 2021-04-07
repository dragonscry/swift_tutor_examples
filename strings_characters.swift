//Строки и символы

let​ ​someString​ = ​"Some string literal value"

let quotation = """
The White Rabbit put on his spectacles. "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
""" // многострочный литерал

let softWrappedQuotation = """
The White Rabbit put on his spectacles. "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
// символ \ используется чтобы перенос строки не отображался части значения строки

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // , Unicode scalar U+1F496

//спецсивмоли в строке

var emptyString = "" // empty string literal
var anotherEmptyString = String() // initializer syntax
// обе строки пусты и эквиваленты друг другу

if emptyString.isEmpty {
 print("Nothing to see here")
}
// Выведет "Nothing to see here"

var variableString = "Horse"
variableString += " and carriage"
// variableString теперь "Horse and carriage"

let constantString = "Highlander"
constantString += " and another Highlander"
// это выдаст ошибку компиляции: строковая константа не может быть модифицирована

for character in "Dog!" {
  print(character)
}
// D
// o
// g
// !  Строка это коллекция символов

let exclamationMark: Character = "!" // по умолчанию был бы тип String

let catCharacters: [Character] = ["C", "a", "t", "!"]
let catString = String(catCharacters)
print(catString)
// Выведет "Cat!"

let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
// welcome равен "hello there" конкатенация строк

var instruction = "look over"
instruction += string2
// instruction равен "look over there"

let exclamationMark: Character = "!"
welcome.append(exclamationMark)
// welcome равен "hello there!"

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message равен "3 times 2.5 is 7.5" Интерполяция строк

let eAcute: Character = "\u{E9}" // é
let combinedEAcute: Character = "\u{65}\u{301}" // e с последующим ́
// eAcute равен é, combinedEAcute равен é

let precomposed: Character = "\u{D55C}"
 let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"
 //precomposed равен "한", decomposed равен "한"


 let enclosedEAcute: Character = "\u{E9}\u{20DD}"
 // enclosedEAcute равен é⃝

 let unusualMenagerie = "Коала , Улитка , Пингвин , Верблюд "
 print("unusualMenagerie содержит \(unusualMenagerie.count) символов")
 // Выведет "unusualMenagerie содержит 39 символов"

 var word = "cafe"
 print("количество символов в слове \(word) равно \(word.count)")
 // Выведет "количество символов в слове cafe равно 4"
 word += "\u{301}" // COMBINING ACUTE ACCENT, U+0301
 print("количество символов в слове \(word) равно \(word.count)")
 // Выведет "количество символов в слове café равно 4"

 let greeting = "Guten Tag!"
 greeting[greeting.startIndex]
 // G
 greeting[greeting.index(before: greeting.endIndex)]
 // !
 greeting[greeting.index(after: greeting.startIndex)]
 // u
 let index = greeting.index(greeting.startIndex, offsetBy: 7)
 greeting[index]
 // a

 

