enum  PinController {

    static func setupPins() {
        stdio_init_all()

        gpio_init(led)
        gpio_set_dir(led, /*out*/true)

        gpio_init(eled)    
        gpio_set_dir(eled, /*out*/true)

        gpio_init(buttonPin)
        gpio_set_dir(buttonPin, false)
        gpio_pull_up(buttonPin)

    }

    static func getGPIOState(pin: UInt32) -> Bool {
        gpio_get(pin)
    }

    static func setGPIOState(pin: UInt32, state: Bool) {
        gpio_put(pin, state)
    }

    static func morseBlink(led: UInt32, led1: UInt32? = nil) {
        let dot = {
            gpio_put(led, true)
            if let ld1  = led1 {
                gpio_put(ld1, true)
            }
            sleep_ms(250)
            gpio_put(led, false)
            if let ld1 = led1 {
                gpio_put(ld1, false)
            }
            sleep_ms(250)
        }
        let dash = {
            gpio_put(led, true)
            if let ld1 = led1 {
                gpio_put(ld1, true)
            }
            sleep_ms(500)
            gpio_put(led, false)
            if let ld1 = led1 {
                gpio_put(ld1, false)
            }
            sleep_ms(250)
        }
        while true {
            dot()
            dot()
            dot()

            dash()
            dash()
            dash()

            dot()
            dot()
            dot()
        }
    }

    static func signOfLife(led: UInt32 = UInt32(PICO_DEFAULT_LED_PIN)) {
        gpio_put(led, true)
        sleep_ms(250)
        gpio_put(led, false)
        sleep_ms(250)
    }
    
}