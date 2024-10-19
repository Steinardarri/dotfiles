Steam Linux Runtime 3.0 (sniper)
================================

This container-based release of the Steam Runtime is used for native
Linux games, and for Proton 8.0+.

For general information please see
<https://gitlab.steamos.cloud/steamrt/steam-runtime-tools/-/blob/main/docs/container-runtime.md>
and
<https://gitlab.steamos.cloud/steamrt/steamrt/-/blob/steamrt/sniper/README.md>

Release notes
-------------

Please see
<https://gitlab.steamos.cloud/steamrt/steamrt/-/wikis/Sniper-release-notes>

Known issues
------------

Please see
<https://github.com/ValveSoftware/steam-runtime/blob/master/doc/steamlinuxruntime-known-issues.md>

Reporting bugs
--------------

Please see
<https://github.com/ValveSoftware/steam-runtime/blob/master/doc/reporting-steamlinuxruntime-bugs.md>

Development and debugging
-------------------------

The runtime's behaviour can be changed by running the Steam client with
environment variables set.

`STEAM_LINUX_RUNTIME_LOG=1` will enable logging. Log files appear in
`SteamLinuxRuntime_sniper/var/slr-*.log`, with filenames containing the app ID.
`slr-latest.log` is a symbolic link to whichever one was created most
recently.

`STEAM_LINUX_RUNTIME_VERBOSE=1` produces more detailed log output,
either to a log file (if `STEAM_LINUX_RUNTIME_LOG=1` is also used) or to
the same place as `steam` output (otherwise).

`PRESSURE_VESSEL_SHELL=instead` runs an interactive shell in the
container instead of running the game.

Please see
<https://gitlab.steamos.cloud/steamrt/steam-runtime-tools/-/blob/main/docs/distro-assumptions.md>
for details of assumptions made about the host operating system, and some
advice on debugging the container runtime on new Linux distributions.

Game developers who are interested in targeting this environment should
check the SDK documentation <https://gitlab.steamos.cloud/steamrt/sniper/sdk>
and general information for game developers
<https://gitlab.steamos.cloud/steamrt/steam-runtime-tools/-/blob/main/docs/slr-for-game-developers.md>.

Licensing and copyright
-----------------------

The Steam Runtime contains many third-party software packages under
various open-source licenses.

For full source code, please see the version-numbered subdirectory of
<https://repo.steampowered.com/steamrt-images-sniper/snapshots/>
corresponding to the version numbers listed in VERSIONS.txt.
