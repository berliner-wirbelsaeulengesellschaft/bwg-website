# Berliner Wirbelsäulengesellschaft e.V.

Statische Website der Berliner Wirbelsäulengesellschaft e.V. für die spätere Veröffentlichung über GitHub Pages.

## Technische Leitlinien

- HTML5, CSS und wenig Vanilla JavaScript
- keine Frameworks und keine Build-Pipeline
- lokal eingebundene Instrument Sans, keine extern geladenen Schriftarten
- kein Tracking und keine Drittanbieter-Einbettungen
- progressive Erweiterung; die Inhalte bleiben ohne JavaScript lesbar

## Markenassets

- `assets/brand/bwg-logo-farbe.png`: vollständige Wort-/Bildmarke im Desktop-Header
- `assets/brand/bwg-signet-farbe.svg`: Signet für mobile Header, Footer und responsive Varianten
- `assets/fonts/InstrumentSans-Variable.ttf`: lokal ausgelieferte variable Schrift
- `assets/fonts/OFL-Instrument-Sans.txt`: Lizenztext der Instrument Sans

## Seitenstruktur

Implementiert sind die Startseite und sämtliche derzeit geplanten Unterseiten:

- `gesellschaft/`
- `gesellschaft/vorstand/`
- `gesellschaft/satzung/`
- `veranstaltungen/`
- `veranstaltungen/2026-09-16/`
- `veranstaltungen/archiv/`
- `wissenschaft-fortbildung/`
- `mitgliedschaft/`
- `kontakt/`
- `impressum/`
- `datenschutz/`
- `zugaenglichkeit/`

Datenschutz und Zugänglichkeit sind technisch und inhaltlich für den aktuellen statischen Stand ausgearbeitet. Die Satzung ist als vollständiger HTML-Text eingebunden.

## Vorschau-Status

Alle HTML-Seiten tragen während der Vorschauphase `noindex,nofollow`. Zusätzlich sperrt `robots.txt` das Crawling. Die verantwortliche Person nach § 18 Abs. 2 MStV und die GitHub-Pages-Vorschau-URL sind bestätigt. Die Suchmaschinensperren werden erst beim späteren Produktions-Relaunch entfernt.

Die Startseite verwendet das bereitgestellte Berlin-Panorama unter `assets/images/berlin-panorama.webp`.

Die Domain wird noch nicht umgeschaltet. Der IONOS-Websitebaukasten bleibt bis zum vollständig geprüften Relaunch bestehen.

## Production Checklist

- [ ] IONOS-Auftragsverarbeitungsvereinbarung im Kundenkonto geprüft
- [ ] Finaler Live-Test nach DNS-/Custom-Domain-Umschaltung durchgeführt

Bis zum ausdrücklichen `PRODUCTION GO` bleiben `noindex,nofollow` auf allen Seiten und die vollständige Sperre in `robots.txt` aktiv. Es wird vorher keine `CNAME`-Datei angelegt und keine Custom Domain in GitHub Pages konfiguriert.

Für den späteren Produktionswechsel ist `www.berlinerwirbelsäule.de` die sichtbare Primärdomain. In GitHub Pages wird sie technisch als `www.xn--berlinerwirbelsule-ztb.de` eingetragen. Der DNS-Zielwert für den `www`-CNAME ist `ps4815.github.io`. Die Apex-Domain `xn--berlinerwirbelsule-ztb.de` wird über die von GitHub Pages vorgegebenen A- und AAAA-Einträge angebunden. Die ASCII-Domain `berlinerwirbelsaeule.de` benötigt separat eine permanente HTTP-Weiterleitung auf die Primärdomain; DNS allein erzeugt keinen HTTP-Status 301.

Später bei IONOS zu setzende Web-DNS-Einträge für die Umlautdomain:

```text
www  CNAME  ps4815.github.io
@    A      185.199.108.153
@    A      185.199.109.153
@    A      185.199.110.153
@    A      185.199.111.153
@    AAAA   2606:50c0:8000::153
@    AAAA   2606:50c0:8001::153
@    AAAA   2606:50c0:8002::153
@    AAAA   2606:50c0:8003::153
```

Beim Produktionswechsel werden Canonical-, Open-Graph- und Sitemap-URLs konsistent auf `https://www.xn--berlinerwirbelsule-ztb.de/` umgestellt. Das ist die standardkonforme technische Schreibweise derselben sichtbaren IDN-Domain `https://www.berlinerwirbelsäule.de/`.

MX-, SPF-, DKIM- und DMARC-Einträge bleiben unverändert bei IONOS.
