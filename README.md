# amridm2mqtt + Docker + LinuxServer.io = <3

## Pull the image

    docker pull bashninja/docker-amridm2mqtt-rpi

## Run the Python amridm2mqtt Application

    docker run --name amridm2mqtt -d \
        -v {path}:/config \
        --privileged \
        -v /dev/bus/usb:/dev/bus/usb \
        bashninja/docker-amridm2mqtt-rpi

## Configure the Application

* Ensure your rtl-sdr is plugged into the raspberry pi
* Open your {path} for `/config` and edit `settings.py` file
* Restart the container to apply settings: `docker restart amridm2mqtt`
* Fun