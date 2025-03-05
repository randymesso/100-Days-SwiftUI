//This code showcases the willSet, didSet, and mutating keywords for structs

struct Player
{
    let name: String
    var rushingYards = 143
    var receivingYards: Int
    var touchDowns: Int {
        willSet {
            print("Watch out! They're about to score a touchdown!")
        }
        
        didSet {
            print("Yes! They scored a touchdown")
        }
    }
    var fantasyPoints: Int {
        get {
            return (rushingYards + receivingYards)
        }
        set {
            rushingYards = rushingYards + newValue
            receivingYards = receivingYards + newValue
        }
    }
    
    mutating func penaltyMarker()
    {
        touchDowns -= 1
    }
}



