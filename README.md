# Berliner Wirbelsäulengesellschaft e.V.

Statische, über GitHub Pages veröffentlichte Website der Berliner Wirbelsäulengesellschaft e.V.

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
- `assets/images/bwg-logo-16x9.png`, `bwg-logo-4x3.png`, `bwg-logo-1x1.png`: aus der Wort-/Bildmarke erzeugte Standardbilder (je 1200 px breit) für strukturierte Daten und Open Graph; sie erscheinen nicht im sichtbaren Layout, sondern nur in Metadaten und in Vorschaubildern beim Teilen

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

## Produktionsstatus

Die Website ist unter `https://www.berlinerwirbelsäule.de/` veröffentlicht. Canonical-, Open-Graph-, Sitemap- und strukturierte Daten verwenden konsistent die technisch standardkonforme IDN-Darstellung `https://www.xn--berlinerwirbelsule-ztb.de/`.

Die Startseite verwendet das bereitgestellte Berlin-Panorama unter `assets/images/berlin-panorama.webp`.

## Production Checklist

- [x] Custom Domain und HTTPS in GitHub Pages aktiviert
- [x] Indexierung für allgemeine Suchmaschinen und `OAI-SearchBot` freigegeben
- [x] `GPTBot` für potenzielles Modelltraining gesperrt
- [x] Canonical-, Open-Graph-, Sitemap- und strukturierte Daten auf die Produktionsdomain umgestellt

Die zweite schnelle Kontaktmöglichkeit bleibt bis zur Freigabe einer offiziellen Vereins- oder Sekretariatsnummer ein organisatorischer Review-Punkt:

```text
OFFICIAL_CONTACT_PHONE = NOT_PROVIDED
```

Es wird keine private Telefonnummer veröffentlicht und kein externes Formular ohne gesonderte Freigabe installiert.

Die sichtbare Primärdomain ist `www.berlinerwirbelsäule.de`. In GitHub Pages ist sie technisch als `www.xn--berlinerwirbelsule-ztb.de` eingetragen. Der DNS-Zielwert für den `www`-CNAME ist `ps4815.github.io`. Die Apex-Domain `xn--berlinerwirbelsule-ztb.de` ist über die von GitHub Pages vorgegebenen A- und AAAA-Einträge angebunden.

Produktive Web-DNS-Einträge für die Umlautdomain:

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

Canonical-, Open-Graph- und Sitemap-URLs sind konsistent auf `https://www.xn--berlinerwirbelsule-ztb.de/` eingestellt. Das ist die standardkonforme technische Schreibweise derselben sichtbaren IDN-Domain `https://www.berlinerwirbelsäule.de/`.

MX-, SPF-, DKIM- und DMARC-Einträge bleiben unverändert bei IONOS.

## Produktionsprüfung

Das Skript `scripts/prepare-production.sh` prüft nach ausdrücklichem `PRODUCTION GO`, dass alle öffentlichen HTML-Seiten die technische IDN-Produktionsdomain enthalten, und normalisiert die Produktionsregeln in `robots.txt` sowie die `CNAME`-Datei.

Der explizite Aufruf lautet:

```sh
scripts/prepare-production.sh --confirm-production-go
```

Die Produktionsregeln erlauben allgemeines Crawling und `OAI-SearchBot`, sperren aber `GPTBot`. Suchauffindbarkeit und eine Freigabe für potenzielles Modelltraining werden damit getrennt behandelt. Eine `llms.txt` wird nicht angelegt, da hierfür derzeit keine offizielle Google- oder OpenAI-Empfehlung mit nachgewiesenem SEO-Nutzen vorliegt.

## Search Console – nach Produktionsstart

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
- Veranstaltungsübersicht: `ItemList`
- Veranstaltungsseite: `Event`
- Unterseiten: `BreadcrumbList`

### Event-Markup

Jede eigene BWG-Veranstaltung mit dauerhafter URL erhält ein vollständiges `Event`-Objekt mit
`name`, `description`, `image`, `startDate`, `endDate`, `eventAttendanceMode`, `eventStatus`,
`location` (inklusive `location.name`), `organizer`, `performer`, `offers` und `url`.

Verbindliche redaktionelle Regeln:

- `organizer` ist immer die Berliner Wirbelsäulengesellschaft e.V. und referenziert die
  `@id` `https://www.xn--berlinerwirbelsule-ztb.de/#organization` der Startseite.
- `performer` enthält ausschließlich die tatsächlich im Programm angekündigten Referentinnen
  und Referenten. Es werden keine Personen ergänzt, um das Feld zu füllen.
- `image` verweist auf die drei Logo-Standardbilder in den von Google empfohlenen
  Seitenverhältnissen 16:9, 4:3 und 1:1. Ein eigenes Veranstaltungsbild ersetzt sie, sobald
  ein freigegebenes Motiv vorliegt.

Alle Seiten führen zusätzlich `og:image` auf `bwg-logo-16x9.png` mit `og:image:width`,
`og:image:height`, `og:image:type` und `og:image:alt`. Erhält eine Veranstaltung ein eigenes
freigegebenes Motiv, werden auf ihrer Detailseite sowohl `Event.image` als auch `og:image`
gemeinsam darauf umgestellt.
- `location.name` benennt den Veranstaltungsort; bei Veranstaltungen am Vereinssitz ist das
  die Berliner Wirbelsäulengesellschaft e.V. Bei externen Räumen wird der offizielle Name
  des Hauses eingetragen.
- `offers` bildet nur öffentlich ausgewiesene Konditionen ab. Bei kostenfreier Teilnahme
  gelten `price` `"0"`, `priceCurrency` `"EUR"` und `isAccessibleForFree` `true`.

Die Veranstaltungsübersicht nutzt das von Google dokumentierte Summary-Muster: eine
`ItemList`, deren Einträge ausschließlich auf die jeweilige Detailseite verweisen. Die
vollständigen Veranstaltungsdaten stehen nur auf der Detailseite, damit keine konkurrierenden
Event-Entitäten entstehen.

Archiv- und Rückblickseiten erhalten bewusst kein `Event`-Markup. Zu den dort gelisteten
Terminen liegen weder eigene URLs noch belegte Orts-, Zeit- und Teilnahmeangaben vor;
ein unvollständiges Markup würde neue Search-Console-Meldungen erzeugen ohne Nutzen.

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
