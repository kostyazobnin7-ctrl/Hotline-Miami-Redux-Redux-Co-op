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
