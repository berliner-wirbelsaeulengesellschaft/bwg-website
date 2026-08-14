#!/usr/bin/env bash
set -euo pipefail

production_origin="https://www.xn--berlinerwirbelsule-ztb.de"

if [[ -z "${INDEXNOW_KEY:-}" ]]; then
  printf '%s\n' "INDEXNOW_KEY fehlt. Erst nach dem Produktionsstart einen Schlüssel erzeugen und als Umgebungsvariable setzen." >&2
  exit 1
fi

if [[ ! "$INDEXNOW_KEY" =~ ^[A-Za-z0-9-]{8,128}$ ]]; then
  printf '%s\n' "INDEXNOW_KEY muss aus 8 bis 128 Buchstaben, Ziffern oder Bindestrichen bestehen." >&2
  exit 1
fi

if [[ "$#" -eq 0 ]]; then
  printf '%s\n' "Mindestens eine vollständige Produktions-URL muss übergeben werden." >&2
  exit 1
fi

key_file="${INDEXNOW_KEY}.txt"
if [[ ! -f "$key_file" ]] || [[ "$(tr -d '\r\n' < "$key_file")" != "$INDEXNOW_KEY" ]]; then
  printf '%s\n' "Die Schlüsseldatei $key_file fehlt im Repository-Root oder enthält nicht exakt den Schlüssel." >&2
  exit 1
fi

for url in "$@"; do
  case "$url" in
    "$production_origin"/*) ;;
    *)
      printf '%s\n' "Abbruch: $url ist keine URL der kanonischen Produktionsdomain." >&2
      exit 1
      ;;
  esac
done

for url in "$@"; do
  curl --fail --show-error --silent --get \
    --data-urlencode "url=$url" \
    --data-urlencode "key=$INDEXNOW_KEY" \
    --data-urlencode "keyLocation=$production_origin/$key_file" \
    "https://api.indexnow.org/indexnow"
  printf 'IndexNow übermittelt: %s\n' "$url"
done
