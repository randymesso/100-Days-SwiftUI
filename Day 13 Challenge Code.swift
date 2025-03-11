/*
In this body of code, I create a Building protocol. I also create a House and Office that both conform to the building protocol. 
Feel fee to copy the code and play around with it!
*/
 
protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var leasingAgent: String { get set}
    
    func getBuildingSummary()
}

struct House: Building
{
    var rooms: Int
    var cost: Int
    var leasingAgent: String
    
    func getBuildingSummary()
    {
        print("""
              This property has \(rooms) rooms, 
                costs \(cost) to buy,
                and is being marketed by \(leasingAgent)
""")
    }
}

struct Office: Building
{
    var rooms: Int
    var cost: Int
    var leasingAgent: String
    
    func getBuildingSummary()
    {
        print("""
              This property has \(rooms) rooms, 
                costs \(cost) to buy,
                and is being marketed by \(leasingAgent)
""")
    }
}
