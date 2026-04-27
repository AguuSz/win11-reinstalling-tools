# 🛠️ Win11 Reinstalling Tools

Scripts y configs que uso al reinstalar Windows 11: autounattend para debloat/privacidad y setup de MSI Afterburner + RTSS.

## Autounattend

`autounattend.xml` automatiza la instalación: skip login con cuenta Microsoft (cuenta local OK), remueve bloatware y aplica tweaks. Basado en [memstechtips/UnattendedWinstall](https://github.com/memstechtips/UnattendedWinstall).

**Uso:** copiar el `.xml` a la USB booteable de Windows 11. Listo.

Editá el archivo si querés conservar apps que el script remueve (borrá la línea correspondiente). Tutorial: [video](https://www.youtube.com/watch?v=JUTdRZNqODY).

## MSI Afterburner + RTSS

OSD personalizado para monitoring in-game (GPU/CPU load, temps, fans, FPS, frametime, etc).

![Screenshot](https://i.imgur.com/i4tzMM3.png)

### Setup automático

Con MSI Afterburner y RTSS ya instalados, correr `Afterburner + Rivatuner settings/setup-monitoring.bat`. Auto-eleva a admin y pregunta:

- **CPU** (ej. `Ryzen 7 5800X`)
- **GPU** (ej. `RTX 3080 Ti`)
- **VRAM** en GB
- **RAM**: menú con presets (`1x16`, `2x16`, `4x8`, `2x32`, etc.) o custom

Parchea el `.cfg`, cierra Afterburner/RTSS, hace backup `*.bak.<timestamp>` y copia todo a `C:\Program Files (x86)\MSI Afterburner\` y `...\RivaTuner Statistics Server\`. Los `VEN_*.cfg` (OCs específicos) no se tocan.

### Edición manual

Editar `MSI Afterburner/Profiles/MSIAfterburner.cfg`:

- **Línea 171** — GPU (color `#3ECA25`)
- **Línea 351** — CPU (color `#25B9CA`)
- **Línea 371** — label RAM
