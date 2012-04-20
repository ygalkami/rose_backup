class Customer {
   private String _name;
   private Vector _rentals = new Vector();

   public Customer (String name){
       _name = name;
   };

   public void addRental(Rental arg) {
     _rentals.addElement(arg);
   }
   public String getName (){
       return _name;
   };

   public String statement() {
        double totalAmount = 0;
        int frequentRenterPoints = 0;
        Enumeration rentals = _rentals.elements();
        String result = "Rental Record for " + getName() + "\n";
        while (rentals.hasMoreElements()) {
            double thisAmount = 0;
            Rental each = (Rental) rentals.nextElement();

            thisAmount = amountFor(each);

            // add frequent renter points
            frequentRenterPoints ++;
            // add bonus for a two day new release rental
            if ((each.getMovie().getPriceCode() == Movie.NEW_RELEASE) && each.getDaysRented() > 1) frequentRenterPoints ++;

            //show figures for this rental
            result += "\t" + each.getMovie().getTitle()+ "\t" + String.valueOf(thisAmount) + "\n";
            totalAmount += thisAmount;

        }
        //add footer lines
        result +=  "Amount owed is " + String.valueOf(totalAmount) + "\n";
        result += "You earned " + String.valueOf(frequentRenterPoints) + " frequent renter points";
        return result;

    }

    private int amountFor(Rental each) {
	    int thisAmount = 0;
	    switch (each.getMovie().getPriceCode()) {
		case Movie.REGULAR:
		    thisAmount += 2;
		    if (each.getDaysRented() > 2)
		        thisAmount += (each.getDaysRented() - 2) * 1.5;
		    break;
		case Movie.NEW_RELEASE:
		    thisAmount += each.getDaysRented() * 3;
		    break;
		case Movie.CHILDRENS:
		    thisAmount += 1.5;
		    if (each.getDaysRented() > 3)
		        thisAmount += (each.getDaysRented() - 3) * 1.5;
		    break;

	     }
     return thisAmount;
    }

   
}

Extract Method:
//In this step the book removed the large switch statement from the statement method.
//This refactoring makes the original statement method easier to read. It also makes the switch
//much easier to test, since now we can write a unit that that simply calls the function
//and checks to see if it works correctly
------------------------------------------------------------------------------------------------------

class Customer {
   private String _name;
   private Vector _rentals = new Vector();

   public Customer (String name){
       _name = name;
   };

   public void addRental(Rental arg) {
     _rentals.addElement(arg);
   }
   public String getName (){
       return _name;
   };

   public String statement() {
        double totalAmount = 0;
        int frequentRenterPoints = 0;
        Enumeration rentals = _rentals.elements();
        String result = "Rental Record for " + getName() + "\n";
        while (rentals.hasMoreElements()) {
            double thisAmount = 0;
            Rental each = (Rental) rentals.nextElement();

            thisAmount = each.getCharge();

            // add frequent renter points
            frequentRenterPoints ++;
            // add bonus for a two day new release rental
            if ((each.getMovie().getPriceCode() == Movie.NEW_RELEASE) && each.getDaysRented() > 1) frequentRenterPoints ++;

            //show figures for this rental
            result += "\t" + each.getMovie().getTitle()+ "\t" + String.valueOf(thisAmount) + "\n";
            totalAmount += thisAmount;

        }
        //add footer lines
        result +=  "Amount owed is " + String.valueOf(totalAmount) + "\n";
        result += "You earned " + String.valueOf(frequentRenterPoints) + " frequent renter points";
        return result;

    }

    private double amountFor(Rental aRental) {
       return aRental.getCharge();
    }

}
}

Move Method:
//This step moves the amountFor method that was created in the last step into the Rental class.
//This is done because the rental class contains all the information needed to for the amountFor
//method. This helps to maintain high cohesion and low coupling.
---------------------------------------------------------------------------------------------

class Customer {
   private String _name;
   private Vector _rentals = new Vector();

   public Customer (String name){
       _name = name;
   };

   public void addRental(Rental arg) {
     _rentals.addElement(arg);
   }
   public String getName (){
       return _name;
   };

   public String statement() {
        double totalAmount = 0;
        int frequentRenterPoints = 0;
        Enumeration rentals = _rentals.elements();
        String result = "Rental Record for " + getName() + "\n";
        while (rentals.hasMoreElements()) {
            double thisAmount = 0;
            Rental each = (Rental) rentals.nextElement();

            // add frequent renter points
            frequentRenterPoints++;
            // add bonus for a two day new release rental
            if ((each.getMovie().getPriceCode() == Movie.NEW_RELEASE) && each.getDaysRented() > 1) frequentRenterPoints ++;

            //show figures for this rental
            result += "\t" + each.getMovie().getTitle()+ "\t" + String.valueOf(each.getCharge()) + "\n";
            totalAmount += each.getCharge();

        }
        //add footer lines
        result +=  "Amount owed is " + String.valueOf(totalAmount) + "\n";
        result += "You earned " + String.valueOf(frequentRenterPoints) + " frequent renter points";
        return result;

    }

    private double amountFor(Rental aRental) {
       return aRental.getCharge();
    }

}
}

Replace Temp with Query:
//In this step the book removes all calls to thisAmount and replaces them with the call
//each.getCharge(). This can be done because thisAmount is redundant and adds to the amount of 
//code without reducing confusion or complexity. By elminating it, cleaner more readable code is
//createcd.
------------------------------------------------------------------------------------------------

class Customer {
   private String _name;
   private Vector _rentals = new Vector();

   public Customer (String name){
       _name = name;
   };

   public void addRental(Rental arg) {
     _rentals.addElement(arg);
   }
   public String getName (){
       return _name;
   };

   public String statement() {
         int frequentRenterPoints = 0;
         Enumeration rentals = _rentals.elements();
         String result = "Rental Record for " + getName() + "\n";
         while (rentals.hasMoreElements()) {
             Rental each = (Rental) rentals.nextElement();
             frequentRenterPoints += each.getFrequentRenterPoints();

             //show figures for this rental
             result += "\t" + each.getMovie().getTitle()+ "\t" +
                 String.valueOf(each.getCharge()) + "\n";
         }

         //add footer lines
         result +=  "Amount owed is " + String.valueOf(getTotalCharge()) + "\n";
         result += "You earned " + String.valueOf(frequentRenterPoints) +
           " frequent renter points";
         return result;
   }

   private double getTotalCharge() {
         double result = 0;
         Enumeration rentals = _rentals.elements();
         while (rentals.hasMoreElements()) {
             Rental each = (Rental) rentals.nextElement();
             result += each.getCharge();
         }
         return result;
    }


    private double amountFor(Rental aRental) {
       return aRental.getCharge();
    }

}
}

Extract Method:
//In This step the getTotalCharge() method is created. It is created to so that the logic
//calculating the total cost of a rental is removed from the statement method. This allows
//both methods to be properly tested, and ensures that both methods work as intended.
//By creating the getTotalCharge method, the book has made the statement method more
//readable, understandable, and testable.
----------------------------------------------------------------------------------------------

class Customer {
   private String _name;
   private Vector _rentals = new Vector();

   public Customer (String name){
       _name = name;
   };

   public void addRental(Rental arg) {
     _rentals.addElement(arg);
   }
   public String getName (){
       return _name;
   };

     public String statement() {
         Enumeration rentals = _rentals.elements();
         String result = "Rental Record for " + getName() + "\n";
         while (rentals.hasMoreElements()) {
             Rental each = (Rental) rentals.nextElement();

             //show figures for this rental
             result += "\t" + each.getMovie().getTitle()+ "\t" +
                 String.valueOf(each.getCharge()) + "\n";
         }

         //add footer lines
         result +=  "Amount owed is " + String.valueOf(getTotalCharge()) + "\n";
         result += "You earned " + String.valueOf(getTotalFrequentRenterPoints()) +
                   " frequent renter points";
        return result;
    }

     private int getTotalFrequentRenterPoints(){
          int result = 0;
         Enumeration rentals = _rentals.elements();
         while (rentals.hasMoreElements()) {
             Rental each = (Rental) rentals.nextElement();
             result += each.getFrequentRenterPoints();
         }
         return result;
     }


   private double getTotalCharge() {
         double result = 0;
         Enumeration rentals = _rentals.elements();
         while (rentals.hasMoreElements()) {
             Rental each = (Rental) rentals.nextElement();
             result += each.getCharge();
         }
         return result;
    }


    private double amountFor(Rental aRental) {
       return aRental.getCharge();
    }

}
}

Replace Temp with Query:
//This step the frequent renter points temporary variable. As was said before,
//this makes the code more readable and understandable.
-------------------------------------------------------------------------------------------