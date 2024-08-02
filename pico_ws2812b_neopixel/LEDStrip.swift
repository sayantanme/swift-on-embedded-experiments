// enum  PinController {

//     static func setupPins() {
//         stdio_init_all()

//         // gpio_init(led)
//         // gpio_set_dir(led, /*out*/true)

//         // gpio_init(eled)    
//         // gpio_set_dir(eled, /*out*/true)

//         // gpio_init(buttonPin)
//         // gpio_set_dir(buttonPin, false)
//         // gpio_pull_up(buttonPin)

//     }

//     static func getGPIOState(pin: UInt32) -> Bool {
//         gpio_get(pin)
//     }

//     static func setGPIOState(pin: UInt32, state: Bool) {
//         gpio_put(pin, state)
//     }

//     static func signOfLife(led: UInt32 = UInt32(PICO_DEFAULT_LED_PIN)) {
//         gpio_put(led, true)
//         sleep_ms(250)
//         gpio_put(led, false)
//         sleep_ms(250)
//     }
    
// }

struct LEDStrip {
    typealias colorController = Colors

    func doSetup(numberOfPixels: UInt8, pin_tx: UInt32, freq: Float, brightness: Float) {
        setupWS2812B(numberOfPixels, pin_tx, freq, brightness)
    }

    func fillWithColor(red: UInt8, green: UInt8, blue: UInt8, activate: Bool = false) {
        pixelFill(red, green, blue, activate)
    }

    func setPixelColor(index: UInt8, red: UInt8, green: UInt8, blue: UInt8, activate: Bool = false) {
        pixelSetValue(index, red, green, blue, activate)
    }

    func activate() {
        show()
    }

    func reset() {
        clear(false)
    }

    // func update(idx: Int) {
    //     let allColors = colorController.getColorArray()
    //     let pickUpIdx = idx % colorController.getCount
    //     let color = switch pickUpIdx {
    //         case 0: allColors.violet
    //         case 1: allColors.indigo
    //         case 2: allColors.blue
    //         case 3: allColors.green
    //         case 4: allColors.yellow
    //         case 5: allColors.orange
    //         case 6: allColors.red
    //         default: allColors.red
    //     }
    //     put_pixel(color)
    // }
}