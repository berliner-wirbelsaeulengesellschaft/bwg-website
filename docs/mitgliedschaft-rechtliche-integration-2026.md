# Mitgliedschaft – rechtliche Integration WISO MeinVerein (2026)

Interne Dokumentation der Produktionsänderung zur Integration der
WISO-MeinVerein-Mitgliederverwaltung in die BWG-Website. Enthält keine
privaten Vereinsdokumente, nur öffentlich nachvollziehbare Angaben und
technische Prüfpunkte.

## Kernadressen

- WISO-Profil (öffentlicher Aufnahmeantrag): `https://web.meinverein.de/profile/125165`
- Kanonische Datenschutzroute: `/datenschutz/`
- Zusätzliche, dauerhaft weiterleitende Route: `/datenschutzerklarung/` → `/datenschutz/`
  (angelegt, weil der WISO-Antrag diese Schreibweise referenzieren kann; die
  bestehende, bereits indexierte Route `/datenschutz/` bleibt kanonisch und wird
  nicht umbenannt)
- Satzungsroute: `/gesellschaft/satzung/`

## Maßgebliche Satzungsfassung

Fassung beschlossen am 25. Juni 2025, durch Beschluss der Mitgliederversammlung
vom 24. April 2026 als maßgebliche Fassung bestätigt (Quelle: bestehender Text
unter `/gesellschaft/satzung/`, unverändert). Diese Fassung ist laut Auftrag die
vom Finanzamt im Feststellungsbescheid nach § 60a AO zugrunde gelegte Fassung.
Der Satzungstext selbst wurde in dieser Änderung nicht angepasst.

## Herkunft der Registerangaben

Amtsgericht Charlottenburg, VR 42705 B, Vereinsanschrift Lietzenseeufer 10,
14057 Berlin, sowie die vier im Impressum genannten Vorstandsmitglieder waren
bereits vor dieser Änderung im Repository hinterlegt (frühere Commits
"Finalize legal privacy and accessibility audit" und "Prepare final legal and
search production pass"). Diese Änderung hat daran nichts geändert. Ein
aktueller Vereinsregisterauszug lag für diese Integration nicht vor; siehe
"Offene externe Voraussetzungen" unten.

## Verwendete Rechtsgrundlagen (Datenschutz)

- Art. 6 Abs. 1 Buchst. b DSGVO: Aufnahmeverfahren und Durchführung der
  Mitgliedschaft
- Art. 6 Abs. 1 Buchst. c DSGVO: gesetzliche Dokumentations- und
  Aufbewahrungspflichten
- Art. 6 Abs. 1 Buchst. f DSGVO: berechtigte Interessen (u. a. Vorabanfragen
  per E-Mail, Mitgliederverwaltung)
- Art. 6 Abs. 1 Buchst. a DSGVO: ausschließlich für tatsächlich
  einwilligungsabhängige, freiwillige Verarbeitungen (z. B. gesonderter
  Newsletter)

## Durchgeführte technische Prüfungen

- Repository-Struktur gesichtet: statische HTML-Website ohne Build-Pipeline,
  ohne Datenbank, ohne serverseitige Formularverarbeitung.
- Bestehende Mitgliedschaftsseite war ein `mailto:`-Link, kein gespeichertes
  Formular; es existieren keine gespeicherten Interessentendaten im
  Repository (geprüft per Volltextsuche nach Interessenten-/Mitgliederdaten).
  Punkt 10 des Auftrags (keine automatische Migration) ist damit gegenstandslos,
  da keine entsprechende Datenbasis existiert.
- Öffentliches WISO-Profil unter der genannten URL im Browser aufgerufen:
  Seite ist erreichbar und enthält einen sichtbaren "Beitreten"-Einstieg. Der
  eigentliche Antragsvorgang wurde nicht ausgefüllt oder abgesendet.
- `/mitgliedschaft/` und `/datenschutz/` lokal über einen statischen
  Testserver gerendert und per Screenshot/Accessibility-Baum geprüft: Layout,
  CTA-Link (href, `target="_blank"`, `rel="noopener noreferrer"`) und Textfluss
  sind korrekt.
- `/datenschutzerklarung/` als Weiterleitung nach dem bestehenden Muster der
  übrigen Legacy-Redirects (`uber-uns/*`) angelegt und lokal aufgerufen.
- Volltextsuche auf verbleibende Platzhalter ("i.Gr.", "wird nachgereicht",
  "§ 5 TMG", "§ 55 RStV") ergab keine Treffer – Impressum war bereits auf dem
  aktuellen Rechtsstand.
- E-Mail-Adressen projektweit abgeglichen: ausschließlich
  `info@berlinerwirbelsäule.de` (zzgl. technischer IDN-Schreibweise für
  `mailto:`-Links) und `mitgliedschaft@…`; keine abweichenden Schreibweisen
  gefunden. `mitgliedschaft@…` wird durch die Umstellung auf WISO nicht mehr
  für den Antrag selbst benötigt, bleibt aber als Kontaktadresse bestehen.
- `scripts/prepare-production.sh` nicht mit `--confirm-production-go`
  ausgeführt (würde `robots.txt`/`CNAME` schreiben); stattdessen die vom
  Skript geprüfte Bedingung (Produktionsdomain in jeder `index.html`) manuell
  für alle neuen/geänderten Dateien verifiziert.
- Keine automatisierten Tests im Repository vorhanden (reine HTML/CSS/JS-
  Website ohne Testsuite).

## Was konnte nicht geprüft werden

- Der konkrete, für den Verein unterzeichnete Auftragsverarbeitungsvertrag
  mit der Buhl Data Service GmbH, eingesetzte Unterauftragsverarbeiter,
  technische/organisatorische Maßnahmen und genaue Verarbeitungsstandorte.
  Öffentlich auffindbar war nur, dass Buhl Data Service generell einen
  Art.-28-AVV anbietet; eine MeinVerein-spezifische, verbindliche Bestätigung
  lag nicht vor.
- Ein aktueller Vereinsregisterauszug zur Bestätigung der im Impressum
  genannten vertretungsberechtigten Vorstandsmitglieder.
- Der Status der bankseitigen SEPA-Freischaltung bei der Berliner Sparkasse
  (laut Auftrag noch ausstehend; auf der Website entsprechend als "noch nicht
  abgeschlossen" formuliert, kein automatischer Lastschrifteinzug behauptet).

## Noch ausstehende externe Voraussetzungen

1. Bankseitige Freischaltung des SEPA-Basislastschrifteinzugs durch die
   Berliner Sparkasse.
2. Bestätigung/Beschaffung des konkreten Buhl-AVV inkl.
   Unterauftragsverarbeiterliste für die Datenschutzerklärung, Abschnitt 6 e).
3. Abgleich der im Impressum genannten Vorstandsmitglieder mit einem aktuellen
   Vereinsregisterauszug.

## Datum der Integration

16. Oktober 2026.
