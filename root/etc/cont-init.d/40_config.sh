#!/usr/bin/with-contenv bash

# Create Folders & Simlinks, if missing
if [ ! -d "/opt/amridm2mqtt" ]; then
	mkdir -p /opt/amridm2mqtt/
fi

# Copy over default files & create symlinks
if [ ! -L "/opt/amridm2mqtt/settings.py" ]; then
    ln -s /config/settings.py /opt/amridm2mqtt/settings.py
fi

if [ ! -f "/config/settings.py" ]; then
    cp /opt/amridm2mqtt/settings_template.py /config/settings.py
fi

# permissions
chown -R abc:abc \
	/config