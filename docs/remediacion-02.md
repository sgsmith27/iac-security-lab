# Segunda ronda de remediacion (pendiente de escaneo)

## Evidencia confirmada

La primera ronda obtuvo Terraform 24 aprobados / 15 fallidos; Ansible 6/0;
Dockerfile 26/0; politica propia 1/0; ansible-lint production 0 fallas y
0 advertencias. Secretos y sintaxis finalizaron con codigo 0.
La linea base original de Terraform tenia 15 aprobados / 24 fallidos.

## Cambios propuestos para los quince controles pendientes

| Controles | Cambio |
| --- | --- |
| CKV_AWS_353 | Performance Insights habilitado y clave KMS declarada. |
| CKV_AWS_129, CKV2_AWS_30 | Exportacion de logs y grupo de parametros PostgreSQL con registro de consultas. |
| CKV_AWS_157 | Multi-AZ habilitado. |
| CKV_AWS_161 | Autenticacion IAM habilitada. |
| CKV_AWS_118 | Enhanced Monitoring cada 60 segundos y rol externo requerido. |
| CKV_AWS_226 | Actualizaciones menores automaticas habilitadas. |
| CKV2_AWS_60 | Copia de etiquetas a snapshots habilitada. |
| CKV2_AWS_62 | Eventos del bucket enviados a EventBridge. |
| CKV_AWS_145 | Cifrado S3 con clave KMS externa requerida. |
| CKV_AWS_21 | Versionado habilitado. |
| CKV2_AWS_5 | Grupo de seguridad conectado a RDS, limitado a PostgreSQL desde red privada. |
| CKV2_AWS_61 | Retencion de versiones no actuales y limpieza de cargas incompletas. |
| CKV_AWS_144 | Replicacion declarada hacia un bucket externo en otra region. |
| CKV_AWS_18 | Entrega de logs a un bucket de auditoria externo requerido. |

## Limites y dependencias

Solo se analiza codigo. No ejecutar terraform apply. Las variables no tienen
defaults: no se inventaron ARNs ni se crearon dependencias reales en AWS.
VPC, subredes, claves KMS, roles y buckets externos deben existir y configurarse
correctamente en un despliegue real. Checkov no verifica su existencia ni sus
politicas externas; aprobar estas referencias no demuestra seguridad operativa.

El grupo de subredes debe pertenecer a la VPC indicada y cubrir dos zonas.
El bucket de logs debe admitir entregas S3; el destino de replicacion debe
tener versionado y estar en una region distinta. Sus politicas y los permisos
KMS requieren revision independiente.

PostgreSQL 16 se alinea con el grupo de parametros postgres16. Se exige TLS.
El registro de todas las consultas es ilustrativo: en produccion deben
evaluarse el volumen, la retencion, el acceso y la posible informacion sensible.

La validacion actual se limita a revision de cambios y espacios con Git.
No hay resultados Checkov ni terraform validate para esta ronda todavia.
No se agregaron excepciones: la unica excepcion exigida por la tarea se
propondra y aceptara explicitamente, sin inventar aprobaciones.

## Verificacion en Ubuntu

```bash
bash scripts/linea-base.sh reportes/remediacion-02
```

Conservar los resultados reales, incluso si aparecen reglas nuevas debido
a los recursos incorporados. No sobreescribir los escaneos anteriores.
