import Cocoa

var greeting = "Hello, playground"

var name = "Ted"
name = "Rebecca"
name = "Keeley"

let character = "Daphne"

var playerName = "Roy"
print(playerName)

playerName = "Dani"
print(playerName)

playerName = "Sam"
print(playerName)

let movie = """
A day in
the life of an
Apple Engineer
"""

let movieLength = movie.count

print(movie.hasPrefix("A day"))

let score = 10
let reallyBig = 100_000_000

let lowerScore = score - 2
let higherScore = score + 10
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2

var counter = 10
counter += 5
counter *= 2
counter -= 10
counter /= 2

let number = 120
number.isMultiple(of: 3)
120.isMultiple(of: 3)

let nb = 0.1 + 0.2
print(nb)
