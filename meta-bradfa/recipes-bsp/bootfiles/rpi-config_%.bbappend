FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Set config.txt to support Waveshare CAN + dual RS-485 hat per:
# https://www.waveshare.com/wiki/RS485_CAN_HAT_(B)
do_deploy:append:raspi5-can-rs485() {
    echo "# Support Waveshare CAN + dual RS-485 hat" >> $CONFIG
    echo "dtparam=spi=on" >> $CONFIG
    echo "dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=25,spimaxfrequency=1000000" >> $CONFIG
    echo "dtoverlay=sc16is752-spi1,int_pin=24" >> $CONFIG
    echo >> $CONFIG
    echo "# Set RTC battery charging to 3V" >> $CONFIG
    echo "dtparam=rtc_bbat_vchg=3000000" >> $CONFIG
}
