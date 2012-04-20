class BankAccount:
    """This class implements a generic bank account."""
    
    def __init__(self, bal, actNumber):
        self.balance = bal
        self.accountNumber = actNumber
        self.accountType = "Bank Account"
    
    def deposit(self, amt):
        self.balance += amt
        
    def withdraw(self, amt):
        self.balance -= amt
        
    def getBalance(self):
        return self.balance
    
    def __str__(self):
        return self.accountType + ": # " + str(self.accountNumber) + ": "
    
class CheckingAccount(BankAccount):
    def __init__(self, bal, actNumber, rate):
        BankAccount.__init__(self, bal, actNumber)
        self.transactionCount = 0
        
    def getTransactions(self):
        return self.transactionCount
        
    def withdraw(self, amt):
        self.withdraw()
        self.transactionCount = self.transactionCount + 1
        
    def deposit(self, amt):
        self.deposit()
        self.transactionCount = self.transactionCount + 1
class SavingsAccount(BankAccount):
    """This class implements an interest bearing savings account."""
    
    def __init__(self, bal, rate, actNumber):
        BankAccount.__init__(self, bal, actNumber)
        self.interestRate = rate
        self.interest = 0.0
        self.accountType = "Savings Account"
        
    def addInterest(self):
        interest = self.getBalance() * self.interestRate / 100.0
        self.interest += interest
        self.balance += interest
        
    def getInterest(self):
        return self.getInterest()
    
    def getInterestRate(self):
        return self.interestRate
    
    def __str__(self):
        return BankAccount.__str__(self)
    
def savingsAccountDemo():    
    sa = SavingsAccount(5000, 4.3, 100555001)
    print str(sa), "initial balance is $%0.2f" % (sa.getBalance())
    print str(sa), "interest rate is %0.2f%%" % (sa.getInterestRate())
    sa.addInterest()
    print str(sa), "balance after interest is $%0.2f" % (sa.getBalance())
    sa.deposit(40)
    print str(sa), "balance after depositing $%0.2f is $%0.2f" % ( 40, sa.getBalance())
    sa.withdraw(100)
    print str(sa), "balance after withdrawing $%0.2f is $%0.2f" % ( 100, sa.getBalance())
    print    
def checkingaccountdemo():
    ca = CheckingAccount(5000, 4.3, 100555001)
    #print str(ca), "There have been 0.2f" % (ca.getTransactionAccount()) 
    print ca.getTransactions()
def main():    
    savingsAccountDemo()
    checkingaccountdemo()
    # In order to test CheckingAccount, implement a method called checkingAccountDemo  
    # that functions in a similar fashion to savingsAccountDemo.
    # invoke checkingAccountDemo here
    exit()
    
if __name__ == '__main__':
    main()    
        
        