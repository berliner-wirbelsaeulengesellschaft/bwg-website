#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" != "--confirm-production-go" ]]; then
  printf '%s\n' "Abbruch: Dieses Skript darf erst nach dem ausdrücklichen PRODUCTION GO ausgeführt werden."
  printf '%s\n' "Aufruf danach: scripts/prepare-production.sh --confirm-production-go"
  exit 1
fi

production_origin="https://www.xn--berlinerwirbelsule-ztb.de"

while IFS= read -r -d '' page; do
  if ! grep -Fq "$production_origin" "$page"; then
    printf 'Fehler: Produktionsdomain fehlt in %s.\n' "$page" >&2
    exit 1
  fi
done < <(find . -path './.git' -prune -o -path './outputs' -prune -o -path './work' -prune -o -name index.html -type f -print0)

cat > robots.txt <<'EOF'
User-agent: OAI-SearchBot
Allow: /

User-agent: GPTBot
Disallow: /

User-agent: *
Allow: /

Sitemap: https://www.xn--berlinerwirbelsule-ztb.de/sitemap.xml
EOF

printf '%s\n' 'www.xn--berlinerwirbelsule-ztb.de' > CNAME

printf '%s\n' "Produktionsdomain, CNAME und Crawlerregeln sind konsistent."
