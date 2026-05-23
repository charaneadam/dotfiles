#!/usr/bin/env python3
import subprocess
import json

def get_podman_containers():
    try:
        # Run podman ps with JSON formatting
        # -a includes stopped containers
        result = subprocess.run(
            ["podman", "ps", "-a", "--format", "json"],
            capture_output=True,
            text=True,
            check=True
        )
        return json.loads(result.stdout)
    except Exception:
        return []

containers = get_podman_containers()

# Count statuses
running = [c for c in containers if c['Status'].startswith('Up')]
stopped = [c for c in containers if not c['Status'].startswith('Up')]

# Build the tooltip string
tooltip_lines = ["📦 Podman Containers", "-------------------"]
if not containers:
    tooltip_lines.append("No containers found.")
else:
    for c in containers:
        status_icon = "🟢" if c in running else "🔴"
        name = c['Names'][0] if isinstance(c['Names'], list) else c['Names']
        tooltip_lines.append(f"{status_icon} {name} ({c['Status']})")

# show 'Running/Total'
icon = "📦"
icon = "\uf4b7"
text = f"{icon} {len(running)}/{len(containers)}"

print(json.dumps({
    "text": text,
    "tooltip": "\n".join(tooltip_lines),
    "class": "running" if running else "stopped"
}))
