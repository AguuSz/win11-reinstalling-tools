$ErrorActionPreference = 'Stop'

$ScriptDir = $PSScriptRoot
$AbRepo    = Join-Path $ScriptDir 'MSI Afterburner'
$RtRepo    = Join-Path $ScriptDir 'Rivatuner'
$CfgSrc    = Join-Path $AbRepo    'Profiles\MSIAfterburner.cfg'
$AbDest    = 'C:\Program Files (x86)\MSI Afterburner'
$RtDest    = 'C:\Program Files (x86)\RivaTuner Statistics Server'

if (-not (Test-Path -LiteralPath $CfgSrc)) {
    Write-Host "[ERROR] No se encontro: $CfgSrc" -ForegroundColor Red
    Write-Host "Ejecuta el .bat desde la carpeta 'Afterburner + Rivatuner settings'." -ForegroundColor Red
    exit 1
}

Write-Host '========================================' -ForegroundColor Cyan
Write-Host ' Setup Monitoring - Hardware del equipo ' -ForegroundColor Cyan
Write-Host '========================================' -ForegroundColor Cyan
Write-Host ''

$cpu = Read-Host 'CPU (ej. Ryzen 7 5800X)'
$gpu = Read-Host 'GPU (ej. RTX 3080 Ti)'

$vramGb = 0
while ($vramGb -le 0) {
    $raw = Read-Host 'VRAM en GB (ej. 12)'
    $parsed = 0
    if ([int]::TryParse($raw, [ref]$parsed) -and $parsed -gt 0) {
        $vramGb = $parsed
    } else {
        Write-Host 'Valor invalido, intenta de nuevo.' -ForegroundColor Yellow
    }
}
$vramMb = $vramGb * 1024

$ramOptions = @(
    @{ Label = '1x16gb'; Mb = 16384  },
    @{ Label = '2x8gb';  Mb = 16384  },
    @{ Label = '1x32gb'; Mb = 32768  },
    @{ Label = '2x16gb'; Mb = 32768  },
    @{ Label = '4x8gb';  Mb = 32768  },
    @{ Label = '2x32gb'; Mb = 65536  },
    @{ Label = '4x16gb'; Mb = 65536  },
    @{ Label = '2x48gb'; Mb = 98304  },
    @{ Label = '4x32gb'; Mb = 131072 }
)

Write-Host ''
Write-Host 'Configuracion de RAM:'
for ($i = 0; $i -lt $ramOptions.Count; $i++) {
    $opt = $ramOptions[$i]
    Write-Host ('  [{0}] {1,-8} ({2} GB)' -f ($i + 1), $opt.Label, ($opt.Mb / 1024))
}
Write-Host '  [C] Custom'
Write-Host ''

$ramConfig = $null
$ramMb     = 0
while ($null -eq $ramConfig) {
    $choice = Read-Host 'Elegi opcion'
    if ($choice -match '^[1-9]$' -and [int]$choice -le $ramOptions.Count) {
        $opt = $ramOptions[[int]$choice - 1]
        $ramConfig = $opt.Label
        $ramMb     = $opt.Mb
    } elseif ($choice -ieq 'C') {
        $label = Read-Host 'Label libre (ej. 3x16gb)'
        if ([string]::IsNullOrWhiteSpace($label)) {
            Write-Host 'Label vacio.' -ForegroundColor Yellow
            continue
        }
        $totalGb = 0
        while ($totalGb -le 0) {
            $raw = Read-Host 'Total en GB'
            $parsed = 0
            if ([int]::TryParse($raw, [ref]$parsed) -and $parsed -gt 0) {
                $totalGb = $parsed
            } else {
                Write-Host 'Valor invalido.' -ForegroundColor Yellow
            }
        }
        $ramConfig = $label
        $ramMb     = $totalGb * 1024
    } else {
        Write-Host 'Opcion invalida.' -ForegroundColor Yellow
    }
}

Write-Host ''
Write-Host '========================================' -ForegroundColor Cyan
Write-Host ' Resumen' -ForegroundColor Cyan
Write-Host '========================================' -ForegroundColor Cyan
Write-Host (' CPU:        {0}' -f $cpu)
Write-Host (' GPU:        {0}' -f $gpu)
Write-Host (' VRAM:       {0} GB ({1} MB)' -f $vramGb, $vramMb)
Write-Host (' RAM config: {0} ({1} MB total)' -f $ramConfig, $ramMb)
Write-Host ''
Write-Host 'A continuacion se va a:'
Write-Host '  - Cerrar MSI Afterburner y RTSS si estan corriendo'
Write-Host '  - Parchear MSIAfterburner.cfg en el repo'
Write-Host '  - Hacer backup de los archivos en destino y copiar los nuevos'
Write-Host "  - Destinos: $AbDest"
Write-Host "             $RtDest"
Write-Host ''
$null = Read-Host 'Enter para continuar (Ctrl+C para abortar)'

if (-not (Test-Path -LiteralPath $AbDest)) {
    Write-Host "[ERROR] MSI Afterburner no instalado en $AbDest" -ForegroundColor Red
    Write-Host 'Instalalo primero y volve a correr el script.' -ForegroundColor Red
    exit 1
}
if (-not (Test-Path -LiteralPath $RtDest)) {
    Write-Host "[ERROR] RivaTuner Statistics Server no instalado en $RtDest" -ForegroundColor Red
    Write-Host 'Instalalo primero y volve a correr el script.' -ForegroundColor Red
    exit 1
}

Write-Host ''
Write-Host 'Cerrando procesos...'
Get-Process -Name MSIAfterburner -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Get-Process -Name RTSS          -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Write-Host 'Parcheando MSIAfterburner.cfg...'
$lines = Get-Content -LiteralPath $CfgSrc
$currentSection = ''
$out = New-Object System.Collections.Generic.List[string]

foreach ($line in $lines) {
    if ($line -match '^\[(.+)\]$') {
        $currentSection = $matches[1]
        $out.Add($line)
        continue
    }

    $newLine = $line
    switch ($currentSection) {
        'Source GPU usage' {
            if ($line.StartsWith('Group=')) {
                $newLine = "Group=<S=110><C=3ECA25>$gpu<C><S>"
            }
        }
        'Source Memory usage' {
            if ($line.StartsWith('MaxLimit=')) {
                $newLine = "MaxLimit=$vramMb"
            }
        }
        'Source CPU usage' {
            if ($line.StartsWith('Group=')) {
                $newLine = "Group=\n<S=100><C=25B9CA>$cpu<S><C>"
            }
        }
        'Source RAM usage' {
            if ($line.StartsWith('Group=')) {
                $newLine = "Group=RAM $ramConfig"
            } elseif ($line.StartsWith('MaxLimit=')) {
                $newLine = "MaxLimit=$ramMb"
            }
        }
    }
    $out.Add($newLine)
}

[System.IO.File]::WriteAllLines($CfgSrc, $out, (New-Object System.Text.ASCIIEncoding))
Write-Host '  OK' -ForegroundColor Green

$ts = Get-Date -Format 'yyyyMMdd-HHmmss'

function Backup-And-Copy {
    param([string]$src, [string]$dst)
    if (-not (Test-Path -LiteralPath $src)) {
        Write-Host "  [WARN] source no existe: $src" -ForegroundColor Yellow
        return
    }
    $dstDir = Split-Path -Parent $dst
    if (-not (Test-Path -LiteralPath $dstDir)) {
        New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
    }
    if (Test-Path -LiteralPath $dst) {
        $bak = "$dst.bak.$ts"
        Move-Item -LiteralPath $dst -Destination $bak -Force
        Write-Host "  backup: $bak" -ForegroundColor DarkGray
    }
    Copy-Item -LiteralPath $src -Destination $dst -Force
    Write-Host "  copy:   $dst" -ForegroundColor Green
}

Write-Host ''
Write-Host 'Copiando archivos de MSI Afterburner...'
$abFiles = @(
    @{ Src = (Join-Path $AbRepo 'MSIAfterburner.cfg');     Dst = (Join-Path $AbDest 'MSIAfterburner.cfg') },
    @{ Src = $CfgSrc;                                       Dst = (Join-Path $AbDest 'Profiles\MSIAfterburner.cfg') },
    @{ Src = (Join-Path $AbRepo 'Profiles\Profile1.cfg');  Dst = (Join-Path $AbDest 'Profiles\Profile1.cfg') },
    @{ Src = (Join-Path $AbRepo 'Profiles\Profile2.cfg');  Dst = (Join-Path $AbDest 'Profiles\Profile2.cfg') }
)
foreach ($f in $abFiles) { Backup-And-Copy $f.Src $f.Dst }

Write-Host ''
Write-Host 'Copiando archivos de Rivatuner...'
$rtFiles = @(
    @{ Src = (Join-Path $RtRepo 'Profiles\Config');         Dst = (Join-Path $RtDest 'Profiles\Config') },
    @{ Src = (Join-Path $RtRepo 'Profiles\Global');         Dst = (Join-Path $RtDest 'Profiles\Global') },
    @{ Src = (Join-Path $RtRepo 'ProfileTemplates\Config'); Dst = (Join-Path $RtDest 'ProfileTemplates\Config') }
)
foreach ($f in $rtFiles) { Backup-And-Copy $f.Src $f.Dst }

Write-Host ''
$ans = Read-Host 'Relanzar MSI Afterburner ahora? [Y/N]'
if ($ans -ieq 'Y') {
    $exe = Join-Path $AbDest 'MSIAfterburner.exe'
    if (Test-Path -LiteralPath $exe) {
        Start-Process -FilePath $exe
        Write-Host 'Lanzado. RTSS deberia arrancar automaticamente vinculado.' -ForegroundColor Green
    } else {
        Write-Host "[WARN] No se encontro $exe" -ForegroundColor Yellow
    }
}

Write-Host ''
Write-Host '========================================' -ForegroundColor Green
Write-Host ' Listo!' -ForegroundColor Green
Write-Host '========================================' -ForegroundColor Green
Write-Host ''
Write-Host "Backups previos quedaron como *.bak.$ts en sus rutas de destino."
exit 0
