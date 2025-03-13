/*
 The goal of this block of code is to write a function that accepts an optional array of integers,
 and returns one of them randomly. If the array is missing or empty, then return a random number from
 1 through 100.
 */

func returnRandomInt(in array: [Int]?) ->Int
{
    array?.randomElement() ?? Int.random(in: 1...100)
}
//Returns number 1 through 100
print(returnRandomInt(in: []))
//Returns number 1 through 100
print(returnRandomInt(in: nil))
//Returns a random value in the array
print(returnRandomInt(in: [2,6,1,9,10]))
