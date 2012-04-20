class Object:
    short_name = ""
    actual_name = ""
    methods = []
    connections = []
    attributes = {}
    
    def __init__(self, shortname, actual_name, attributes, methods):
        self.short_name = shortname
        self.actual_name = actual_name
        self.methods = methods
        self.attributes = attributes
    
    def addMethod(self, name, params):
        self.methods.append(Method(params))
        
    def addAttribute(self, name, value):
        self.attributes.append(name)
        
    def addConnection(self, connection):
        self.connections.append(connection)
        
    def getConnections(self):
        return self.connections
    
class Method:
    params = []
    name = ""
    
    def __init__(self, name, params):
        self.params = params
        self.name = name
        
    def addParam(name):
        self.params.append(name)
        
class Connection:
    arrow_start = ""
    arrow_middle = ""
    arrow_end = ""
    start_class = ""
    end_class = ""
    
    def __init__(self, line_info, start_class, end_class):
        self.start_class = start_class
        self.end_class = end_class
        if line_info != "":
            self.arrow_left, self.arrow_middle, self.arrow_end = line_info.split("|")
            
class class_array:
    main = []
    
    def __init__(self, class_array):
        self.main.extend(class_array)
    
    def addClass(self, object):
        for i in range(len(self.main)):
            if self.main[i].short_name == object.short_name:
                self.main.pop(i)
                print self.main
                self.main.append(object)
                return True
        
        self.main.append(object)
        return True
    
    def findClass(self, short_name):
        for object in self.main:
            if object.short_name == short_name:
                return object
        return False

    def printMe(self):
        for object in self.main:
            for connection in object.connections:
                print connection.arrow_start