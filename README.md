# RobotStudio – Ambiente di lavoro

Repository per la programmazione di robot ABB con **RobotStudio** e linguaggio **RAPID**.

## Struttura

```
RobotStudio/
├── progetti-riferimento/   # Progetti già fatti da cui prendere spunto
│   └── _TEMPLATE/          # Modello da copiare per ogni nuovo progetto caricato
├── miei-progetti/          # Progetti nuovi in sviluppo
└── snippets-rapid/         # Pezzi di codice RAPID riutilizzabili
```

## Come caricare un progetto di riferimento

1. Copia la cartella `progetti-riferimento/_TEMPLATE` e rinominala, es. `progetti-riferimento/pick-and-place-irb120`.
2. Metti i file nelle sottocartelle:
   - `RAPID/` → moduli `.mod`, `.modx`, `.sys`, `.sysx`, `.prg`, `.pgf` (esportati dal controller virtuale o dal backup)
   - `Stazione/` → file `.rspag` (Pack and Go) o `.rsstn`
   - `Documentazione/` → PDF, schemi, screenshot, video brevi
3. Compila il `README.md` del progetto (robot, tool, obiettivo, cosa c'è di interessante).
4. Commit e push.

> **Dal browser:** su GitHub entra nella cartella → *Add file* → *Upload files* e trascina i file.

## Suggerimenti

- Versiona soprattutto il **codice RAPID** (file di testo): è quello che si confronta e riutilizza meglio.
- Per esportare i moduli: in RobotStudio, scheda *RAPID* → tasto destro sul modulo → *Save Module As…*,
  oppure usa un **Backup** del controller (cartella `RAPID/TASK1/PROGMOD`).
- GitHub rifiuta file oltre **100 MB**: per stazioni `.rspag` molto pesanti valuta Git LFS o un link esterno nel README.
