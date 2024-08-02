

let led = UInt32(PICO_DEFAULT_LED_PIN) //out
let eled = UInt32(15) //out
let buttonPin = UInt32(14)

@main
struct Main {
    typealias pinController = PinController
    //typealias callbck = Optional<@convention(c) (UInt32, UInt32) -> ()>
    static var isLedOn = false
    static func main() {
        
        pinController.setupPins()
        var prevButtonState = false

        while true {
            let currState = pinController.getGPIOState(pin: buttonPin)
            if  currState && !prevButtonState {
                isLedOn.toggle()
                pinController.setGPIOState(pin: eled, state: isLedOn)
            }
            prevButtonState = currState
            sleep_ms(100)
        }
        
    }

    // static func setupPirCallbackHandler() {
    //     let callbacK: callbck = { (gpio:UInt32, event: UInt32) in
    //         if event == 8 {
    //             gpio_put(led, true)
    //         } else {
    //             gpio_put(led, false)
    //         }
    //     }
    //     gpio_put(led, true)
    //     sleep_ms(250)
    //     gpio_put(led, false)
    //     //let c = callbackMethod
    //     gpio_set_irq_enabled_with_callback(pir, 8, true, callbacK)
    // }
}
