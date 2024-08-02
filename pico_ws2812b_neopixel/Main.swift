

let led = UInt32(25) //out
let eled = UInt32(15) //out
let buttonPin = UInt32(14)
let WS2812_PIN = UInt32(2)
let numberOfLeds = UInt8(60)
let freq = Float(800000)

@main
struct Main {
    //typealias pinController = PinController
    //typealias callbck = Optional<@convention(c) (UInt32, UInt32) -> ()>
    static var ledStrip = LEDStrip()  
    typealias colorController = Colors

    static func main() {
        
        stdio_init_all()
        gpio_init(led)
        gpio_set_dir(led, /*out*/true)

        ledStrip.doSetup(numberOfPixels: numberOfLeds, pin_tx: WS2812_PIN, freq: freq, brightness: 0.02)
        
        ledStrip.reset()
        ledStrip.activate()

        while true {
            
            // for i in 0..<numberOfLeds {
            //     ledStrip.fillWithColor(red: 255, green: 0, blue: 0)
            //     ledStrip.setPixelColor(index: i, red: 0, green: 255, blue: 0)
            //     ledStrip.activate()
            //     sleep_ms(10)
            // }

            for deg in stride(from: 0, to: 360, by: 1) {
                for pix in stride(from: 0, to: (numberOfLeds - 1), by: 1) {
                    var cdeg = deg + (Int(pix)*6)
                    if cdeg >= 360 {
                        cdeg = cdeg - 360
                    }
                    let value = colorController.getRGB(degrees: cdeg)
                    ledStrip.setPixelColor(index: pix, red: value.red, green: value.green, blue: value.blue)
                }
                ledStrip.activate()
                sleep_ms(10)
            }
            signOfLife()
        }
        
    }

    static func signOfLife(led: UInt32 = UInt32(25)) {
        gpio_put(led, true)
        sleep_ms(250)
        gpio_put(led, false)
        sleep_ms(250)
    }
}
