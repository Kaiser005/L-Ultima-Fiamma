# L'Ultima Fiamma

Platform 2D sviluppato in **Godot 4** con GDScript. Un cavaliere attraversa un luogo abitato da ombre, raccoglie monete ed è guidato da un misterioso stregone verso la sua prova.

>  **Progetto archiviato.** Questo è un lavoro sviluppato tempo fa e non più in sviluppo attivo. Lo pubblico per tenerne traccia come parte del mio percorso di apprendimento nello sviluppo di giochi.


---

## Indice

- [Caratteristiche](#caratteristiche)
- [Come giocare](#come-giocare)
- [Comandi](#comandi)
- [Come eseguire il progetto](#come-eseguire-il-progetto)
- [Struttura del progetto](#struttura-del-progetto)
- [Tecnologie](#tecnologie)
- [Crediti](#crediti)

---

## Caratteristiche

Il gioco include diversi sistemi costruiti da zero in GDScript:

- **Movimento platform** con salto, gravità e animazioni di corsa/idle/salto sincronizzate.
- **Nemico slime** con pattugliamento automatico basato su `RayCast2D`: cambia direzione al muro senza bisogno di waypoint manuali.
- **Sistema di dialoghi** con textbox a comparsa, effetto macchina da scrivere e testo suddiviso automaticamente in pagine.
- **NPC interattivo** (uno stregone) che si gira verso il giocatore, mostra un tasto di interazione e propone dialoghi diversi in base al contesto.
- **Sistema di monete** con conteggio automatico del totale nel livello e persistenza delle monete già raccolte tra le scene.
- **Menù principale** con opzioni e toggle per la modalità a schermo intero.
- **Menù di pausa** con effetto blur, richiamabile in gioco.
- **Schermata di Game Over** con effetto slow-motion alla morte del giocatore.
- **Transizioni tra scene** con dissolvenza (fade in/out).
- **Gestore audio** centralizzato.

---

## Come giocare

Raccogli le monete sparse nel livello, evita lo slime e raggiungi lo stregone per proseguire. Cadere fuori dalla mappa o toccare le zone di morte porta al Game Over.

---

## Comandi

| Azione | Tasto |
|---|---|
| Muoviti a sinistra / destra | [A / D o frecce] |
| Salta | [Spazio o Freccia Su] |
| Interagisci con l'NPC | [E] |
| Pausa / Indietro | [Esc] |
| Avanza nei dialoghi | [Invio / Spazio] |

---

## Come eseguire il progetto

1. Installa [Godot 4.x](https://godotengine.org/download).
2. Clona il repository:
   ```bash
   git clone https://github.com/Kaiser005/L-Ultima-Fiamma.git
   ```
3. Apri Godot, clicca su **Importa** e seleziona il file `project.godot` nella cartella clonata.
4. Premi **F5** (o il tasto Play in alto a destra) per avviare il gioco.

---

## Struttura del progetto

Il codice è organizzato in script con responsabilità separate:

- `player.gd` — movimento, salto, animazioni e logica di morte del giocatore.
- `green_slime.gd` — pattugliamento del nemico.
- `npc_stregone.gd` — interazione e dialoghi dell'NPC.
- `textbox.gd` — visualizzazione dei dialoghi a pagine con effetto typewriter.
- `coin.gd` — raccolta delle monete e persistenza.
- `game_manager.gd` — punteggio, conteggio monete e cambio livello (singleton).
- `game.gd` — regia del livello: gestisce morte, slow-motion e Game Over.
- `main_menu.gd` / `pause_menu.gd` / `game_over.gd` — interfacce.
- `fade_in_out.gd` / `audio_manager.gd` / `fullscreen_control.gd` — utility.

---

## Tecnologie

- **Motore:** Godot Engine 4.5
- **Linguaggio:** GDScript
- **Versionamento:** Git / GitHub

---

## Crediti

Il **codice** di questo progetto è stato scritto da me.

Gli **asset grafici e audio** provengono da pack, siti di risorse e tutorial di terzi. Di seguito le fonti: https://brackeysgames.itch.io/brackeys-platformer-bundle


> ℹ Questi asset appartengono ai rispettivi autori e sono usati secondo le loro licenze. Non sono di mia proprietà.
