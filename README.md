> [!NOTE]
> 💜 **Если хотите поддержать труды разработчиков, подпишитесь на [Boosty](https://boosty.to/saldamen).** Подписка не даёт абсолютно никаких преимуществ, только поддержку авторов. Спасибо, ребята!
>
> 💜 **If you'd like to support the developers' work, subscribe on [Boosty](https://boosty.to/saldamen).** The subscription gives no in-game advantages at all, it's just support for the authors. Thank you, guys!

<div align="center">

<img src="docs/banner.svg" alt="Hotline Miami Redux-Redux Co-op" width="100%">

**Сетевой кооператив до 4 игроков для фанатского мода _Hotline Miami: Redux-Redux_**<br>
*Online co-op for up to 4 players for the _Hotline Miami: Redux-Redux_ fan mod*

[![Release](https://img.shields.io/github/v/release/kostyazobnin7-ctrl/Hotline-Miami-Redux-Redux-Co-op?style=for-the-badge&color=ff2f8f&label=версия%20%2F%20version)](../../releases/latest)
[![Downloads](https://img.shields.io/github/downloads/kostyazobnin7-ctrl/Hotline-Miami-Redux-Redux-Co-op/total?style=for-the-badge&color=33c9ff&label=скачиваний%20%2F%20downloads)](../../releases)
![Players](https://img.shields.io/badge/игроков%20%2F%20players-1–4-ffb02e?style=for-the-badge)
![Platform](https://img.shields.io/badge/Windows-GameMaker%201.4-7a3cff?style=for-the-badge)

### [⬇ Скачать кооп / Download co-op](../../releases/latest) · [🎮 Скачать игру / Get the game](https://boosty.to/skide/posts/3ea5910c-28e8-4e7e-8f13-cef3e44840f1) · [📜 Изменения / Changelog](CHANGELOG.md)

[Русский](#-русский) · [English](#-english)

</div>

---

## 🇷🇺 Русский

Мод добавляет в Redux-Redux полноценный сетевой кооператив: всю сюжетную кампанию можно пройти вдвоём, втроём или вчетвером.

### Что нового в 2.2.2

- Исправлено: после смерти или подъёма клиент не мог ходить.
- Исправлено: у клиента после смерти/рестарта сбрасывалась или менялась маска.
- Исправлено: клиент не получал клюшку после добивания босса-Байкера и часто не мог поднять её с пола (скин BIKER по-прежнему не берёт чужое оружие — это правило персонажа).
- Совместима с 2.2 / 2.2.1 (тот же протокол). Подробнее — в [CHANGELOG.md](CHANGELOG.md).

### ✨ Возможности

| | |
|---|---|
| 👥 **До 4 игроков** | По IP: локальная сеть, Radmin VPN или ZeroTier. Хост ведёт уровень, клиенты подключаются к нему. |
| 🗺 **Вся кампания вместе** | Переходы между этажами, машина, сюжетные сцены, диалоги, сюжетные предметы и двери работают у всех одинаково. Уровень может закончить любой игрок, даже если хост погиб. |
| 🩹 **Падение и подъём** | Упавшего союзника можно поднять (E, 5 секунд). Погибшие наблюдают за игрой до перезапуска уровня. |
| 🎭 **Три персонажа** | **Jacket**; **Biker** (тесак и метательные ножи); **Martin Brown**, Мясник-свинья (удар головой и броня на одну пулю). |
| 🐔 **Маски** | У каждого игрока своя, все видят маски друг друга. |
| 📊 **Статистика** | На TAB: таблица игроков (персонаж, враги, казни, падения, пинг). После уровня — итоги по каждому. |
| 💾 **Общий прогресс** | Клиент при подключении получает сохранение хоста, а всё, что открылось в совместной игре, сохраняется у всех. |
| 📶 **Плавная сеть** | Интерполяция, предсказание своего движения, сглаженный пинг. |
| 🧾 **Журнал вылетов** | После вылета появляется окно с просьбой прислать `coop_crash_log.txt`, где есть текст ошибки и что происходило в игре. |

### 📦 Установка

1. Нужна установленная игра **Hotline Miami: Redux-Redux**. Скачать её можно на странице автора: [Redux-Redux на Boosty](https://boosty.to/skide/posts/3ea5910c-28e8-4e7e-8f13-cef3e44840f1). Это сама игра, а кооператив ставится поверх неё отдельно.
2. Скачайте `HLMR-R-Coop-vX.Y-patch.zip` из [Releases](../../releases/latest) и распакуйте его **в папку с игрой**, туда, где лежит `Hotline Miami Redux Redux.exe`.
3. Запустите `install-coop.bat`. Он проверит версию игры, сохранит копию оригинала (`data.win.original`) и установит кооператив.
4. Запускайте игру через **`Играть в кооп.bat`** и нажмите **F8** в главном меню.

> [!TIP]
> Играть можно и через обычный `.exe`, но с `Играть в кооп.bat` после вылета в журнал попадает сам текст ошибки, и сразу появляется окно с подсказкой.

### 🔄 Обновление со старой версии

> [!IMPORTANT]
> **Все игроки должны поставить одну и ту же версию**, иначе лобби откажет в подключении с причиной «версия».

**Если кооп ставили патчем (`install-coop.bat`, версии 2.0.2 и новее):**
1. Скачайте новый `…-patch.zip` и распакуйте его в папку с игрой **с заменой файлов**.
2. Запустите `install-coop.bat`.

Удалять старую версию не нужно: установщик собирает новую версию из сохранённого оригинала `data.win.original`. **Не удаляйте `data.win.original`**: это ваша оригинальная игра. Старые архивы `…-patch.zip` после установки можно удалить.

**Если стоит кооп из полного архива** (сборка со всей игрой, обычно 1.x), установщик скажет, что `data.win` — не оригинальная игра. Тогда верните оригинальный `data.win`: переустановите Redux-Redux с Boosty или возьмите `data.win` из чистой копии игры. После этого поставьте патч как обычно.

**Вернуть игру без коопа:** `uninstall-coop.bat` восстановит `data.win` из `data.win.original`.

### 🎮 Как играть

| Клавиша | Действие |
|---|---|
| **F8** | Лобби (в главном меню) |
| **TAB** (держать) | Таблица игроков: персонаж, враги, казни, падения, пинг |
| **F9** | Сетевой оверлей: соединение, пинг, отладочные данные |
| ЛКМ / ПКМ | Атака / подобрать или бросить оружие |
| Space | Казнь; у Мартина — удар головой по стоящему врагу |
| E | Поднять упавшего союзника |
| Shift | Посмотреть дальше |

**Хост:** F8 → ник → **CREATE GAME** → сообщите друзьям свой IP → **START**.
**Клиент:** F8 → ник → вставьте IP хоста (кнопка **PASTE IP**) → **JOIN GAME** → **READY**. Персонажа выбирает кнопка **SKIN**.

**Через интернет:** установите [Radmin VPN](https://www.radmin-vpn.com/ru/) или [ZeroTier](https://www.zerotier.com/), создайте общую сеть и подключайтесь по адресу хоста в этой сети (у Radmin VPN он обычно 26.x.x.x). Пинг до хоста видно в лобби, в главном меню и на TAB.

### 🆘 Если что-то пошло не так

<details>
<summary><b>Игра вылетела</b></summary>

После вылета (в окне ошибки GameMaker нажмите **Abort**) появится окно «Произошла ошибка». Пришлите файл:

```
%APPDATA%\Hotline_Miami_Redux_Redux\coop_crash_log.txt
```

Удобнее всего — в [Issues](../../issues/new/choose). В журнале есть версия, время, текст ошибки, последние события и сетевые пакеты.
</details>

<details>
<summary><b>«Это не та версия Redux-Redux» при установке</b></summary>

Нужна оригинальная версия мода с Boosty. Если раньше стоял кооп из полного архива или другой мод, верните оригинальный `data.win` (см. «Обновление со старой версии»).
</details>

<details>
<summary><b>Не подключается к хосту</b></summary>

- У всех одна версия коопа? Её видно в README.txt и в логе.
- Хост разрешил игру в брандмауэре Windows (UDP, порт 47800)?
- IP взят из Radmin VPN / ZeroTier, а не «внешний» IP провайдера?
</details>

### 🛠 Сборка из исходников

Код мода — в `src/gml` (GameMaker Language) и `base/gml`. Сборщик `tools/coopbuild2` (C#, UndertaleModLib) собирает `data.win`, а запускает сборку `tools/build.py`. Нужны .NET 10 SDK, Python 3 и UndertaleModTool 0.9.2; путь к нему задаётся переменной окружения `COOP_UTMT_DIR`. Патч релиза делает `tools/coopdelta`. Заметки по устройству — в [NOTES.md](NOTES.md).

---

## 🇬🇧 English

This mod adds full online co-op to Redux-Redux: play the whole story campaign with 2, 3 or 4 players.

### What's new in 2.2.2

- Fixed: client could not walk after death or revive.
- Fixed: client's mask reset or changed after death / level restart.
- Fixed: client did not get the Biker boss club and often could not pick it up from the floor (BIKER skin still does not pick up other weapons — by design).
- Compatible with 2.2 / 2.2.1 (same protocol). Details in [CHANGELOG.md](CHANGELOG.md).

### ✨ Features

| | |
|---|---|
| 👥 **Up to 4 players** | Over IP: LAN, Radmin VPN or ZeroTier. The host runs the level; clients connect to it. |
| 🗺 **The whole campaign together** | Floor transitions, the car, story scenes, dialogues, story items and doors are in sync for everyone. Any player can finish a level, even if the host is dead. |
| 🩹 **Down, not out** | Revive a downed teammate (hold E for 5 seconds). Dead players spectate until the level restarts. |
| 🎭 **Three characters** | **Jacket**; **Biker** (cleaver and throwing knives); **Martin Brown**, the Pig Butcher (headbutt and armor that stops one bullet). |
| 🐔 **Masks** | Each player picks their own mask, and everyone sees everyone's mask. |
| 📊 **Stats** | Hold TAB for the player table (character, kills, executions, downs, ping). Per-player results after each level. |
| 💾 **Shared progress** | A joining client receives the host's save; everything unlocked in co-op is saved for everyone. |
| 📶 **Smooth netcode** | Interpolation, client-side prediction, smoothed ping. |
| 🧾 **Crash log** | After a crash, a window asks you to send `coop_crash_log.txt` with the error text and what was happening. |

### 📦 Installation

1. You need **Hotline Miami: Redux-Redux** installed. Get it from the author's page: [Redux-Redux on Boosty](https://boosty.to/skide/posts/3ea5910c-28e8-4e7e-8f13-cef3e44840f1). That is the game itself; co-op is installed on top of it.
2. Download `HLMR-R-Coop-vX.Y-patch.zip` from [Releases](../../releases/latest) and extract it **into the game folder** (next to `Hotline Miami Redux Redux.exe`).
3. Run `install-coop.bat`. It checks your game version, backs up the original as `data.win.original` and installs co-op.
4. Start the game with **`Играть в кооп.bat`** ("play co-op") and press **F8** in the main menu.

> [!TIP]
> Launching the `.exe` directly works too, but with `Играть в кооп.bat` the crash log includes the actual error text, and a crash window shows up immediately.

### 🔄 Updating from an older version

> [!IMPORTANT]
> **All players must install the same version**, or the lobby rejects the connection ("version").

**If you installed co-op with the patch (`install-coop.bat`, 2.0.2 or newer):**
1. Download the new `…-patch.zip` and extract it into the game folder, **replacing files**.
2. Run `install-coop.bat`.

You don't need to uninstall first: the installer builds the new version from the saved `data.win.original`. **Do not delete `data.win.original`**, because it is your original game. Old `…-patch.zip` archives can be deleted after installing.

**If you have a full-archive co-op build** (the whole game, usually 1.x), the installer will say `data.win` is not the original game. Restore the original `data.win` (reinstall Redux-Redux), then install the patch as usual.

**To remove co-op:** `uninstall-coop.bat` restores `data.win` from `data.win.original`.

### 🎮 Controls

| Key | Action |
|---|---|
| **F8** | Lobby (main menu) |
| **TAB** (hold) | Player table: character, kills, executions, downs, ping |
| **F9** | Network overlay: connection, ping, debug data |
| LMB / RMB | Attack / pick up or throw a weapon |
| Space | Execute; Martin headbutts a standing enemy |
| E | Revive a downed teammate |
| Shift | Look further |

**Host:** F8 → nickname → **CREATE GAME** → tell your friends your IP → **START**.
**Client:** F8 → nickname → paste the host's IP (**PASTE IP**) → **JOIN GAME** → **READY**. Pick a character with **SKIN**.

**Over the internet:** install [Radmin VPN](https://www.radmin-vpn.com/) or [ZeroTier](https://www.zerotier.com/), create a shared network and connect to the host's address in it (usually 26.x.x.x for Radmin VPN). Ping to the host is shown in the lobby, the main menu and on TAB.

### 🆘 Troubleshooting

<details>
<summary><b>The game crashed</b></summary>

After a crash (press **Abort** in the GameMaker error window), a crash window appears. Please send:

```
%APPDATA%\Hotline_Miami_Redux_Redux\coop_crash_log.txt
```

The best place is [Issues](../../issues/new/choose). The log contains the version, time, error text, recent events and network packets.
</details>

<details>
<summary><b>"Wrong Redux-Redux version" when installing</b></summary>

You need the original mod from Boosty. If you had a full-archive co-op build or another mod, restore the original `data.win` (see "Updating from an older version").
</details>

<details>
<summary><b>Can't connect to the host</b></summary>

- Does everyone have the same co-op version?
- Did the host allow the game in Windows Firewall (UDP, port 47800)?
- Are you using the Radmin VPN / ZeroTier address, not your public IP?
</details>

### 🛠 Building from source

The mod code is in `src/gml` (GameMaker Language) and `base/gml`. The builder `tools/coopbuild2` (C#, UndertaleModLib) builds `data.win`; `tools/build.py` runs the build. You need the .NET 10 SDK, Python 3 and UndertaleModTool 0.9.2; set `COOP_UTMT_DIR` to its folder. `tools/coopdelta` makes the release patch. Design notes (in Russian) are in [NOTES.md](NOTES.md).

---

<div align="center">

Hotline Miami — © Dennaton Games / Devolver Digital. Redux-Redux — its respective authors.<br>
This repository contains only the co-op mod code and a patcher, **no game files**.<br>
Этот репозиторий содержит только код кооп-мода и патчер, **без файлов игры**.

</div>
