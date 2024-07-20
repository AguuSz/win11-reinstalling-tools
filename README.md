# 🛠️ Win11 Reinstalling Tools

Here is a set of things that I use when reinstalling Windows on my main machine. It includes a script that removes all bloatware, sets up some privacy settings, and applies other tweaks. You can customize what the script does by editing `autounattend.xml`. This file was copied from [memstechtips](https://github.com/memstechtips/UnattendedWinstall) and edited to fit my needs. Feel free to modify it.

## 💻 Autounattend

To use this file, all you need to do is have a bootable USB with a copy of Windows 11 (grab it from Microsoft). Then drop the file onto the USB and that's it! When you boot up your USB, the installation will be slightly different because it disables some things like forcing you to sign in and allows you to use a fully local account. It's common that some terminal screens flash once in a while because it's running some scripts pre-install and post-install (to remove Microsoft bloatware and other things).

Take a look at the file itself and decide if you need to remove some of the things that the file does. I've deleted everything that I don't need, but it might not fit your needs. If this is the case, just erase the line where it should remove the app, and the script won't remove it.

If this is rather confusing, take a look at the [YouTube video](https://www.youtube.com/watch?v=JUTdRZNqODY) where I got the file from, which includes a tutorial.

## 🎛️ Afterburner and Rivatuner Settings

This folder contains the configuration files for Rivatuner to look like this:

![Screenshot of Rivatuner](https://i.imgur.com/i4tzMM3.png)

Afterburner is a software that allows you to modify overclocks (OCs) for the GPU and tweak the voltage curve. In this case, the OC settings have not been touched. It only includes what's necessary for Rivatuner, which is a software for monitoring in-game performance of the PC in general. It displays stats such as GPU load, current temperature, fan percentages, etc.

The default interface wasn't enough for me, so I tweaked it a little. Feel free to edit it with your system's hardware (edit file `MSI Afterburner/Profiles/MSIAfterburner.cfg`):

- **CPU:** Go to line 351 and change "Ryzen 7..." with your CPU. This option also has the color `#25B9CA`. You can change it with `C=<HexCodeForColor>`.
- **GPU:** Go to line 171 and change "RTX ..." with your GPU.
- **RAM:** Go to line 371 and change the name of the group. This is purely visual, but I prefer to display how many sticks of RAM and their capacity.
