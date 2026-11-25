# RIESGO-001 - Replicacion S3 entre regiones

Estado: APROBADA, exclusivamente para este laboratorio academico.

| Campo | Valor |
| --- | --- |
| Control | CKV_AWS_144 |
| Recurso | aws_s3_bucket.datos |
| Aprobador academico | Sergio Geovany Garcia Smith |
| Fecha de aprobacion | 2026-11-25 |
| Vencimiento | 2027-01-31 |
| Alcance | Analisis estatico, sin despliegue ni datos reales |

## Aprobacion

El autor aprobo expresamente esta propuesta durante la preparacion del
laboratorio: "Si apruebo esta excepcion". Esta es una aceptacion academica
del autor, no una aprobacion de una organizacion ni de un responsable de
datos de produccion.

## Justificacion y riesgo residual

Se retira la configuracion de replicacion a otra region para demostrar una
unica excepcion documentada en Checkov. No hay infraestructura desplegada
ni datos reales. Si este codigo se desplegara sin replicacion, no proporcionaria
una replica independiente para recuperarse de una perdida regional.

Se conservan el bloqueo de acceso publico, el cifrado KMS, el versionado,
el registro de acceso y el ciclo de vida. Estos controles no sustituyen una
replica entre regiones ni garantizan recuperacion ante una perdida regional.

## Implementacion

La unica supresion ejecutable esta dentro de aws_s3_bucket.datos, en
infra/main.tf, y contiene el ID del control, esta referencia, el aprobador
y el vencimiento. Se eliminan las variables exclusivas de replicacion.
No se usan omisiones masivas ni se cambia el comportamiento de los gates.

## Verificacion pendiente

Volver a ejecutar Checkov y confirmar cero fallas y exactamente un control
omitido: CKV_AWS_144 sobre aws_s3_bucket.datos. Registrar las cifras reales,
incluido el total de controles aprobados, en el informe.

## Revision y cierre

La excepcion deja de ser aplicable al vencer, al incorporar datos reales o
al plantear un despliegue. En esos casos se debe restaurar la replicacion
y retirar la supresion, o realizar una nueva evaluacion con el responsable
de infraestructura y el propietario de los datos. La fecha se documenta;
Checkov no interpreta automaticamente su vencimiento.

La configuracion con replicacion de docs/remediacion-02.md y el escaneo
remediacion-02 describen el estado previo a esta excepcion y se conservan
como evidencia historica de la remediacion completa.
