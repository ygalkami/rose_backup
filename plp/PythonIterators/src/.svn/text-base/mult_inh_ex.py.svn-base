# Examples of inheritance and multiple inheritance

class Widget:
    def __init__(self):
        self.active = True
    def activate(self):
        self.active = True
    def deactivate(self):
        self.active = False
        
class Menu(Widget):
    def __init__(self, label):
        Widget.__init__(self)
        self.label = label
        self.entries = []
    def addEntry(self, entry):
        entry.setParent(self)
        self.entries.append(entry)
        
class MenuEntry(Widget):
    def __init__(self, label, hot_key):
        Widget.__init__(self)
        self.label = label
        self.hot_key = hot_key
        self.parent_menu = None
    def setParent(self, parent):
        self.parent_menu = parent
        
class SubMenu(Menu, MenuEntry):
    def __init__(self, label, hot_key):
        Menu.__init__(self, label)
        MenuEntry.__init__(self, label, hot_key)

        
m = Menu('Edit')
cut = MenuEntry('Cut', 'X')
copy = MenuEntry('Copy', 'C')
paste = MenuEntry('Paste', 'V')
m.addEntry(cut)
m.addEntry(copy)
m.addEntry(paste)
copyAs = SubMenu('Copy As', 'shift-C')
print "Label:", copyAs.label
print "Active:", copyAs.active
print "Entries:", copyAs.entries
print "Hot Key:", copyAs.hot_key

class Top1:
    def f(self):
        print "Top1's f"
        self.g()
    def h(self):
        print "Top1's h"
        self.k()
    def k(self):
        print "Top1's k"

class Top2:
    def f(self):
        print "Top2's f"
        self.g()
    def g(self): 
        print "Top2's g"
        self.h()
    def k(self):
        print "Top1's k"

class Mid1(Top1):
    def h(self):
        print "Mid1's h"
        self.k()

class Mid2(Top2):
    def f(self):
        print "Mid2's f"
        self.g()
    def k(self):
        print "Mid2's k"

class Bottom(Mid1, Mid2):
    def k(self):
        print "Bottom's k"

b = Bottom()
b.f()
