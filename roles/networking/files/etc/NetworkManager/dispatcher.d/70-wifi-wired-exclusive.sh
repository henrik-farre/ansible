#!/bin/bash
export LC_ALL=C

SYSLOG_TAG=$0

function log() {
    logger -i -t "$SYSLOG_TAG" "$1"
}

function enable_wifi() {
    nmcli radio wifi on
}

function disable_wifi() {
    nmcli radio wifi off
}

if [[ "$DEVICE_IFACE" == 'none' ]]; then
    log "Interface is '$DEVICE_IFACE', action is '$NM_DISPATCHER_ACTION', exiting"
    exit 0
fi

if [[ -n "$DEVICE_IFACE" ]]; then
    DEVICE_IFACE_TYPE=$(nmcli --get-values GENERAL.TYPE device show "$DEVICE_IFACE")
    DEVICE_IFACE_STATE=$(nmcli --get-values GENERAL.STATE device show "$DEVICE_IFACE")

    log "Interface: '$DEVICE_IFACE' of type '$DEVICE_IFACE_TYPE' is in state '$DEVICE_IFACE_STATE' and action is '$NM_DISPATCHER_ACTION'"

    if [ "$DEVICE_IFACE_TYPE" != "wifi" ] && [ "$NM_DISPATCHER_ACTION" == "down" ]; then
        log "   '$DEVICE_IFACE_TYPE' down - enabling wifi"
        enable_wifi
    elif [ "$DEVICE_IFACE_TYPE" != "wifi" ] && [ "$NM_DISPATCHER_ACTION" == "up"  ] && [ "$DEVICE_IFACE_STATE" == "100 (connected)" ]; then
        log "   '$DEVICE_IFACE_TYPE' connected - disabling wifi"
        disable_wifi
    elif [ -z "$DEVICE_IFACE_STATE" ] && [  -z "$DEVICE_IFACE_TYPE" ]; then
        log "   No device or unknown state - enabling wifi"
        enable_wifi
    fi
elif [[ $NM_DISPATCHER_ACTION == 'hostname' ]]; then
    log "No interface avaliable, action is '$NM_DISPATCHER_ACTION'"
    enable_wifi
fi
