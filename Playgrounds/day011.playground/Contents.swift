import Cocoa

struct BankAccount {
    private(set) var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
let success = account.withdraw(amount: 200)

if success {
    print("Witdrew successfully")
} else {
    print("Failed to withdraw")
}

print(account.funds)


struct School {
    static var studentCount = 0
    
    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add(student: "Taylor Swift")
print(School.studentCount)

struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeUrl = "https://www.gewoonseba.com"
}

struct Employee {
    let userName: String
    let password: String
    
    static let example = Employee(userName: "cfederighi", password: "h4irf0rce0ne")
}


//checkpoint 6


struct Car {
    let model: String
    let numberOfSeats: Int
    let totalGears: Int
    private var currentGear = 1
    
    init(model: String, numberOfSeats: Int, totalGears: Int = 6) {
        self.model = model
        self.numberOfSeats = numberOfSeats
        self.totalGears = totalGears
    }
    
    mutating func shiftUp() {
        var newGear = currentGear + 1
        if newGear <= totalGears {
            currentGear = newGear
            print("Shifted up to \(currentGear)")
        } else {
            print("Already at max gear.")
        }
    }
    
    mutating func shiftDown() {
        var newGear = currentGear - 1
        if newGear >= 1 {
            currentGear = newGear
            print("Shifted down to \(currentGear)")
        } else {
            print("Already at lowest gear")
        }
    }
}

var myPrius = Car(model: "Toyota Prius", numberOfSeats: 5, totalGears: 5)
var myPorshe = Car(model: "Porsche 911", numberOfSeats: 2)

myPorshe.shiftDown()
myPorshe.shiftUp()
myPorshe.shiftUp()
myPorshe.shiftUp()
myPorshe.shiftUp()
myPorshe.shiftUp()
myPorshe.shiftUp()
myPorshe.shiftUp()
myPorshe.shiftUp()
myPorshe.shiftDown()
myPorshe.shiftDown()
myPorshe.shiftDown()
myPorshe.shiftDown()
myPorshe.shiftDown()
myPorshe.shiftDown()
myPorshe.shiftDown()
myPorshe.shiftDown()
