# unraid-plex-nvdec

## DISCLAIMER
__This script now uses someone elses work!__

Please visit https://github.com/revr3nd/plex-nvdec/ for the author of the new transcode wrapper, and show them your support!
Any issues resulting from using this script should be reported either on this repository, or on the unraid forums here:

## BEFORE YOU BEGIN
Ensure that Plex, and the unraid-nvidia environment is working properly. Follow the instructions from the LinuxServer.io team to configure Plex to use the nvidia container runtime and pass through your card. Make sure you can transcode videos with that environment __before__ attempting to use this script.

If you've manually applied, or installed any other version of this script prior to one using revr3nd's wrapper - please force update your Plex docker before proceeding.

### REQUIREMENTS
* Working Plex and Unraid-Nvidia setup.
* User Scripts plugin from Community Apps.
* A little bit of time.

### First time setup
1. Create a new script in the "User Scripts plugin" by clicking the "Add new Script" button on the "User Scripts" page in Settings.
2. Enter a name for the script, "Plex nvdec enable" is the name I use, but you can name it anything you like.
3. Click the name of the script, and then click "Edit Script."
4. Delete the contents of the edit pane.
5. Copy the contents of [Plex nvdec enable.sh](Plex nvdec enable.sh) from this repository into the empty edit pane.
6. Click Save Changes.
7. Click "Run Script" next to the script on the User Scripts page.
8. (Optional) Set a schedule to run the script. Highly recommended to reapply the patch each time Plex is updated.

## Updating

To update, simply edit the script, and paste the new code in. This script shouldn't be updated very often, as it is just pulling someone else's generic transcode wrapper.

## FAQ

* __Is there any way to get this script to run automatically when Plex updates?__  _No. There isn't currently an event available to monitor the update of Docker containers. It could be done, but it would have to be done outside of this script. You can however set the script to run every day after you schedule your containers to update._
