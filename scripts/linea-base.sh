#!/usr/bin/env bash
# Analiza archivos; no despliega ni ejecuta el playbook.
set -u
set -o pipefail
cd "$(dirname "$0")/.."
out="reportes/linea-base"
mkdir -p "$out"
for tool in checkov ansible ansible-playbook ansible-lint; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    printf 'Falta herramienta: %s\n' "$tool" >&2
    exit 127
  fi
done
{
  date -u +%FT%TZ
  python --version
  checkov --version
  ansible --version
  ansible-lint --version
  python -m pip freeze
} > "$out/entorno.txt" 2>&1
printf 'comando\tcodigo_salida\n' > "$out/codigos.tsv"
run_scan() {
  local name="$1"
  shift
  "$@" > "$out/$name.txt" 2>&1
  local status=$?
  printf '%s\t%s\n' "$name" "$status" >> "$out/codigos.tsv"
  cat "$out/$name.txt"
}
run_scan checkov-completo checkov -d infra -d ansible -d docker --compact
run_scan terraform checkov -d infra --framework terraform --compact
run_scan ansible checkov -d ansible --framework ansible --compact
run_scan dockerfile checkov -f docker/Dockerfile --framework dockerfile --compact
run_scan secretos checkov -d infra -d ansible -d docker --framework secrets --compact
run_scan sintaxis ansible-playbook -i ansible/inventory.ini ansible/site.yml --syntax-check
run_scan ansible-lint ansible-lint --profile production ansible/site.yml
run_scan politica checkov -d infra --external-checks-dir politicas --check CKV2_CURSO_1 --compact
checkov -d infra -d ansible -d docker -o sarif --output-file-path "$out" > "$out/sarif-generacion.txt" 2>&1
printf 'sarif\t%s\n' "$?" >> "$out/codigos.tsv"
printf '\nEscaneos terminados. Revisar %s y sus codigos: errores de ejecucion no equivalen a hallazgos.\n' "$out"
