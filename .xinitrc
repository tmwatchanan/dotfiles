# Activate Numlock on Bootup
#numlockx &

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --output eDP1 --scale 1x1 --pos 1368x768 --primary
exec i3
