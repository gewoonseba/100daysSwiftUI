import Cocoa

var beatles = ["John", "Paul", "George", "Ringo"]
var numbers = [4, 8, 15 ,16 ,23 ,42]

var scores = Array<Int>()
scores.append(100)
scores.append(80)
scores.append(85)

var albums = [String]()
albums.append("American Idiot")
albums.append("Dookie")
albums.append("Nimrod")

var charachters = ["Marge", "Homer", "Bart", "Lisa", "Maggie"]
charachters.remove(at: 0)
charachters.remove(at: 2)
print(charachters)

let bondMovies = ["Casino Royale", "Spectre", "No Time to Die"]
bondMovies.contains("American Psycho")

let cities = ["Tokyo", "London", "New York", "Rio de Janeiro"]
print(cities.sorted())

let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversed = presidents.reversed()

print(reversed)
print(presidents[1])

let employee = [
    "name": "Taylor Swift",
    "job": "Singer",
    "location": "Nashville"
]

print(employee["name", default: "unknown"])
print(employee["job", default: "unknown"])
print(employee["locaction", default: "unknown"])

let hasGraduated = [
    "Eric": false,
    "Peter": true,
    "Maeve": true
]

let olympics = [
    2012: "London",
    2016: "Rio de Janeiro",
    2021: "Tokyo",
    2024: "Paris"
]

var actors = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
actors.insert("Tom Holland")
print(actors)

enum Weekday {
    case monday, tuesday, wednesday, thursday, friday
}

var day = Weekday.monday
day = .friday
