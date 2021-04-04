// Обработка ошибок

func canThrowAnError() throws {
// эта функция может сгенерировать ошибку
}

do {
  try canThrowAnError()
  // ошибка не была сгенерирована
} catch {
  // ошибка сгенерирована
}


func makeASandwich() throws {
    // ...
}
 
do {
    try makeASandwich()
    eatASandwich()
} catch SandwichError.outOfCleanDishes {
    washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
    buyGroceries(ingredients)


//ошибки могут быть переданы в несколько условий catch

//Утверждения

let age = -3
assert(age >= 0, "Возраст человека не может быть меньше нуля")
// это приведет к вызову утверждения, потому что age >= 0, а указанное значение < 0.

if age > 10 {
    print("Ты можешь покататься на американских горках и чертовом колесе.")
} else if age > 0 {
    print("Ты можешь покататься на чертовом колесе.")
} else {
    assertionFailure("Возраст человека не может быть отрицательным.")
}

//Обеспечение предусловиями

 // В реализации сабскрипта...
precondition(index > 0, "Индекс должен быть больше нуля.")