import Cocoa

protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

protocol CanBeElecrified {
    var isElectric: Bool { get }
}

struct Car: Vehicle, CanBeElecrified {
    let name = "Car"
    var currentPassengers = 1
    var isElectric = false

    func estimateTime(for distance: Int) -> Int {
        return distance / 50
    }

    func travel(distance: Int) {
        print("Car is traveling \(distance)km")
    }

    func openSunroof() {
        print("Car is opening sunroof")
    }
}

struct Bicycle: Vehicle, CanBeElecrified {
    let name = "Bicycle"
    var currentPassengers = 1
    var isElectric = false

    func estimateTime(for distance: Int) -> Int {
        return distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling for \(distance) km")
    }
}

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow, I'll try another vehicle")
    } else {
        vehicle.travel(distance: distance)
    }
}

func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

let car = Car()
let bike = Bicycle()
commute(distance: 100, using: bike)
commute(distance: 100, using: car)
getTravelEstimates(using: [car, bike], distance: 380)

func getRandomNumber() -> some Equatable {
    Int.random(in: 1 ... 6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())

var quote = "    The thruth is rarely pure and never simple         "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

extension String {
    // Swift naming conventions: -ed == new instance, otherwise in place (trim vs trimmed, sort vs sorted etc)
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    mutating func trim() {
        self = self.trimmed()
    }

    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}

let betterTrimmed = quote.trimmed()

let lyrics = """
But I keep crusing
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines.count)

struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

//placing init in extension keeps default memberwise initializer intact
extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

let lotr = Book(title: "The Lord of the Rings", pageCount: 1000, readingHours: 24)
