# Laboratorio de seguridad IaC

Practica academica de Sergio Geovany Garcia Smith. Estado: ejemplos inseguros preparados; linea base pendiente de ejecucion.

## Alcance

Analisis estatico de Terraform, Ansible y Dockerfile con Checkov y ansible-lint.
Los archivos contienen errores intencionales y contrasenas ficticias tomadas de la guia.
No ejecutar `terraform apply`, el playbook contra servidores ni construir esta imagen.
No se requiere cuenta en AWS. El inventario utiliza una direccion de documentacion.

## Preparacion en Ubuntu / WSL

Trabajar dentro del sistema de archivos Linux, como indica la guia.
Copiar esta carpeta a `~/iac-lab` antes de instalar dependencias.

```bash
sudo apt update
sudo apt install -y python3 python3-venv python3-pip git
cd ~/iac-lab
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
```

Las versiones de herramientas aun deben comprobarse antes de fijarlas: los numeros del PDF son ejemplos, no instalaciones verificadas.

Una vez instaladas Checkov, ansible-core y ansible-lint:

```bash
bash scripts/linea-base.sh
```

El script conserva resultados y codigos de salida por escaneo. Continua entre analisis para recoger toda la evidencia de la version insegura; no es el gate del futuro pipeline.

## Secuencia de trabajo

1. Confirmar entorno y fijar versiones compatibles.
2. Ejecutar linea base; registrar conteos reales y cinco riesgos prioritarios.
3. Conservar version insegura en Git antes de remediar.
4. Corregir al menos ocho hallazgos, agrupando commits por tipo de correccion.
5. Documentar exactamente una excepcion y validar politica propia con fallo y exito.
6. Configurar GitHub Actions, SARIF y proteccion de main.
7. Conservar dos PR: demostracion insegura cerrada sin fusionar y remediacion fusionada en verde.
8. Completar informe con capturas y enlaces reales.

No se ha creado una excepcion ni se ha simulado una aprobacion.
La politica de respaldos esta preparada, pero todavia no ha sido ejecutada.
La futura entrega declarara el uso de IA para preparar archivos, interpretar resultados y apoyar la documentacion; las evidencias deberan proceder de ejecuciones reales.
