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

Datenschutz und Zugänglichkeit sind technisch und inhaltlich für den aktuellen statischen Stand ausgearbeitet. Die Satzung ist als vollständiger HTML-Text und als PDF eingebunden.

## Vorschau-Status

Alle HTML-Seiten tragen während der Vorschauphase `noindex,nofollow`. Zusätzlich sperrt `robots.txt` das Crawling. Die verantwortliche Person nach § 18 Abs. 2 MStV und die GitHub-Pages-Vorschau-URL sind bestätigt. Die Suchmaschinensperren werden erst beim späteren Produktions-Relaunch entfernt.

Die Startseite verwendet das bereitgestellte Berlin-Panorama unter `assets/images/berlin-panorama.webp`.

Die Domain wird noch nicht umgeschaltet. Der IONOS-Websitebaukasten bleibt bis zum vollständig geprüften Relaunch bestehen.
