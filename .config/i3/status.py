from i3pystatus import Status
from i3pystatus.updates import pacman

status = Status(standalone=True)

status.register("clock",
    format="%a %-d %b %X",)

status.register("pulseaudio",
    format="♪{volume}",)

status.register("weather",
    format="SPB: {current_temp}",
    location_code="RSXX0091:1:RS",
    colorize=True,
    interval=600)

status.register("updates",
    format = "Updates: {count}",
    format_no_updates = "No updates",
    backends = [pacman.Pacman()])

status.register("disk",
    path="/home",
    format="home: {used}/{total}G [{avail}G]",)

status.register("disk",
    path="/",
    format="root: {used}/{total}G [{avail}G]",)

status.register("temp",
    format="CPU temp: {temp:.0f} °C",
    file="/sys/class/thermal/thermal_zone2/temp",
    alert_temp=60,)

status.register("mem",
    format="MEM: {percent_used_mem:02}%",
    color="#FFFFFF")

status.register("cpu_usage",
    format="CPU: {usage:02}%")

status.run()
