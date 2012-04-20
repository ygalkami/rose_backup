# Module for in-class exercise
# by David Pick

class Television:
    def __str__(self):
        return "TV is " + self.status
    
    status = "on"
    channel = 5
    volume = 23
    mute = "off"
    
    def toggle_mute(self):
        if self.mute == "off":
            self.mute = "on"
        else:
            self.mute = "off"
    
    def set_vol(self, vol):
        if vol <= 100 and vol >= 0:
            self.volume = vol
        
    def increase_vol(self):
        if self.volume < 100:
            self.volume += 1
        else:
            self.volume = 0
            
    def decrease_vol(self):
        if self.volume > 0:
            self.volume -= 1
        else:
            self.volume = 100
        
    def set_channel(self, channel):
        if self.channel >= 0 and self.channel <= 100:
            self.channel = channel
            
    def increase_channel(self):
        if self.channel < 100:
            self.channel += 1
        else:
            self.channel = 0
            
    def decrease_channel(self):
        if self.channel > 0:
            self.channel -= 1
        else:
            self.channel = 100
            
    def toggle_power(self):
        if self.status == "on":
            self.status = "off"
        else:
            self.status = "on"
    
tv = Television()
print tv.channel
tv.increase_channel()
print tv.channel