/*
 In this block of code we take a look at classes and inheritance. We create an Animal class, a Dog class, and a Cat class. All of which we subclass and even override at some point.
 */

class Animal
{
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal
{
    func speak() {
        print("BARK BARK!")
    }
}

class Corgi: Dog
{
    
    override func speak() {
        print("bark bark I'm a corgi")
    }
}

class Poodle: Dog
{
    override func speak() {
        print("BaRk BaRk I'm a poodle")
    }
}

class Cat: Animal
{
    var isTame: Bool
    var catLegs = 4
    func speak() {
        print("MEOW!")
    }
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: catLegs)
    }
}

class Persion: Cat
{
    override func speak() {
        print("RoAr RoAr")
    }
}

class Lion: Cat
{
    override func speak() {
        print("ROAR ROAR")
    }
}
