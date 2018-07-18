# stm32f746disco-enet

Step 1: Build and run the docker image. The docker image contains the necessary toolchain for cross-compilation and unit test support.
  > docker build -t docker-stm32-builder .

  > docker run -it --name docker-stm32-builder -p 4444:4444 -v "$(pwd)/app":/usr/src/app --privileged -v /dev/bus/usb:/dev/bus/usb docker-stm32-builder /bin/bash

Step 2: Run unit test. This compiles the units using the host compiler and tests the logic using the tests in _/test_.
  > ceedling test:all

Step 3: Run make to generate the target binaries
  > make

Step 4: Load the binaries over JTAG
  > openocd -f board/stm32f7discovery.cfg -c "program ./build/stm32f746disco-enet.elf verify reset exit"

Step 5: Debugging
  > openocd -f board/stm32f7discovery.cfg &

  > ../opt/gcc-arm-none-eabi-7-2018-q2-update/bin/arm-none-eabi-gdb

  > target remote localhost:3333

I'm still working on the debugging aspect. I can debug on my local machine with OpenOCD, and run the command below to get a nice browser based gdb debugger front-end.

> gdbgui -g /home/warranyu/opt/gcc-arm-none-eabi-7-2018-q2-update/bin/arm-none-eabi-gdb "./build/stm32f746disco-enet.elf"

You can install gdbgui with

> pip install gdbgui --upgrade

When finished, you can remove the docker image by running:
  > docker rm docker-stm32-builder


Note: To setup openOCD to work with RTOS, you need to edit the target cfg file (located at /usr/local/share/openocd/scripts/target/stm32f7x.cfg). Add the -rtos FreeRTOS flag to the line as shown:
  > $_TARGETNAME configure -rtos FreeRTOS

This has been taken care of if using Docker. However, it will need to be done if running OpenOCD locally. Use the command below to append the -rtos FreeRTOS flag to line 48 of the config file.
  > sudo sed -i -e 48's/$/ -rtos FreeRTOS &/' /usr/local/share/openocd/scripts/target/stm32f7x.cfg
