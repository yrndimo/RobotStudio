# IRB 6600 – Asservimento CNC con doppia pinza

## Descrizione
Cella di asservimento macchina utensile: il robot preleva i pezzi da due carri, li carica nel CNC,
li scarica, li porta alle stazioni di misura e ispezione e infine li deposita in uscita o nello scarto.
Il ciclo è comandato da **PLC**: il PLC invia il numero di *missione* e il robot la esegue.

## Hardware
- **Robot:** IRB 6600/2.55-175
- **Controller:** S4C+ – RobotWare 4.0 (System Pack 3HAC6811-2.27)
- **Opzioni:** Multitasking, Advanced Motion, LoadId & ColDetect, IO Plus, Developer Functions
- **Tool:** doppia pinza `tPinzaA` / `tPinzaB` con sensori pezzo presente + morsa
- **I/O verso PLC:** gateway ADFweb su bus DeviceNet (unità `adfweb`, indirizzo 15)
- **Periferiche:** 2 carri portapezzi, CNC, stazione di misura, ispezione, uscita, scarto, soffiaggio

## Contenuto
- `backup-2024-11-28/` – backup completo del controller del 28/11/2024
  - `RAPID/TASK0/PROGMOD/MAINPROG.mod` – programma principale (gestione missioni)
  - `RAPID/TASK0/SYSMOD/` – moduli di sistema (libreria, zone, registrazione percorso)
  - `HOME/!mission/p0001.mod` – programma pezzo **p0001** (modello 314661ADT1 lungo)
  - `HOME/RobData/RobData.sys` – dati comuni (tool, wobj, jointtarget, nomi missioni)
  - `SYSPAR/` – configurazione: `EIO.cfg` (I/O), `MOC.cfg` (moto), `SYS.cfg` (sistema)
- `Documentazione/` – materiale aggiuntivo (vuota)

## Logica di funzionamento
1. `Main` attende `diStartJob`, legge la missione da `giNumJob` e il modello da `giNumModel`.
2. Carica dinamicamente il modulo del pezzo `HOME:\!mission\pXXXX.mod` (es. `p0001.mod`).
3. Converte il numero missione nel nome routine (`stMissionNames` in `RobData.sys`) e la chiama
   con **late binding**: `%stRoutineName%;`
4. A fine missione: impulso su `doJobDone` ed eco della missione su `goEchoJob`.

| Missione | Routine | | Missione | Routine |
|---|---|---|---|---|
| 1 | PrelCarro1 | | 7 | DepOut |
| 2 | PrelCarro2 | | 8 | DepIsp |
| 3 | DepCNC | | 9 | PrelIsp |
| 4 | PrelCNC | | 10 | DepMeasure |
| 5 | DepCarro1 | | 11 | PrelMeasure |
| 6 | DepCarro2 | | 12 | Scarto |
| 249 | Stop ciclo (`rEndCycle`) | | 251 | Posizione manutenzione |
| 250 | Ritorno Home (`rAutoHome`) | | 252 | Posizione fuori linea |

## Punti interessanti da riutilizzare
- **Missioni da PLC + late binding** (`MAINPROG.mod`, `Main`): schema standard e pulito per celle
  comandate da PLC; aggiungere una missione = aggiungere una routine e un nome nell'array.
- **Un modulo per ogni codice pezzo** caricato a runtime (`fxPieceFileName`, `LoadUpdate`,
  `fxLoadUpdMod` in `instrlib.sys`), con ricarica automatica se il file è più recente.
- **Ritorno automatico in Home ripercorrendo il percorso** (`PosRec.sys`): le istruzioni
  `MoveRJ`, `MoveRL`, `MoveRAbsJ` muovono il robot *e* memorizzano il punto; `MoveRec_Home`
  ripercorre i punti al contrario. Ottimo per il ripristino dopo un'emergenza.
- **Calcolo posizioni su carro/rastrelliera** (`p0001.mod`, `CalPrel…`/`CalDep…`): dal punto
  *master* si calcola la posizione N con passo (`nInterlay`), correzioni X/Z e rotazione
  incrementale tramite `EulerZYX` / `OrientZYX`.
- **World zones legate alle posizioni giunti** (`wzones.sys`, `WdzInit`): `WZHomeJointDef` +
  `WZDOSet` attivano un'uscita quando il robot è in Home o in accostamento a ogni stazione
  (consenso/interblocco per il PLC). Chiamata all'accensione tramite *event routine* `POWER_ON`.
- **Menu operatore su FlexPendant** (`aaa_OpManuali`): esecuzione manuale delle missioni a
  pagine con `TPReadFK` / `TPReadNum`.
- **Controllo pezzo presente/assente** dopo ogni presa/deposito (`CtrlPzAPres`, `CtrlPzANotPres`…).

## Note
- Sintassi **RobotWare 4 (S4C+)**: su IRC5/OmniCore (RobotWare 6/7) alcune istruzioni e la
  struttura dei file di configurazione cambiano. Conviene riusare la *logica*, non copiare i file 1:1.
- In `Main` la chiamata `LoadUpdate stFileName,stModuleName;` passa `"MAINPROG"` come nome del
  modulo invece di `stModName` (nome del modulo pezzo): sembra un refuso, da verificare prima di riusarla.
- I file `HOME/MAINPROG.prg` e `RAPID/TASK0/PROGMOD/MAINPROG.mod` sono quasi identici: il backup
  salva sia la copia su disco sia quella caricata in memoria.
