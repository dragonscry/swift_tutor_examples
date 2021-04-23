//Сабскрипты

subscript(index: Int) -> Int {
    get {
        //возвращает надлежащее значение скрипта
    }
    set(newValue) {
        //проводит надлежащие установки 
    }
}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
 
let threeTimesTable = TimesTable(multiplier: 3)
print("шесть умножить на три будет \(threeTimesTable[6])")
// Выведет "шесть умножить на три будет 18"

var numberOfLegs = ["паук": 8, "муравей": 6, "кошка": 4]
numberOfLegs["птичка"] = 2
//К примеру, словарь в языке Swift использует сабскрипт для присваивания или получения значения, которое хранится в экземпляре Dictionary. 
//Вы можете задать значение в словаре, и используя ключ типа ключа словаря в квадратных скобках, присваивая значение типа словаря через сабскрипт

//Сабскрипты могут принимать любое количество входных параметров, и эти параметры могут быть любого типа. Сабскрипты так же могут возвращать любой тип. 
//Сабскрипты могут использовать вариативные параметры, но они не могут иметь сквозных параметров или обеспечивать исходные значения параметрам.

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)

matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

let someValue = matrix[2, 2]
//это вызывает утверждение, потому что [2, 2] находится за пределами матрицы