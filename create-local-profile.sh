#!/bin/bash

set -e
set -u

readonly local_repo=/usr/local/portage
readonly profile_name=merged-profile

readonly parent=$(cat <<END
gentoo:default/linux/amd64/13.0/desktop/gnome/systemd
dell-vostro-3560:targets/notebook/native
dkorotych-overlay:targets/desktop
END
)

readonly local_conf=$(cat <<END
[local]
location = $local_repo
masters = gentoo
auto-sync = no
priority = 1000
END
)

readonly layout_conf=$(cat <<END
masters = gentoo
thin-manifests = true
END
)

readonly profile_path=$local_repo/profiles/$profile_name
readonly repository_config_file=/etc/portage/repos.conf/local.conf

sudo mkdir -p $local_repo/{metadata,profiles/$profile_name}
sudo chown -R portage:portage $local_repo
sudo chmod g+w -R $local_repo

for parent_line in $parent
do
	array=(${parent_line//:/ })
	repository=${array[0]}
	profile=${array[1]}
	realpath --relative-to=$profile_path "$(portageq get_repo_path / $repository)/profiles/$profile"
done > $profile_path/parent
echo "$(portageq envvar ARCH) $profile_name stable" > $profile_path/../profiles.desc
echo "$layout_conf" > $local_repo/metadata/layout.conf

[[ ! -e $repository_config_file ]] && echo "$local_conf" > $repository_config_file

