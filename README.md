# 🛠️ Win11 Reinstalling Tools

Here is a set of things that I use when reinstalling Windows on my main machine. It includes a script that removes all bloatware, sets up some privacy settings, and applies other tweaks. You can customize what the script does by editing `autounattend.xml`. This file was copied from [memstechtips](https://github.com/memstechtips/UnattendedWinstall) and edited to fit my needs. Feel free to modify it.

## 🎛️ Afterburner and Rivatuner Settings

This folder contains the configuration files for Rivatuner to look like this:

![Screenshot of Rivatuner](https://i.imgur.com/i4tzMM3.png)

Afterburner is a software that allows you to modify overclocks (OCs) for the GPU and tweak the voltage curve. In this case, the OC settings have not been touched. It only includes what's necessary for Rivatuner, which is a software for monitoring in-game performance of the PC in general. It displays stats such as GPU load, current temperature, fan percentages, etc.

The default interface wasn't enough for me, so I tweaked it a little. Feel free to edit it with your system's hardware (edit file `MSI Afterburner/Profiles/MSIAfterburner.cfg`):

- **CPU:** Go to line 351 and change "Ryzen 7..." with your CPU. This option also has the color `#25B9CA`. You can change it with `C=<HexCodeForColor>`.
- **GPU:** Go to line 171 and change "RTX ..." with your GPU.
- **RAM:** Go to line 371 and change the name of the group. This is purely visual, but I prefer to display how many sticks of RAM and their capacity.
