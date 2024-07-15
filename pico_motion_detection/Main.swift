let led = UInt32(PICO_DEFAULT_LED_PIN) //out
let eled = UInt32(15) //out
let pir = UInt32(14) //in
let buzzer = UInt32(13) //out

@main
struct Main {
    typealias pinController = PinController
    static var callback : Optional<@convention(c) (UInt32, UInt32) -> ()> = { (gpio:UInt32, event: UInt32) in
        if event == 8 {
            shouldTurnAlertOn = true
        } else if event == 4 {
            //pinController.setGPIOState(pin: eled, state: false)
        }
    }

    static var shouldTurnAlertOn = false
    static func main() {
        
        pinController.setupPins()
        gpio_set_irq_enabled_with_callback(pir, 8 | 4, true, callback)
        while true {
            if shouldTurnAlertOn {
                for _ in 1...20 {
                    pinController.setGPIOState(pin: eled, state: true)
                    pinController.setGPIOState(pin: buzzer, state: true)
                    sleep_ms(250)
                    pinController.setGPIOState(pin: eled, state: false)
                    pinController.setGPIOState(pin: buzzer, state: false)
                    sleep_ms(250)
                }
                shouldTurnAlertOn = false
            }
        }
        
    }
}
