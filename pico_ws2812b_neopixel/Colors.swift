enum Colors {
    
    // case violet(color: UInt32 = 1)
    // case indigo(color: UInt32)
    // case blue(color: UInt32)
    // case green(color: UInt32)
    // case yellow(color: UInt32)
    // case orange(color: UInt32)
    // case red(color: UInt32)

    // func getColorCode() -> UInt32 {
    //     switch self {
    //     case .violet(let color):
    //         return color
    //     case .indigo(let color):
    //         return color
    //     case .blue(let color):
    //         return color
    //     case .green(let color):
    //         return color
    //     case .yellow(let color):
    //         return color
    //     case .orange(let color):
    //         return color
    //     case .red(let color):
    //         return color
    //     }
    // }

    // static func getColorArray() -> (violet: UInt32, indigo: UInt32, blue: UInt32, green: UInt32, yellow:UInt32, orange: UInt32, red: UInt32) {
    //     let b: Float = 0.1
    //     return (urgb_u32(148, 0, 211, b), urgb_u32(75, 0, 139, b), urgb_u32(0, 0, 255, b),
    //             urgb_u32(0, 255, 0, b), urgb_u32(255, 255, 0, b), urgb_u32(255, 127, 0, b),
    //             urgb_u32(255, 0, 0, b))
    // }

    static func getRGB(degrees: Int) -> (red: UInt8, green: UInt8, blue: UInt8) {
        let slope = 1/60
        let val = if degrees >= 0 && degrees < 60 {
            (1, 0, slope * degrees)
        } else if degrees >= 60 && degrees < 120 {
            (1 - slope*(degrees - 60), 0, 1)
        } else if degrees >= 120 && degrees < 180 {
            (0, slope*(degrees - 120), 1)
        } else if degrees >= 180 && degrees < 240 {
            (0, 1, (1 - slope*(degrees - 180)))
        } else if degrees >= 240 && degrees < 300 {
            (slope*(degrees - 240), 1, 0)
        } else {
            (1,(1 - slope*(degrees - 300)),0)
        }
        
        return (UInt8(val.0) * 255, UInt8(val.1) * 255 , UInt8(val.2) * 255)
    }
}