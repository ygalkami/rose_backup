class Animal:
    """This class represents a generic animal."""
    
    def __init__(self, name):
        self.name = name
        
    def sound(self):
        return 'am silent.'
    
    def __str__(self):
        return self.name + ": I am an animal"
 
class Cat(Animal):
    """This class rezpresents a meowing animal."""
    
    def __init__(self, name):
        Animal.__init__(self, name)

    def sound(self):
        return 'meow.'
    
    def __str__(self):
        return self.name + ": I am a cat"    
 
class Dog(Animal):
    """This class represents a barking animal."""

    def __init__(self, name):
        Animal.__init__(self, name)

    def sound(self):
        return 'bark.'
    
    def __str__(self):
        return self.name + ": I am a dog"       
    
def main():    
    animals = [Animal("Garth")]
    animals.append(Cat("Mittens"))
    animals.append(Dog("Blacky"))
    
    for animal in animals:     
        print "\n", str(animal) + " and I " + animal.sound()
    
if __name__ == '__main__':
    main()       