import doctest
import random

class ShuffleIterator:
    def __init__(self, data):
        self.data = data
        self.order = range(len(data))
        random.shuffle(self.order)
        self.index = len(data)
    def __iter__(self):
        return self
    def next(self):
        if self.index == 0:
            raise StopIteration
        self.index -= 1
        itemIndex = self.order[self.index]
        return self.data[itemIndex]

# Generator example for next session:
def shuffle(data):
    order = range(len(data))
    random.shuffle(order)
    for itemIndex in order:
        yield data[itemIndex]


if __name__ == '__main__':
    doctest.testmod()
    s = 'Shrubbery'
    for c in ShuffleIterator(s):
        print c,
    print
    for c in shuffle(s):
        print c,
    print    