/*
This function creates a Car struct that allows the user to set its model and number of seats. It
also allows the user to change its gear to a valid shift.
 */

struct Car
{
    private let model: String
    private let numberOfSeats: Int
    var currentGear = 0
    
    mutating func changeGear(to newGear: Int)
    {
        if !(1...10).contains(newGear)
        {
            print("Print please choose a valid gear")
            return
        }
        if newGear > currentGear
        {
            currentGear = newGear
            print("Shifting down!")
        }
        else if newGear < currentGear
        {
            currentGear = newGear
            print("Shifting UP, hold on!")
        }
        else
        {
            print("Staying the same😔")
        }
    }
    init(model: String, numberOfSeats: Int, currentGear: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
        self.currentGear = currentGear
    }
    
}
var newCar = Car(model: "Focus", numberOfSeats: 5, currentGear: 2)


