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

 greeting[greeting.endIndex] // ошибка
 greeting.index(after: endIndex) // ошибка

 for index in greeting.indices {
 print("\(greeting[index]) ", terminator: " ")
 }
// Выведет "G u t e n T a g !" indices создает range всех индексов

var welcome = "hello"
 welcome.insert("!", at: welcome.endIndex)
// welcome теперь равен "hello!"
welcome.insert(contentsOf:" there", at: welcome.index(before: welcome.endIndex))
// welcome теперь равен "hello there!”

//Подстроки

let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning is "Hello"
// Конвертируем в строку для хранения более продолжительное время.
let newString = String(beginning)

let quotation = "Мы с тобой похожи"
let sameQuotation = "Мы с тобой похожи"
if quotation == sameQuotation {
  print("Эти строки считаются равными")
}
// Выведет "Эти строки считаются равными"


// "Voulez-vous un café?" используем LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
// "Voulez-vous un café?" используем LATIN SMALL LETTER E и COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
if eAcuteQuestion == combinedEAcuteQuestion {
  print("Эти строки считаются равными")
}
// Выведет "Эти строки считаются равными"

let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"
if latinCapitalLetterA != cyrillicCapitalLetterA {
  print("Эти строки считаются не равными")
}
// Выведет "Эти строки считаются не равными"

var act1SceneCount = 0
for scene in romeoAndJuliet {
  if scene.hasPrefix("Act 1 ") {
    act1SceneCount += 1
  }
}
 print("Всего \(act1SceneCount) сцен в Акте 1")
 // Выведет "Всего 5 сцен в Акте 1"  если видет упоминание Act 1 в самом начале

 var mansionCount = 0
 var cellCount = 0
 for scene in romeoAndJuliet {
   if scene.hasSuffix("Capulet's mansion") {
     mansionCount += 1
   } else if scene.hasSuffix("Friar Lawrence's cell") {
     cellCount += 1
   }
 }
 print("\(mansionCount) сцен в особняке; \(cellCount) тюремные сцены")
 // выводит "6 сцен в особняке; 2 тюремные сцены" если видет упоминание в самом конце

let dogString = "Dog‼"

for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: " ")
}
print("")
 // 68 111 103 226 128 188 240 159 144 182

 for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: " ")
}
print("")
 // Выведет "68 111 103 8252 55357 56374 "

 for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: " ")
}
print("")
// Выведет "68 111 103 8252 128054 "




