## rtl8188eus v5.3.9

# Realtek rtl8188eus &amp; rtl8188eu &amp; rtl8188etv WiFi driver
<b>This driver supports:</b><br>
* frame injection
* monitor mode
* MESH mode
* .. and kernels up to v5.0+ (rc3 tested)
<br>
<br>
This is a pure Realtek release, not from vendor but from all the Realtek multichip "bases"<br>
we've seen, this must be the newest, most stable and effective one.<br>
The performance and code quality has been improved and thats about time.
<br>
# HowTo build/install
1. You will need to blacklist another driver in order to use this one instead of the kernel provided.
Create a file named "rtl8188eus.conf", add a 1 liner to it: "blacklist r8188eu"
<br>
2. Then move the file to "/etc/modprobe.d/"
<br>
3. "make && make install"
4. "rmmod r8188eu && insmod rtl8188eus"
<br>
# MONITOR MODE ATTENTION
<b>There is a bug or interferrence with the driver and/or Network-Manager, so if you wan't to use
  the monitor mode, DON'T kill the network-manager (infact)</b>
<br>

# TODO
* Finish the walkthrough of the base for understanding.
* There is a bug in monitor mode related to Network-Manager.
  This needs priority because it causes interferrence.
* Add more VID/PIDS for all 3 chipsets supported.
<br>
more tba..
