import Cocoa

class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }

    func printSummary() {
        print("I work \(hours) a day.")
    }
}

final class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }

    override func printSummary() {
        print("I'm a developer that will sometimes will work \(hours) a day, but other times will spend hours arguing about whther code should be indented using tabs or spaces.")
    }
}

final class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()

let novall = Developer(hours: 12)
novall.printSummary()

class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let teslaX = Car(isElectric: true, isConvertible: false)

class User {
    var username = "Anonymous"

    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

var user1 = User()
var user2 = user1
var user3 = user1.copy()
user2.username = "Taylor"

print(user1.username)
print(user2.username)
print(user3.username)

class NewUser {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive")
    }

    deinit {
        print("User \(id): I'm dead.")
    }
}

var users = [NewUser]()

for i in 1 ... 3 {
    let user = NewUser(id: i)
    print("User \(user.id): I'm in control")
    users.append(user)
}

print("Loop is finished")
users.removeAll()
print("Array is cleared")

class AnotherUser {
    var name = "Paul"
}

var user = AnotherUser()
user = AnotherUser()
user.name = "Taylor"
print(user.name)

class Animal {
    let legs: Int

    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    init() {
        super.init(legs: 4)
    }

    func speak() {
        print("Bark")
    }
}

class Cat: Animal {
    let isTame: Bool

    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }

    func speak() {
        print("Meow")
    }
}

final class Corgi: Dog {
    override func speak() {
        print("Woof")
    }
}

final class Poodle: Dog {
    override func speak() {
        print("Yip")
    }
}

final class Persian: Cat {
    init() {
        super.init(isTame: true)
    }
    
    override func speak() {
        print("Mieeuw")
    }
}

final class Lion: Cat {
    init() {
        super.init(isTame: false)
    }
    
    override func speak() {
        print("Roar")
    }
}
