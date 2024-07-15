# pico-motion-detection
This example follows on from Swift on embedded project[https://github.com/apple/swift-embedded-examples/tree/main?tab=readme-ov-file]

User PIR sensor with an interrupt handler to detection motion in a space. Runs a buzzer and a detection LED via GPIO outputs.

## Image
<img src="https://github.com/user-attachments/assets/36a9f233-5fd0-42ea-8020-dd6e2ece1eca">


## Pin Setup 
Pico Pin(40) VBUS -> +rail
Pico Pin(38) GND -> -rail

PIR 5V -> +rail
PIR GND -> -rail
PIR OUT -> GP14

LED + -> resistor -> GP15
LED - -> -rail

Active Buzzer + -> GP13
Active Buzzer - -> -rail

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
$ cd pico_motion_detection
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
$ cp build/swift-motion-detection.uf2 /Volumes/RPI-RP2
```
