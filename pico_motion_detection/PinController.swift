enum  PinController {

    static func setupPins() {
        stdio_init_all()

        gpio_init(led)
        gpio_set_dir(led, /*out*/true)

        gpio_init(eled)    
        gpio_set_dir(eled, /*out*/true)

        gpio_init(pir)
        gpio_set_dir(pir, false)
        //gpio_pull_up(pir)

        gpio_init(buzzer)
        gpio_set_dir(buzzer, true)
        //gpio_pull_down(buzzer)

    }

    static func getGPIOState(pin: UInt32) -> Bool {
        gpio_get(pin)
    }

    static func setGPIOState(pin: UInt32, state: Bool) {
        gpio_put(pin, state)
    }

    static func signOfLife(led: UInt32 = UInt32(PICO_DEFAULT_LED_PIN)) {
        gpio_put(led, true)
        sleep_ms(250)
        gpio_put(led, false)
        sleep_ms(250)
    }
    
}