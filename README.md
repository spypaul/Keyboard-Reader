# Keyboard-Reader
## Describtion
This school project is codded in Verilog created on the Nexys 4 FPGA. This project involves the usage of the USB HID interface on the Nexys 4 and the Ps2 protocol of the keyboard. Since the SCK(clock signal of the keyboard) is asynchronous to the system, there are two synchronizers for the SCK and SDATA signal from the keyboard. Also, I created a 22 bits shift register to capture the key up code and the scan code. The data will be displayed on the seven-segment displays, which is a pre-built module own by others with permission. However, I don't have the permission to publish the seven segment module, so it won't be uploaded here.
