#!/bin/bash

############################### DISCLAIMER ################################
# This script now uses someone elses work!                                #
# Please visit https://github.com/revr3nd/plex-nvdec/                     #
# for the author of the new transcode wrapper, and show them your support!#
# Any issues using this script should be reported at:                     #
# https://github.com/Xaero252/unraid-plex-nvdec/issues/                   #
###########################################################################

# This is the download location for the raw script off github. If the location changes, change it here
plex_nvdec_url="https://raw.githubusercontent.com/revr3nd/plex-nvdec/master/plex-nvdec-patch.sh"
patch_container_path="/usr/lib/plexmediaserver/plex-nvdec-patch.sh"

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
wget -qO- --show-progress --progress=bar:force:noscroll "${plex_nvdec_url}" | docker exec -i "$con"  /bin/sh -c "cat > ${patch_container_path}" 

# Make the patch script executable.
docker exec -i "$con" chmod +x "${patch_container_path}"

# Run the script, with arguments for codecs, if present.

if [ "$codec_arguments" ]; then
	docker exec -i "$con" /bin/sh -c "${patch_container_path}${codec_arguments}"
else
	docker exec -i "$con" /bin/sh -c "${patch_container_path}"
fi
