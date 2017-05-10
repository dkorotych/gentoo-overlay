# gentoo-overlay
Desktop and [Java](https://go.java/developer-opportunities/index.html) oriented personal [Gentoo](https://gentoo.org/) overlay

## How to use this overlay
### With Layman

Invoke the following:
```
layman -o https://raw.github.com/dkorotych/gentoo-overlay/master/repositories.xml -f -a dkorotych-overlay
```
Or read the instructions on the [Gentoo Wiki](http://wiki.gentoo.org/wiki/Layman#Adding_custom_overlays).

### With local overlays

[Local overlays](https://wiki.gentoo.org/wiki/Overlay/Local_overlay) should be managed via `/etc/portage/repos.conf/`.
To enable this overlay make sure you are using a recent Portage version (at least `2.2.14`), and create a `/etc/portage/repos.conf/dkorotych-overlay.conf` file containing precisely:

```
[dkorotych-overlay]
location = /usr/local/portage/dkorotych-overlay
sync-type = git
sync-uri = https://github.com/dkorotych/gentoo-overlay.git
```
Afterwards, simply run `emerge --sync`, and Portage should seamlessly make all our datas available.
