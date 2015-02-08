Tap Bot
=======

A Raspberry Pi mod to fit in a tap handle.

    # Install PiTFT hardware
    mkdir ~/tft
    cd ~/tft
    wget http://adafruit-download.s3.amazonaws.com/libraspberrypi-bin-adafruit.deb
    wget http://adafruit-download.s3.amazonaws.com/libraspberrypi-dev-adafruit.deb
    wget http://adafruit-download.s3.amazonaws.com/libraspberrypi-doc-adafruit.deb
    wget http://adafruit-download.s3.amazonaws.com/libraspberrypi0-adafruit.deb
    wget http://adafruit-download.s3.amazonaws.com/raspberrypi-bootloader-adafruit-112613.deb
    sudo dpkg -i -B *.deb


    # Test Screen
    # sudo reboot
    sudo modprobe spi-bcm2708
    sudo modprobe fbtft_device name=adafruitts rotate=180


    # Start screen at boot
    # sudo vi /etc/modules
    ## add lines: "spi-bcm2708" and "fbtft_device" to the bottom of the file

    # sudo vi /etc/modprobe.d/adafruit.conf
    ## add line "options fbtft_device name=adafruitts rotate=180 frequency=32000000" to the bottom of the file


    # Boot with command line on tap
    # sudo vi /boot/cmdline.txt
    ## add "fbcon=map:10 fbcon=font:VGA8x8" after "rootwait"


    # Update package manager
    sudo apt-get update
    sudo apt-get upgrade


    # Install zeroconf
    sudo apt-get install avahi-daemon


    # Install a non-broken version of Ruby to the Pi
    sudo apt-get install ruby1.9.1-dev


    # Install the Rubygame dependencies:
    sudo apt-get install libsdl1.2-dev libsdl-gfx1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev


    # Install bundler
    sudo gem install bundler


    # Install gems locally
    bundle install --deployment


    # Set TapBot to run on boot:
    # sudo vi /etc/init.d/rc.local
    ## add "sudo bash -c 'cd /home/pi/tap-bot/ && bin/tap_bot &>> log/tap-bot.log' &" at the bottom of the file


    # Edit the config file to add your key
    cd /home/pi/tap-bot
    cp config.yml.example config.yml
    vi config.yml


    # Start the client
    sudo bin/tap_bot

Logo
====

Logo is from (gifloop.tumblr.com)[http://gifloop.tumblr.com/post/11267061077/un-gif-dans-ta-gueule-source-blue-mountain]
