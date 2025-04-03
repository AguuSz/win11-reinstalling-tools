# LISTADO DE CARACTERÍSTICAS DE AUTOUNATTEND.XML

Este archivo es una buena base de todo lo que realiza el `autounattend.xml`. **Recomiendo** fuertemente pegarle una leida a lo que hace, de modo que si hay algo que no te guste/no quieras que se elimine, puedas remover la linea que corresponda.

## FASE DE INSTALACIÓN

1. **Bypass de requisitos de Windows 11:**
   - Bypass de comprobación TPM
   - Bypass de comprobación Secure Boot
   - Bypass de comprobación de almacenamiento
   - Bypass de comprobación de CPU
   - Bypass de comprobación de RAM
   - Bypass de comprobación de disco

2. **Configuración de OOBE:**
   - Oculta la página de EULA
   - Oculta la pantalla de registro de OEM
   - Oculta las pantallas de cuenta online
   - Oculta la configuración inalámbrica
   - Establece la ubicación de red como "Trabajo"
   - Protección PC configurada a nivel 3

## ELIMINACIÓN DE BLOATWARE

3. **Elimina aplicaciones preinstaladas:**
   - Microsoft 3D Viewer, Bing Search, Cámara
   - Clipchamp, Windows Alarms, DevHome
   - Microsoft Family, Feedback Hub, GetHelp
   - Apps de comunicación, Mapas, Zune
   - Bing News, Office Hub, OneNote
   - Outlook, Paint, People
   - Power Automate Desktop, QuickAssist
   - Skype, Screen Sketch, Solitaire
   - Sticky Notes, MSTeams, Get Started
   - Todos, Sound Recorder, Weather
   - Zune Music, Xbox, YourPhone
   - Microsoft Edge y componentes relacionados
   - OneDrive

4. **Elimina capacidades y características heredadas:**
   - Internet Explorer, MathRecognizer
   - MSPaint, PowerShell ISE
   - QuickAssist, StepsRecorder, WordPad
   - Snipping Tool heredada

## OPTIMIZACIONES DEL SISTEMA

5. **Configuración de registro para el equipo local:**
   - Bypass de creación de cuenta Microsoft
   - Desactiva Windows Spotlight
   - Configura fondo de pantalla de Windows normal
   - Previene instalación de Dev Home
   - Previene instalación de Outlook
   - Previene instalación automática de Chat
   - Habilita rutas de archivo largas (32,767 caracteres)
   - Desactiva Noticias e Intereses
   - Desactiva características para consumidores
   - Desactiva encriptación automática de Bitlocker
   - Configura Windows Update solo para actualizaciones de seguridad
   - Retrasa otras actualizaciones por 1 año
   - Desactiva Cortana
   - Desactiva historial de actividad
   - Desactiva hibernación
   - Desactiva seguimiento de ubicación
   - Desactiva telemetría
   - Desactiva Windows Ink Workspace
   - Desactiva notificaciones de feedback
   - Desactiva ID de publicidad
   - Desactiva informes de errores
   - Desactiva optimización de entrega
   - Desactiva asistencia remota
   - Busca primero en Windows Update los controladores
   - Da mayor prioridad a aplicaciones multimedia
   - No limpia el archivo de memoria virtual al apagar
   - Habilita servicio NDU en inicio
   - Aumenta tamaño de pila IRP para mejorar red
   - Oculta botón Meet Now
   - Configura mayor prioridad para tarjetas gráficas
   - Configura mayor prioridad de CPU para juegos

6. **Servicios:**
   - Configura numerosos servicios a manual o desactivados
   - Configura servicios críticos a inicio automático
   - Elimina OneDrive
   - Elimina Microsoft Teams
   - Desactiva Teredo para IPv6

## OPTIMIZACIONES DE RENDIMIENTO

7. **Plan de energía:**
   - Habilita y activa el plan de energía "Ultimate Performance"

8. **Optimizaciones de rendimiento de juegos:**
   - Desactiva Xbox GameDVR
   - Configuraciones para mejorar rendimiento de juegos
   - Mayor prioridad para tarjetas gráficas y CPU

## PERSONALIZACIÓN DE INTERFAZ

9. **Modificaciones de la interfaz:**
   - Alinea barra de tareas a la izquierda (Windows 11)
   - Oculta icono de búsqueda en barra de tareas
   - Oculta People en barra de tareas
   - Oculta botón Vista de tareas
   - Oculta Noticias e intereses
   - Oculta notificaciones
   - Modo oscuro para apps y sistema
   - Desactiva Modo Tablet
   - Configura explorador para abrir "Este equipo" en vez de Acceso rápido
   - Muestra extensiones de archivo
   - Agrega "Tomar propiedad" al menú contextual
   - Restaura menú contextual clásico en Windows 11
   - Restaura Visor de fotos de Windows como predeterminado
   - Hace barra de tareas transparente (Windows 10)
   - Hace barra de tareas pequeña (Windows 10)
   - Habilita NumLock al inicio

10. **Configuración de privacidad:**
    - Desactiva sincronización de cuenta
    - Desactiva personalización de entrada
    - Desactiva seguimiento de documentos recientes
    - Desactiva apps en segundo plano
    - Desactiva diagnósticos de aplicaciones
    - Desactiva descarga automática de mapas
    - Desactiva Recall en PC con Copilot+

11. **Rendimiento visual:**
    - Optimiza configuración visual para rendimiento
    - Desactiva efectos visuales
    - Desactiva Snap Assist Flyout
    - Reduce retraso de menú
    - Desactiva animaciones de arrastrar ventanas

## HERRAMIENTAS ADICIONALES

12. **Scripts y utilidades:**
    - Agrega acceso directo a Chris Titus Windows Utility en el escritorio
    - Configura PowerShell para permitir ejecución de scripts
    - Agrega "Tomar propiedad" al menú contextual
    - Elimina completamente Microsoft Edge con scripts adicionales

13. **Desactivación de rastreo y telemetría:**
    - Desactiva tareas programadas relacionadas
    - Desactiva CEIP (Programa de mejora de experiencia del cliente)
    - Desactiva varias opciones de telemetría y rastreo
    - Desactiva muestreo automático de retroalimentación
    - Bloquea actualizaciones automáticas de Windows 10 a Windows 11
