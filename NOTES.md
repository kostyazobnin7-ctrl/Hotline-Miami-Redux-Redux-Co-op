# HLMR-R co-op — заметки (с v1.4)

## Исходники v1.0–v1.3 утеряны

Репозиторий `Desktop\HLMR-R-coop` (сборщик `tools/coopbuild`, `src/gml`, git-история с тегами v1.0–v1.3)
исчез с диска 26.10.2026 между 11:41 и 12:50, в Корзине его нет. Если он найдётся (например,
в корзине OneDrive), правки v1.4 нужно перенести в него.

Чем заменено:
- база сборки — `work/base/data_v13.win` = `data.win` релиза 1.3 (sha256 `b8aed04330a5…`);
- `base/gml` — наш код v1.3 (`net_*`, `objCoop*`), декомпилированный из этой базы (без комментариев);
- `src/gml` — код v1.4: новые скрипты и изменённые копии из `base/gml` (замена целиком по имени);
- `tools/coopbuild2` — сборщик поверх базы: `src/gml` + правки игрового кода по декомпиляции;
- `tools/coopdump` — декомпиляция (`coopdump <win> <dir> <regex>`, `--info`, `--rooms obj,...`, `--objidx`);
- `tools/build.py` — сборка `work/build/data.win`, `data_pN.win` (имя игры `HLMR_R_Coop_pN`) и копии в `work/instances/pN`;
  `--release` кладёт `data.win` в `work/RELEASE`;
- `tools/stand.py run [--debug] [--clients N] | stop` — стенд (хост p1, клиенты p2..).

## Грабли

- `variable_global_exists` в нашем коде у клиента дал «trying to index a variable which is not an array»
  в `net_snd` (splash). Глобальные переменные инициализировать заранее (`net_story_init` из objCoopNet Create).
- Отладочный F1 без `scrInitScore` ронял экран очков хоста; теперь F1 вызывает его один раз.

## v1.4 (протокол 11)

- Экран очков у клиента: HUD несёт координаты последних 8 убийств, `net_kills_fill` дополняет
  `killx/killy` до `global.kills` (иначе `scrCountMobilityScore` падает).
- Сюжетные предметы: 26 объектов (`net_story_list`, генерирует сборщик) с глобальными событиями мыши.
  В сети событие выполняется только из `net_story_try` (хост: свои ЛКМ/ПКМ и ПКМ клиентов через счётчик pick,
  objPlayer на время ставится на место аватара) и `net_story_apply` (клиент повторяет). Пакет STORY (23)
  с кольцом событий, каждое повторяется 30 тиков, клиент применяет по номеру один раз.
- Пакет PROPS (24) раз в 15 тиков: где лежат сюжетные предметы; у клиента создаются недостающие
  (кейс в метро роняет враг, а враги у клиента выключены).
- Диалоги: `scrGetMessage` начинается с `net_msg_hook` — хост рассылает номер (STORY/MSG),
  клиент показывает только присланные (свой язык).
- Зоны (`objGirlfriend`, `objGirlfriendDead`, `objJanitorNotice`, `objJanitorVacuum`, `objCrocodileMan`,
  `objDeadTable`, `objDogPetCorpse`, `objFatCorpseEat`): чтения `objPlayer.x/y` → `net_zone_x/y()`,
  `place_meeting(.., objPlayer)` → `net_zone_meet` — ближайший живой игрок.
- Отладка: Shift+F1 — кейс у P2.

Проверено на стенде: экран очков после машины у клиента с kills 1; кейс по ПКМ клиента (исчез у обоих,
STAGE CLEAR у клиента); диалог туториала у клиента. Зоны вживую не проверялись.

## v1.4.1

- Вылет хоста при ударах ближним оружием: на месте objPlayer бывают дочерние объекты (objEnemyBash...)
  без dir/active. net_story_try берёт только object_index == objPlayer и выходит, если рядом нет предметов.
- Лобби: кнопка PASTE IP (CTRL+V), Ctrl+V в поле (IP/порт — замена целиком), Ctrl+C копирует поле.
- Отладка: Ctrl+F10 — оружие под P3. На стенде из 3 игроков P3 поднимает оружие нормально.

## v1.4.2

- Вылет клиента в rmInterlude: global.song у клиента 0 (net_globals_default), а string_length ждёт строку.
  Пакет FLOW (25), раз в 30 тиков и при смене комнаты: song (без working_directory), interlude, revisit,
  nextlevel, sequence, title, pretitle. objInterlude: is_string-проверка, клиент уходит в
  global.interlude только после FLOW (иначе 0 = первая комната игры).
- Проверка уязвимостей того же рода: из 416 нулевых умолчаний net_globals_default опасны те, что игра
  задаёт только по пути хоста (машина, выбор главы): song/interlude/revisit/nextlevel/sequence/title/
  pretitle — теперь в FLOW; killx/killy — в HUD (1.4). room_goto(global.*) в игре: level (WORLD),
  nextlevel, interlude, sequence (FLOW).
- Отладка: Ctrl+F1 — интерлюдия с песней Crystals и переходом в rmApartment1Entrance.

## v1.4.3

- Барьеры за спиной (objHorBarrier 22 комнаты, objVertBarrier 4): в оригинале solid = 1, как только
  objPlayer по ту сторону. В коопе хост, войдя первым, запирал клиентов снаружи. Step обоих заменён:
  net_barrier_closed — закрыт, только если все живые игроки (objPlayer/манекен + аватары) по ту сторону
  и никто не стоит в барьере. Проверено: rmApartment1Entrance, хост первым, клиент прошёл следом.
- coopdump: --inst <room> <obj,...> — экземпляры в комнате с координатами и creation code.

## v1.5 (протокол 12)

- Смерть хоста: net_player_inst(1) = -4, и net_party_travel выходил — клиенты не могли сменить этаж.
  Проходы (objTransitioner Collision_98 и др.) срабатывают только от objPlayerMouse и т. п., не от
  манекена objPlayer. Теперь клиент-ведущий поднимает хоста (DEAD -> DOWNED -> net_player_revive)
  и уводит группу; в новой комнате все и так живы (net_room_start). Проверено: rmApartment1Entrance.
  Внимание: на вокзале проходы закрыты (solid), пока виден поезд или есть враги, — это игра.
- net_story_try / хост ПКМ: настоящий игрок — objPlayerMouse и т. п. (net_player_has_vars), а не
  objPlayer (в 1.4.1 хост перестал брать предметы).
- Музыка: sxeasy_play / sxeasy_stop (скрипты игры) начинаются с net_music_hook. Хост хранит состояние
  (net_mus_seq, on, путь без working_directory) и шлёт FLOW сразу; клиент свои вызовы игнорирует и
  включает присланное. Проверено: Crystals в rmChapter, Static на CHAPTER CLEAR.
- Маски: клиент после перезапуска (net_on_level_restart -> net_mask_pick) получает objMaskMenu,
  ввод заморожен (net_mask_menu_open). Подтверждение — пакет MASK (26) раз в секунду; маски всех —
  в FLOW (u8 маска 255 = нет, u8 скин 0 ""/1 Skin/2 Hard); аватар рисует sprMasks* (net_mask_draw).
  Хост: global.maskonsaved = 0 в objEffector Step / objEffectorHouse Draw -> net_mask_restart_reset
  (в сети хост держит маску через maskload). Переход группы не начинается, пока у хоста открыто меню.
- CHAPTER CLEAR у клиента: scrCheckMissionComplete у клиента видел 0 врагов (выключены), ставил
  done = 1 и создавал objLevelComplete; WORLD сбрасывал done — повтор. Все «global.done = 1;» в коде
  игры (48 фрагментов, 151 место) -> net_done_set() (у клиента ничего). objLevelComplete Create ->
  net_lc_hook: у клиента только по STORY kind 3 (LC) от хоста.
- Отладка: Ctrl+F3 — objLevelComplete у хоста. stand.py убивает оставшиеся копии из instances.
