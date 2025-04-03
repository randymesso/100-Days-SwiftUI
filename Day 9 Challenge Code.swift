/*
Here we want to take the input array and transform it multiple ways using common closures seen in swift.
 The first was to filter out the even number, the second was used to sort the filtered array, and the third was to map the transformed array of integers into strings.
*/

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

var evenNumbers = luckyNumbers.filter { a in
    a % 2 == 0
}
var evenNumbersSorted = evenNumbers.sorted { a, b in
    a < b
}

var stringedNumbers = evenNumbersSorted.map { a in
    "\(a) is a luck number"
}

for i in stringedNumbers {
    print(i)
}















