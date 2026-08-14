#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" != "--confirm-production-go" ]]; then
  printf '%s\n' "Abbruch: Dieses Skript darf erst nach dem ausdrücklichen PRODUCTION GO ausgeführt werden."
  printf '%s\n' "Aufruf danach: scripts/prepare-production.sh --confirm-production-go"
  exit 1
fi

preview_origin="https://berlinerwirbelsaeule.de"
production_origin="https://www.xn--berlinerwirbelsule-ztb.de"

while IFS= read -r -d '' page; do
  perl -0pi -e 's#<meta name="robots" content="noindex,nofollow">##g' "$page"
  PREVIEW_ORIGIN="$preview_origin" PRODUCTION_ORIGIN="$production_origin" perl -0pi -e '
    BEGIN {
      $preview = quotemeta($ENV{"PREVIEW_ORIGIN"});
      $production = $ENV{"PRODUCTION_ORIGIN"};
    }
    s/$preview/$production/g;
  ' "$page"
done < <(find . -path './.git' -prune -o -path './outputs' -prune -o -path './work' -prune -o -name index.html -type f -print0)

PREVIEW_ORIGIN="$preview_origin" PRODUCTION_ORIGIN="$production_origin" perl -0pi -e '
  BEGIN {
    $preview = quotemeta($ENV{"PREVIEW_ORIGIN"});
    $production = $ENV{"PRODUCTION_ORIGIN"};
  }
  s/$preview/$production/g;
' sitemap.xml

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

if grep -R --include='index.html' -n 'noindex,nofollow' . --exclude-dir=.git --exclude-dir=outputs --exclude-dir=work; then
  printf '%s\n' "Fehler: Mindestens eine öffentliche HTML-Seite enthält weiterhin noindex,nofollow." >&2
  exit 1
fi

printf '%s\n' "Produktionsdateien vorbereitet. Vor Commit und DNS-Umschaltung müssen alle Launch-Checks aus README.md durchgeführt werden."
