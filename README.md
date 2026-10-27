<div align="center">

# Hotline Miami Redux-Redux Co-op

**Сетевой кооператив до 4 игроков для фанатского мода _Hotline Miami: Redux-Redux_**
**Online co-op for up to 4 players for the _Hotline Miami: Redux-Redux_ fan mod**

[Русский](#-русский) · [English](#-english) · [Скачать кооп / Download co-op](../../releases/latest) · [Скачать игру / Get the game](https://boosty.to/skide/posts/3ea5910c-28e8-4e7e-8f13-cef3e44840f1)

</div>

---

## 🇷🇺 Русский

Мод добавляет в Redux-Redux полноценный сетевой кооператив: вся сюжетная кампания проходится вдвоём, втроём или вчетвером.

### Возможности

- **До 4 игроков** по IP: локальная сеть, Radmin VPN или ZeroTier.
- **Вся кампания вместе.** Переходы между этажами, машина, сюжетные сцены, диалоги и сюжетные предметы работают для всех. Уровень может закончить любой игрок, даже если хост погиб.
- **Падение и подъём.** Упавшего союзника можно поднять (E, 5 секунд). Погибшие наблюдают за игрой, пока не перезапустится уровень.
- **Три персонажа:** Джек (Jacket), Байкер (тесак и метательные ножи) и Мартин Браун (Мясник: удар головой и броня).
- **Маски** — у каждого игрока своя, все видят маски друг друга.
- **Итоги уровня по игрокам:** враги, казни, падения.
- **Общий прогресс:** при подключении клиент получает сохранение хоста, а всё, что открылось в совместной игре, сохраняется у всех.
- **Журнал вылетов:** после вылета игра сама подскажет, какие файлы прислать.

### Установка

1. Нужна установленная игра **Hotline Miami: Redux-Redux**. Скачать её можно на странице автора: [Redux-Redux на Boosty](https://boosty.to/skide/posts/3ea5910c-28e8-4e7e-8f13-cef3e44840f1). Это сама игра; кооператив ставится поверх неё отдельно (шаги ниже).
2. Скачайте архив из [Releases](../../releases/latest) и распакуйте его **в папку с игрой**.
3. Запустите `install-coop.bat`. Он проверит версию игры, сохранит копию оригинального `data.win` (`data.win.original`) и установит кооператив.
4. Запускайте игру как обычно. В главном меню нажмите **F8**, чтобы открыть лобби.

У всех игроков должна быть одна и та же версия мода.

### Как играть

| Клавиша | Действие |
|---|---|
| F8 | Лобби (в главном меню) |
| F9 | Сетевой оверлей: пинг, FPS, игроки |
| ЛКМ / ПКМ | Атака / подобрать или бросить оружие |
| Space | Казнь (Мартин: удар головой по стоящему врагу) |
| E | Поднять упавшего союзника |
| Shift | Посмотреть дальше |

**Хост:** F8 → ник → CREATE GAME → сообщите друзьям свой IP → START.
**Клиент:** F8 → ник → вставьте IP хоста (кнопка PASTE IP) → JOIN GAME → READY.

Для игры через интернет установите Radmin VPN или ZeroTier, создайте общую сеть и подключайтесь по адресу хоста в этой сети (обычно 26.x.x.x).

### Сборка из исходников

Код мода — в `src/gml` (GameMaker Language) и `base/gml`. Сборщик `tools/coopbuild2` (C#, UndertaleModLib) собирает `data.win`, `tools/build.py` запускает сборку. Нужны .NET 10 SDK, Python 3 и UndertaleModTool 0.9.2: путь к нему задаётся переменной окружения `COOP_UTMT_DIR`. Заметки по устройству — в [NOTES.md](NOTES.md).

---

## 🇬🇧 English

This mod adds full online co-op to Redux-Redux: you can play through the whole story campaign with 2, 3 or 4 players.

### Features

- **Up to 4 players** over IP: LAN, Radmin VPN or ZeroTier.
- **The whole campaign together.** Floor transitions, the car, story scenes, dialogues and story items work for everyone. Any player can finish a level, even if the host is dead.
- **Down, not out.** Revive a downed teammate (hold E for 5 seconds). Dead players spectate until the level restarts.
- **Three characters:** Jacket, the Biker (cleaver and throwing knives) and Martin Brown (the Pig Butcher: headbutt and armor).
- **Masks.** Each player picks their own mask, and everyone sees everyone's mask.
- **Per-player level results:** kills, executions, times downed.
- **Shared progress.** A joining client receives the host's save, and everything unlocked in co-op is saved for everyone.
- **Crash log.** After a crash, the game tells you which files to send.

### Installation

1. You need the game **Hotline Miami: Redux-Redux** installed. Get it from the author's page: [Redux-Redux on Boosty](https://boosty.to/skide/posts/3ea5910c-28e8-4e7e-8f13-cef3e44840f1). That is the game itself; co-op is installed on top of it separately (steps below).
2. Download the archive from [Releases](../../releases/latest) and extract it **into the game folder**.
3. Run `install-coop.bat`. It checks your game version, backs up the original `data.win` (as `data.win.original`) and installs co-op.
4. Launch the game as usual. Press **F8** in the main menu to open the lobby.

All players must have the same mod version.

### Controls

| Key | Action |
|---|---|
| F8 | Lobby (main menu) |
| F9 | Network overlay: ping, FPS, players |
| LMB / RMB | Attack / pick up or throw a weapon |
| Space | Execute (Martin: headbutt a standing enemy) |
| E | Revive a downed teammate |
| Shift | Look further |

**Host:** F8 → nickname → CREATE GAME → tell your friends your IP → START.
**Client:** F8 → nickname → paste the host's IP (PASTE IP button) → JOIN GAME → READY.

To play over the internet, install Radmin VPN or ZeroTier, create a shared network and connect using the host's address in that network (usually 26.x.x.x).

### Building from source

The mod code is in `src/gml` (GameMaker Language) and `base/gml`. The builder `tools/coopbuild2` (C#, UndertaleModLib) builds `data.win`; `tools/build.py` runs the build. You need the .NET 10 SDK, Python 3 and UndertaleModTool 0.9.2; set `COOP_UTMT_DIR` to its folder. Design notes (in Russian) are in [NOTES.md](NOTES.md).

---

<div align="center">

Hotline Miami — © Dennaton Games / Devolver Digital. Redux-Redux — its respective authors.
This repository contains only the co-op mod code and a patcher, **no game files**.
Этот репозиторий содержит только код кооп-мода и патчер, **без файлов игры**.

</div>
