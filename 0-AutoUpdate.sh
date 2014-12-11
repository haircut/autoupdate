#!/usr/bin/env bash

###
#
#            Name:  0-AutoUpdate.sh
#     Description:  Runs policies with triggers named AutoUpdate-XXX if application XXX is not running
#          Author:  Matthew Warren <bmwarren@unca.edu>
#         Created:  2014-04-22
#   Last Modified:  2014-12-11
#         Version:  0.1
#
###

# Variables
AutoUpdateApps=(

    );

# If the following apps are running, no updates should be installed.
# Examples are presentation apps – we don't want to interrupt instruction
BlockingApps=(
    "Microsoft PowerPoint"
    "Keynote"
    );

# Binaries
jamf=/usr/sbin/jamf
# tn=/path/to/terminal-notifier

# Check for blocking apps
echo "AutoUpdate: Checking for Blocking Apps before proceeding"
for blocker in "${BlockingApps[@]}"; do
    if [[ `ps ax | grep -v grep | grep "$blocker" | wc -l` -gt 0 ]]; then
        echo "AutoUpdate: Blocking App '${blocker}' is running so we'll skip AutoUpdates"
        # Write to preference file for blocked update
        exit 0
    else
        echo "AutoUpdate: No Blocking Apps are running; proceed with AutoUpdates"
    fi
done

# Check each AutoUpdate app to see if it's running, and update if not
echo "AutoUpdate: Checking apps for update availability"
for app in "${AutoUpdateApps[@]}"; do
    if [[ running ]]; then
        # running, no update
    else
        # not running, update
        $jamf policy -event "AutoUpdate-$recipe"
    fi
done

