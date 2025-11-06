from machine import Pin
import time

class Button:
    
    def __init__(self, pinb,  debounce_time=200):
        self.pinb = pinb
        self.debounce_time = debounce_time #Tiempo antirrebote
        self.button = Pin(self.pinb, Pin.IN, Pin.PULL_UP )
        self.state = self.button.value() #Estado actual del botón
        self.changed = 0 #Variable para detectar que hubo un cambio de estado
        self.last_time = time.ticks_ms()
        self.button.irq(
            handler = self.attend, trigger = Pin.IRQ_FALLING | Pin.IRQ_RISING)
        
    def attend(self, pin):
        current_time = time.ticks_ms()
        if time.ticks_diff(current_time, self.last_time) > self.debounce_time:
            self.state = self.button.value()
            self.last_time = current_time
            self.changed = True
    
    def has_changed(self):
        if self.changed:
            self.changed = False
            return True
        return False
 
class Led:
    
    def __init__(self, pinl):
        self.pinl = pinl
        self.led = Pin(self.pinl, Pin.OUT)
        
    def on(self):
        self.led.value(1)
        
    def off(self):
        self.led.value(0)
        
        
if __name__ == "__main__":
    but_1 = Button(pinb = 19)
    led1 = Led(pinl = 18)
    while True:
        
        if but_1.state:
            led1.on()
        else:
            led1.off()
            
        if but_1.has_changed():
            print("Botón = ", but_1.state)
            
        time.sleep(0.1)
        
    
    
        
    