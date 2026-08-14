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

Die zweite schnelle Kontaktmöglichkeit bleibt bis zur Freigabe einer offiziellen Vereins- oder Sekretariatsnummer ein organisatorischer Review-Punkt:

```text
OFFICIAL_CONTACT_PHONE = NOT_PROVIDED
```

Es wird keine private Telefonnummer veröffentlicht und kein externes Formular ohne gesonderte Freigabe installiert.

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

## Vorbereiteter Produktionswechsel

Das Skript `scripts/prepare-production.sh` ist ausschließlich für den Zeitpunkt nach einem ausdrücklichen `PRODUCTION GO` vorgesehen. Es entfernt die Vorschau-Metadaten, stellt Canonical-, Open-Graph-, Sitemap- und strukturierte Daten auf die technische IDN-Produktionsdomain um, aktiviert die Produktionsregeln in `robots.txt` und legt die `CNAME`-Datei an.

Vor dem `PRODUCTION GO` darf es nicht ausgeführt werden. Der explizite Aufruf lautet erst danach:

```sh
scripts/prepare-production.sh --confirm-production-go
```

Die Produktionsregeln erlauben allgemeines Crawling und `OAI-SearchBot`, sperren aber `GPTBot`. Suchauffindbarkeit und eine Freigabe für potenzielles Modelltraining werden damit getrennt behandelt. Eine `llms.txt` wird nicht angelegt, da hierfür derzeit keine offizielle Google- oder OpenAI-Empfehlung mit nachgewiesenem SEO-Nutzen vorliegt.

## Search Console – nach PRODUCTION GO

1. Google Search Console öffnen.
2. Domain-Property für `berlinerwirbelsäule.de` anlegen.
3. Von Google gelieferten DNS-TXT-Verifizierungseintrag bei IONOS hinzufügen.
4. Bestehende MX-, SPF-, DKIM- und DMARC-Einträge **nicht** verändern.
5. Domain verifizieren.
6. `sitemap.xml` unter der Produktionsdomain einreichen.
7. URL-Prüfung für:
   - Startseite
   - Gesellschaft
   - Veranstaltungen
   - Veranstaltung 16.09.2026
   - Mitgliedschaft
8. Live-Test durchführen.
9. Indexierung beantragen.
10. Rich-Results-Berichte nach Indexierung kontrollieren.

Google Analytics wird nicht eingesetzt. Die Search-Console-Bestätigung erfolgt ausschließlich über DNS.

## Structured Data Validation

Nach der Veröffentlichung sind die öffentlichen URLs mit folgenden offiziellen Werkzeugen zu prüfen:

- Google Rich Results Test
- Schema.org Validator
- Google Search Console URL Inspection

Zu testen sind:

- Startseite: `Organization`
- Veranstaltungsseite: `Event`
- Unterseiten: `BreadcrumbList`

Kritische Fehler müssen vor der Produktionsfreigabe beseitigt werden. Warnungen werden einzeln darauf geprüft, ob die betroffene optionale Angabe tatsächlich vorhanden und öffentlich belegt ist.

## Bing Webmaster Tools

Nach dem Produktionsstart:

1. Website in Bing Webmaster Tools anlegen.
2. Eigentum bestätigen.
3. `sitemap.xml` einreichen.
4. IndexNow aktivieren.

Für IndexNow wird erst nach dem Produktionsstart ein zufälliger gültiger Schlüssel erzeugt, beispielsweise mit `openssl rand -hex 16`. Im Repository-Root wird dann die Datei `<SCHLÜSSEL>.txt` mit exakt diesem Schlüssel als Inhalt bereitgestellt. Das Skript `scripts/submit-indexnow.sh` übermittelt ausschließlich nach manuellem Aufruf und akzeptiert nur URLs der kanonischen Produktionsdomain. GitHub-Preview-URLs werden abgewiesen.

Beispiel nach Veröffentlichung der Schlüsseldatei:

```sh
INDEXNOW_KEY=<SCHLÜSSEL> scripts/submit-indexnow.sh \
  https://www.xn--berlinerwirbelsule-ztb.de/ \
  https://www.xn--berlinerwirbelsule-ztb.de/veranstaltungen/2026-09-16/
```

## Redaktionelle Empfehlungen

- Jede neue, tatsächlich stattfindende BWG-Veranstaltung erhält eine eigene dauerhafte URL.
- Ein fachlicher Rückblick wird nur veröffentlicht, wenn eigener freigegebener Inhalt vorliegt.
- Wissenschaftliche Projekte erhalten erst nach ihrem offiziellen Start eine eigene Seite.
- Publikationen werden nur aufgenommen, wenn es sich um tatsächlich veröffentlichte BWG-bezogene Arbeiten handelt.
- Statements und Empfehlungen werden nur mit klarer Autorenschaft und Freigabe veröffentlicht.

Es wird keine Veröffentlichungsfrequenz erzwungen. Qualität, Originalität und belastbare Primärinformationen haben Vorrang vor Quantität.

## Institutionelle Verlinkung

Bei jeder Veranstaltung soll die konkrete Veranstaltungs-URL an beteiligte Kliniken, Universitäten, wissenschaftliche Partner, Conventus, kooperierende Fachgesellschaften und Referenten kommuniziert werden. Bei eigenen Veranstaltungsankündigungen kann um eine direkte Verlinkung auf die zugehörige BWG-Seite gebeten werden.

Bezahlte Linkpakete, Linkfarmen und Spam-Verzeichnisse werden nicht genutzt.

## Social Entity Signals

Social-Media-URLs werden erst ergänzt, wenn offizielle BWG-Profile tatsächlich bestehen. Bei einer künftigen offiziellen LinkedIn-Seite wird zuerst die Vereinswebsite im LinkedIn-Profil hinterlegt, anschließend das Profil sichtbar auf der Website verlinkt und die bestätigte URL in `Organization.sameAs` ergänzt. Instagram wird nur bei einem offiziellen, aktiv betreuten BWG-Profil aufgenommen.
