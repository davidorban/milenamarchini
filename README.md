# Portfolio di Milena Marchini

Questo è un sito web statico moderno per una designer che lavora su una vasta gamma di progetti.

## Struttura del Progetto

- `index.html` - Homepage del sito
- `progetti.html` - Pagina dei progetti
- `contatti.html` - Pagina dei contatti
- `css/` - Directory per i file CSS
  - `style.css` - Foglio di stile principale
  - `additional.css` - Stili aggiuntivi
  - `hero.css` - Stili per la sezione hero
- `js/` - Directory per i file JavaScript
  - `main.js` - Script JavaScript principale
- `img/` - Directory per le immagini

## Tecnologie Utilizzate

- HTML5
- CSS3
- JavaScript

## Deployment Automatico

Questo progetto utilizza GitHub Actions per il deployment automatico. Ogni volta che viene effettuato un push sul branch `main`, il sito web viene automaticamente aggiornato sul server.

### Configurazione del Deployment

Per configurare il deployment automatico, è necessario aggiungere i seguenti secrets al repository GitHub:

1. `SSH_PRIVATE_KEY` - La chiave SSH privata per l'accesso al server
2. `SSH_HOST` - L'hostname del server (es. milenamarchini.com)
3. `SSH_USER` - Il nome utente per l'accesso SSH
4. `REMOTE_DIR` - La directory remota dove verrà deployato il sito (es. /home/user/public_html)

#### Passi per la configurazione:

1. Vai su GitHub > Il tuo repository > Settings > Secrets and variables > Actions
2. Clicca su "New repository secret"
3. Aggiungi i quattro secrets menzionati sopra
4. Assicurati che la chiave SSH sia stata aggiunta al server remoto

Una volta configurato, ogni push sul branch `main` attiverà automaticamente il workflow di deployment.

## Ultimo aggiornamento

Ultimo aggiornamento: 27 Marzo 2025
