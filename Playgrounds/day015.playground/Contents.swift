import Cocoa

var name = "Ted"
name = "Rebacca"

let user = "Daphne"
print(user)

let actor = "Tom Cruise 🏃🏻‍♂️"
let quote = "He tapped a sign saying \"Believe\" and walked away."

let movie = """
A day in 
The life of an
Apple engineer
"""

print(actor.count)
print(quote.hasPrefix("He"))

var button = true
button.toggle()
print(button)

let employee = [
    "name": "Ted",
    "job": "Coach"
]

var numbers = Set([1, 1, 3, 8, 23, 14])
numbers.insert(10)
print(numbers)

enum Weekday {
    case mon, tue, wed, thu, fri, sat, sun
}

let player: String = "Roy"
let pi: Double = 3.1415
let alubms: [String] = ["Dookie", "American Idiot"]
let songs: [String] = ["Basket Case", "American Idiot"]

var teams: [String] = .init()

func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let (firstName, _) = getUser()
print(firstName)

func isUpperCased(_ string: String) -> Bool {
    string == string.uppercased()
}

let str = "HELLO WORLD"
print(isUpperCased(str))

enum PasswordError: Error {
    case tooShort, tooObvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 8 {
        throw PasswordError.tooShort
    }
    if password.contains("password") {
        throw PasswordError.tooObvious
    }
    if password.count < 10 {
        return "OK"
    } else {
        return "Great"
    }
}

do {
    let result = try checkPassword("password")
} catch PasswordError.tooObvious {
    print("That's too obvious, muppet")
} catch {
    print("general error")
}

let sayHello = { (name: String) in
    print("Hi, there \(name)!")
}

sayHello("Taylor")

let team = ["Roy", "Taylor", "Swift"]
let onlyT = team.filter { $0.hasPrefix("T") }
