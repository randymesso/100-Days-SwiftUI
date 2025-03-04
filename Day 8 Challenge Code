enum outOfBounds: Error {
    case tooSmall
    case tooBig
    case noSquareRoot
}

func findSquareRoot(of input: Int) throws -> Int
{
    var answer = 0
    
    if input < 1
    {
        throw outOfBounds.tooSmall
    }
    else if input > 10_000
    {
        throw outOfBounds.tooBig
    }
    else
    {
        for i in 1...10_000 {
            if (i * i) == input
            {
                answer = i
            }
        }
    }
    if answer == 0 {
        throw outOfBounds.noSquareRoot
    }
    return answer
}

//Example function call
do {
    try findSquareRoot(of: 10_002)
}
catch outOfBounds.tooSmall {
    print("Make sure the number is greater than 1!")
}
catch outOfBounds.tooBig {
   print("Try inputing a smaller number.")
}
catch outOfBounds.noSquareRoot {
    print("This number doesn't have a square root😭")
}
catch {
    print("There was an error!")
}

