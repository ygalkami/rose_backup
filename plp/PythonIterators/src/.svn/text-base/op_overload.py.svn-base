import doctest

class Student:
    """A small sample of operator overloading.
    
    >>> s = Student()
    >>> print s
    freshman
    >>> print s + 1
    sophomore
    >>> print s + 2
    junior
    >>> print s + 3
    senior
    >>> print s + 4
    super-senior
    >>> print s + 10
    super-senior
    >>> s += 1
    >>> print s
    sophomore
    """
    year_names = ['freshman', 'sophomore', 'junior', 'senior', 'super-senior']
    def __init__(self, year = 0):
        self.year = year
    def __str__(self):
        return Student.year_names[self.year]
    def __add__(self, num):
        new_year = min(self.year + num, len(Student.year_names) - 1)
        return Student(new_year)
        
if __name__ == '__main__':
    doctest.testmod()