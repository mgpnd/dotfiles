from i3pystatus import Status
from i3pystatus.updates import pacman

class Colors(object):
    COMMENT = "#969896"
    GREEN = "#87d7af"
    RED = "#cc6666"
    TEXT = "#c5c8c6"
    YELLOW = "#d7d7af"

status = Status(standalone=True)

status.register("clock",
    format="%X",)

status.register("clock",
    format="%a %-d %b",
    color = Colors.COMMENT,)

status.register("battery",
    format = " {status} {percentage:.0f}% left {remaining}",
    color = Colors.TEXT,
    full_color = Colors.GREEN,
    charging_color = Colors.YELLOW,
    critical_color = Colors.RED)

status.register("pulseaudio",
    format=" {volume}",
    color_unmuted=Colors.TEXT,
    format_muted=" {volume}",
    color_muted=Colors.RED,)

status.register("updates",
    color = Colors.GREEN,
    color_no_updates = Colors.COMMENT,
    format = "Updates: {count}",
    format_no_updates = "No updates",
    backends = [pacman.Pacman()])

status.register("disk",
    path="/home",
    hints={"markup": "pango"},
    format="home <span color=\"{0}\">{{used}}G [{{total}}G]</span>".format(Colors.TEXT),
    color=Colors.COMMENT,
    critical_limit=10,
    critical_color=Colors.RED,)

status.register("disk",
    path="/",
    hints={"markup": "pango"},
    format="root <span color=\"{0}\">{{used}}G [{{total}}G]</span>".format(Colors.TEXT),
    color=Colors.COMMENT,
    critical_limit=10,
    critical_color=Colors.RED,)

status.register("mem",
    hints={"markup": "pango"},
    format="MEM <span color=\"{0}\">{{used_mem}}M</span>".format(Colors.TEXT),
    color=Colors.COMMENT,
    warn_color=Colors.YELLOW,
    alert_color=Colors.RED)

status.register("temp",
    hints={"markup": "pango"},
    format="CPU temp <span color=\"{0}\">{{temp:.0f}}°C</span>".format(Colors.TEXT),
    file="/sys/class/thermal/thermal_zone2/temp",
    color=Colors.COMMENT,
    alert_temp=50,
    alert_color=Colors.RED,)

status.register("cpu_usage",
    hints={"markup": "pango"},
    format="CPU <span color=\"{0}\">{{usage:02}}%</span>".format(Colors.TEXT),
    color=Colors.COMMENT,)

status.run()
