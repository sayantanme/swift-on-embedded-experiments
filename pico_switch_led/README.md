# pico-switch-led
This example follows on from Swift on embedded project[https://github.com/apple/swift-embedded-examples/tree/main?tab=readme-ov-file]

It attempts to control an external Led from a push button switch. It mimics the workings of a light switch toggling between "On" & "Off"

<img src="https://github.com/sayantanme/swift-on-embedded/assets/5054420/620bdaca-8533-4720-8122-c55865cb6742">

## Requirements

- Follow the setup steps at https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf, in particular you'll need:
  - A checkout of the [pico-sdk](https://github.com/raspberrypi/pico-sdk.git), with git submodules checked out.
  - A checkout of the [pico-examples](https://github.com/raspberrypi/pico-examples.git).
  - CMake.
  - The [Arm Embedded Toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads).
- Before trying to use Swift with the Pico SDK, make sure your environment works and can build the provided C/C++ sample projects, in particular:
  - Try building and running the "blink" example from pico-examples written in C.


## Building

- Make sure you have a recent nightly Swift toolchain that has Embedded Swift support.
- Build and copy the program in the UF2 format to the Mass Storage device to trigger flashing the program into memory (after which the device will reboot and run the firmware):
``` console
$ cd pico_switch_led
$ export TOOLCHAINS='<toolchain-name>'
$ export PICO_BOARD=pico
$ export PICO_SDK_PATH='<path-to-your-pico-sdk>'
$ export PICO_TOOLCHAIN_PATH='<path-to-the-arm-toolchain>'
$ cmake -B build -G Ninja .
$ cmake --build build
```

## Running

- Connect the Pico board via a USB cable to your Mac, and make sure it's in the USB Mass Storage firmware upload mode (either hold the BOOTSEL button while plugging the board, or make sure your Flash memory doesn't contain any valid firmware).
- Copy the UF2 firmware to the Mass Storage device:

```console
$ cp build/swift-switch-led.uf2 /Volumes/RP2040
```
