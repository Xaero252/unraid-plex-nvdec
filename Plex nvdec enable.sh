#!/bin/bash

############################### DISCLAIMER ################################
# This script now uses someone elses work!                                #
# Please visit https://github.com/revr3nd/plex-nvdec/                     #
# for the author of the new transcode wrapper, and show them your support!#
# Any issues using this script should be reported at:                     #
# https://gist.github.com/Xaero252/9f81593e4a5e6825c045686d685e2428       #
###########################################################################

# This is the download location for the raw script off github. If the location changes, change it here
plex_nvdec_url="https://raw.githubusercontent.com/revr3nd/plex-nvdec/master/plex-nvdec-patch.sh"

# This should always return the name of the docker container running plex - assuming a single plex docker on the system.
con="$(docker ps --format "{{.Names}}" | grep -i plex)"

# Uncomment and change the variable below if you wish to edit which codecs are decoded:
#CODECS=("h264" "hevc" "mpeg2video" "mpeg4" "vc1" "vp8" "vp9")

# Turn the CODECS array into a string of arguments for the wrapper script:
if [ "$CODECS" ]; then
	codec_arguments=""
	for format in "${CODECS[@]}"; do
		codec_arguments+=" -c ${format}"
	done
fi

echo -n "<b>Applying hardware decode patch... </b><br/>"
	
# Grab the latest version of the plex-nvdec-patch.sh from github:
echo 'Downloading patch script...'
docker exec -i "$con"  /bin/sh -c "wget -q --show-progress --progress=bar:force:noscroll -P /usr/lib/plexmediaserver/ ${plex_nvdec_url}"

# Make the patch script executable.
docker exec -i "$con" chmod +x "/usr/lib/plexmediaserver/plex-nvdec-patch.sh"

# Run the script, with arguments for codecs, if present.

command="/usr/lib/plexmediaserver/plex-nvdec-patch.sh"
if [ "$codec_arguments" ]; then
	command+="${codec_arguments}"
	docker exec -i "$con" /bin/sh -c "${command}${codec_arguments}"
else
	docker exec -i "$con" /bin/sh -c "${command}"
fi