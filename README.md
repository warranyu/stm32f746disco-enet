# stm32f746disco-enet

Step 1: Build and run the docker image. The docker image contains the necessary toolchain for cross-compilation and unit test support.
  > docker build -t docker-stm32-builder .

  > docker run -it --name docker-stm32-builder -p 4444:4444 -v "$(pwd)/app":/usr/src/app --privileged -v /dev/bus/usb:/dev/bus/usb docker-stm32-builder /bin/bash

Step 2: Run unit test. This compiles the units using the host compiler and tests the logic using the tests in _/test_.
  > ceedling test:all

Step 3: Run make to generate the target binaries
  > make

Step 4: Load the binaries over JTAG
