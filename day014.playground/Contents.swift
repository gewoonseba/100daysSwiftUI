import Cocoa

let opposites = ["Mario": "Wario", "Luigi": "Waluigi"]
let peach = opposites["Peach"]

if let marioOppsite = opposites["Mario"] {
    print("\(marioOppsite) is Mario's opposite")
}


//unwrapping optional value through if let
if let peachOpposite = opposites["Peach"] {
    print("\(peachOpposite) is Peach's opposite")
} else {
    print("We don't know Peach's opposite")
}


func square(number: Int) -> Int {
    number * number
}


var number: Int?
if let number = number {
    print(square(number: number))
}

//unwrapping with guard let
func printSquare(number: Int?) {
    guard let number = number else {
        print("Missing input")
        return
    }
    print("\(number) squared is \(number * number)" )
    
}

printSquare(number: nil)
printSquare(number: 10)

let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"] ?? "N/A"

let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "None"


struct Book {
    let title: String
    let author: String?
}

let book = Book(title: "The Great Gatsby", author: nil)
let author = book.author ?? "Anonymous"
print(author)

let input = ""
let nb = Int(input) ?? 0
print(nb)


//optional chaining
let names = ["Arya", "Bran", "Robb", "Sansa"]
let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")

var newbook: Book? = nil
let writer = newbook?.author?.first?.uppercased() ?? "A"

enum UserError: Error {
    case BadID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}

let user = (try? getUser(id: 23)) ?? "Anonymous"

//checkpoint 9
func getRandomFrom(_ array: [Int]?) -> Int {
    guard let random = array?.randomElement() else {
        print("Can't get random element from array")
        return Int.random(in: 1...100)
    }
    print("Return random element from array")
    return random
}

let a1: [Int]? = nil
let a2: [Int]? = [1,2,3]
let a3: [Int]? = [Int]()

getRandomFrom(a1)
getRandomFrom(a2)
getRandomFrom(a3)
