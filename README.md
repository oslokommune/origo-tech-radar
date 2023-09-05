## Origo Teknologiradar

Laget som kopi av:\
https://github.com/thoughtworks/build-your-own-radar

### URL for radaren

Routing til radaren er konfigurert i AWS-kontoen "dataplatform-prod", hvor en API Gateway bruker en reverse-proxy mot
url-en til S3-siten.

Direkte-url til S3-site:\
http://teknologiradar-origo.s3-website-eu-west-1.amazonaws.com/

Url via API Gateway:\
https://developer.oslo.kommune.no/teknologiradar

### GitHub - Oppdatering fra Thoughtworks

Vi har et patch-set som legges på toppen av Thoughtworks sin radar. Vi har diskutert forskjellige løsninger som vil gi
enklest håndtering fram i tid, når vi tar inn endringer fra Thoughtworks. For å gi oss mest mulig oversikt over
våre endringer, har vi valgt å legge dem inn i en branch som vi hele tiden kan rebase på toppen av endringer
fra Thoughtworks.

Typisk blir det som følger:

    git remote add upstream https://github.com/thoughtworks/build-your-own-radar.git
    git fetch upstream
    git checkout origo-patch-branch
    git rebase <hash-for-ønsket-versjon-tag>

Hvis det oppstår konflikter, må disse løses før man force-pusher til GitHub.

    git push --force

### Oppdatering av innhold

Kildedata for radaren finnes i Google Sheet med navn "teknologiradar".

1. Gjør endringer i fanen med navn "arbeidsflate".
2. Data som fjernes fra radaren kan med fordel legges i bunnen på arbeidsflaten.
3. Eksporter CSV-fil fra fanen "til eksportering".
4. Legg CSV-fila i `data`-mappa i dette prosjektet.
5. Oppdater fil som skal benyttes i `src/config.js`.

### Bygging av prosjekt og kjøring lokalt

Prosjektet bygger i `./dist` og kopierer denne til s3-bøtte `teknologiradar-origo` / `teknologiradar-origo-dev`.

Bygge prosjekt:

1. `npm install` - installere avhengigheter
2. `npm run quality` - kjøre linting og tester
3. `npm test` - kjøre tester

Vi må initiere følgende for vårt oppsett:

    export RINGS='["BRUK", "VURDER", "AVSTÅ"]'
    export QUADRANTS='["Programmering", "Devops", "Plattform", "Sikkerhet"]'

### Kjøring lokalt

`npm run dev` - kjøre applikasjonen på localhost:8080

Vi har lagt inn default `documentId=config().defaultDocument`, men det må overstyres lokalt.

Applikasjon med data fra GitHub:\
http://localhost:8080/?documentId=https://raw.githubusercontent.com/oslokommune/origo-teknologiradar/master/data/radar.csv

### Deployment til DEV

1. `export AWS_PROFILE=` - med riktig SSO-konto
2. `aws sso login` - logg inn på AWS-konto `teknologi-dev`
3. `./build-deploy-dev.sh`

Applikasjon med lokale data:\
http://teknologiradar-origo-dev.s3-website-eu-west-1.amazonaws.com/

### Deployment til PROD

1. `export AWS_PROFILE=` - med riktig SSO-konto
2. `aws sso login` - logg inn på AWS-konto `teknologi-prod`
3. `./build-deploy-prod.sh`

Applikasjon med lokale data:\
https://developer.oslo.kommune.no/teknologiradar/
