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

## v1.6 (протокол 13)

- ESC: пауза = room_goto(rmPause) с сохранённой (persistent) комнатой, возврат в global.lastroom.
  net_room_start на хосте ставил всем ALIVE — пауза оживляла. Теперь вход в rmPause и возврат
  (net_rs_last == rmPause, room == lastroom, PauseRestart == 0, не перезапуск) пропускаются,
  аватары переподхватываются (with objCoopAvatar -> global.av[pid], иначе появлялись двойники).
  На паузе хоста net_ps_update не идёт (таймеры, «все мертвы» -> перезапуск).
- Маска хоста: убрана правка 1.5 (maskonsaved). После перезапуска в сети net_level_restart ставит
  net_mask_pick и у хоста; net_mask_pick_step создаёт objMaskMenu и хосту, и клиентам.
- NPC/сюжетные предметы: свои клики хоста — без фильтра расстояния (как оригинал, событие получают
  все предметы), клиенты — ST_NEAR_CL = 48 (было 24 для всех).
- Особые подборы клиентов: net_c_pickup_special генерирует сборщик из scrPlayerPickUp до
  «release = 0;» (буквы, маски с пола, улики, коробки, подарки, патроны). Хост выполняет его за
  клиента (net_pickup_special, objPlayer на месте аватара), клиент повторяет (STORY kind 4 PICK) —
  разблокировка попадает и в его saves.dat.
- Прогресс: PROG (27) раз в 2 с — levels[24], masks[27], newgun[16], letter[16]. Первый пакет
  сессии — точка отсчёта; открытое хостом после неё открывается у клиента + scrSaveUnlocked.
- Отладка: Ctrl+F2 — P2 к букве (objToken), Ctrl+F12 — levels[10] = 1 у хоста.
- Проверено на стенде: буква клиентом (у обоих), PROG («открыто от хоста 1, сохранено»), хост
  мёртв -> пауза -> остался мёртвым, аватар клиента на месте; выбор маски у хоста после перезапуска.
  NPC в домашних сценах вживую не проверялись.

## v1.7 (протокол 14)

- CLEAN HIT: objJanitorVacuum Step обращался к objPWalkWindow.active, а зона срабатывала и от
  других игроков. В зонах «objPWalkWindow|objPlayerMouse|objPlayerBikerHouse.поле = ...» -> with (...).
- Shift: cam_follow клиента — с Shift цель камеры смещается к курсору (как aimfar у objPlayerMouse).
- Переход группы: проверка «хост выбирает маску» больше не выходит из цикла — аватары взводятся
  (pt_armed), ждёт только сам переход. Проверено: P2 в двери во время меню -> после маски ушли.
- Боссы: objBoss2 (Байкер) — state 1000 только если живых нет (net_any_alive), без цели — exit;
  objBoss2Pry: with (objPlayer) -> with (net_tgt()); objBoss2Crawl: добивает только хост
  (net_tgt_is_host); objPClubBoss2 -> net_boss_drop_club (оружие 2 на полу). objPanther: укус
  аватара -> net_panther_bite (net_enemy_melee_hit(1)), пантера остаётся. Вживую не проверено.
- Скин Байкера: net_skin_my (лобби), MASK(26) +байт скина, LOOK(28) хост -> всем (скины, настройка
  масок, save_ok). Аватар: net_skin_spr (sprPAttack* -> sprBoss2AttackCleaver, sprPWalkUnarmed ->
  sprBoss2Walk, sprPWalk* -> sprBoss2WalkCleaver), маска не рисуется. Хост: objPlayerMouse Draw ->
  net_skin_draw_self.
- Сохранение: SAVE(29) — saves.dat хоста строками; клиент копирует своё в saves_before_coop.dat,
  пишет, scrLoadUnlocked, SAVE_ACK(30). net_host_can_start ждёт pl_save_ok. Полоса — net_save_bar_draw.
- MASK PICK ON RESTART (хост, лобби, LOOK): OFF — net_mask_restart_reset держит маску (maskload),
  net_mask_pick_step не открывает меню. Проверено ON и OFF.
- Отладка: Ctrl+F6 — удалить врагов этажа. win.ps1: -Ctrl, -AimX/-AimY вместе с -Key.

## v1.8 (протокол 15)

- Байкер (pl_skin = 1) — только клиенты; хост всегда Джек (net_skin_my = 0 у хоста, кнопка SKIN у
  хоста выключена): заменить objPlayerMouse хоста на objPlayerBiker ломает сюжетный код.
- Механика (хост, net_wpn_update): у Байкера pw_wpn = 18 (мачете ~ тесак, одним ударом), подбор
  оружия выключен; ПКМ — особые подборы/сюжет, иначе net_biker_throw: objThrowingKnife как
  objPlayerBiker Mouse_51, pk_knives (3, хард 1) сбрасывается в net_room_start. LOOK(28) +ножи.
- Вид: net_skin_spr — sprPAttack* -> sprBoss2AttackCleaver, sprPWalk* -> sprBoss2WalkCleaver,
  sprPBack*/sprPFront* -> sprMCBack*/sprMCFront* (лежит/убит), казни -> sprMCKillCut/Chop/Stomp.
  Казнь у хоста: аватар скрыт, рисует objCoopNet Draw (net_biker_exec_draw); спрайт — net_exec_lspr,
  а если -1 (обычные казни, objPMacheteKill и т. п.) — sprite_index объекта казни; кадр — по доле
  прогресса. Клиентам — подмена спрайта сущности BODY в net_ents_send.
- HUD: net_pl_label («Имя [BIKER]»), net_wpn_text у Байкера — «Тесак  ножи N».
- Проверено на стенде: лобби BIKER, нож (2 осталось), казнь у хоста и клиента в спрайтах Байкера,
  лежащий Байкер в sprMCBack*. Скорость Байкера в оригинале та же, что у Джека (myspeed 3).

## v1.8.1 (протокол 16)

- Вылет хоста scrDrawHUD: «objPlayer.поле» брал первый экземпляр objPlayer/детей — во время казни
  клиента это объект казни (objPTigerKill и др., нет ammo). В scrDrawHUD, scrStoryDrawAmmo,
  objEffector/objEffectorHouse Draw чтения -> net_hud_player() (свой игрок, не казнь клиента).
- Хост-Байкер: pl_skin[1] = net_skin_my; net_host_biker_step — спрайт ходьбы -> sprPWalkMachete;
  scrPlayerPickUp -> net_host_biker_pick (особые подборы, иначе нож); objPlayerDead Draw — тело
  Байкера; казнь хоста рисует objCoopNet Draw. ВАЖНО: Draw objPlayerMouse ведёт состояние (dir к
  мыши, reload--, light) — net_skin_draw_self теперь делает это сам (в 1.7–1.8 хост-скин ломал
  перезарядку и прицел).
- Проверено: казнь клиентом при хосте-Байкере без вылета, нож хоста. Казнь хостом-Байкером — нет.

## v1.8.2 (протокол 17)

- «Trying to draw non-existing sprite» в Draw objPlayerMouse: objMaskMenu KeyPress_13 писал
  objPlayer.masksprite/maskindex первому экземпляру objPlayer-семейства; игрок хоста оставался со
  sprPMaskSlip и masksprite = -1. Теперь «var __nmv = <выражение>; with (objPlayer) поле = __nmv;»
  (значение считается ДО with — внутри with select читался бы у игрока -> вылет, проверено).
  Плюс в Draw objPlayerMouse и scrDrawMask draw_sprite_ext -> net_draw_sprite_ext (пропуск -1).
- Байкер: кадр по доле анимации (net_skin_frame), а не mod — удары не обрываются.

## v1.9 (протокол 18)

- Журнал сбоев (try/catch в GMS 1.4 нет): objCoopNet Create -> net_crash_init — если осталась метка
  coop_running.flag, прошлый запуск вылетел: coop_context.txt -> coop_crash_context.txt, crash_prev,
  красная подсказка в меню (Draw_64) и строка в журнале при старте сети. Метка снимается в Game End
  (objCoopNet Other_3 -> net_crash_clean_exit). net_crash_ctx раз в секунду и при смене комнаты:
  режим, комната, игроки, все objPlayer-семейство с объектами и спрайтами, число врагов/боссов.
  Проверено: kill -> подсказка и файл; QUIT GAME -> метки нет.
- Итоги уровня: net_stats_update (хост) — исчезнувший objEnemy ближайшему живому игроку; казни:
  клиенты в net_avatar_execute, хост — его игрок стал объектом *Kill*; падения в net_player_down.
  Сброс при входе в rmChapter. LOOK(28) + 3 x u16 на игрока. net_score_ui в rmScore/rmScoreDetails.
  Проверено: P1 2 врага 1 падение, P2 1 казнь — у хоста и клиента.

## v2.0 (протокол 19)

- Мартин Браун: в игре нет objPlayerMartin (есть только sprMartinDead). Используется Мясник-свинья
  (objPigButcher, rmTrailer) — роль Мартина в HLM2. pl_skin = 2, кнопка SKIN 0/1/2.
- Спрайты: net_skin_spr_martin — sprPWalkX/sprPAttackX -> sprPigButcherWalk/AttackX (Kalashnikov->AK,
  NightStick->Stick, DoubleBarrel1), запасные Club; без оружия sprPigButcher/Attack; лежит/убит
  sprPigDeadBlunt/Shot; казни sprPigButcherKill/Stomp. Ноги sprPigButcherLegs. Маска не рисуется.
- Удар головой (scrHeadButtEnemy + objPigHeadButt): net_martin_headbutt — objEnemy в 12 px спереди
  (кроме objDogPatrol, objEnemyFat, полиции, objEDodger/G), сразу убит (sprEDeadHammer, очки 200+400).
  Аватар: Space сначала удар головой, иначе net_avatar_execute (иначе захват за горло objPAttackThroat).
  Хост: objPlayerMouse KeyPress_32 -> net_host_martin_space, анимация — таймер mh_t в net_skin_draw_self.
- Броня (Collision_209 objPigButcher, energie): pk_armor = 1 на этаж; аватар — net_avatar_take_hit,
  хост — objPlayerMouse Collision_209 -> net_martin_armor. LOOK + u8 броня.
- Обобщено на любой скин: net_biker_exec_draw(exec, skin), ents_send, objPlayerDead Draw, HUD.
- Проверено: лобби MARTIN у обоих, броня хоста поглотила пулю, удар головой клиента убил врага,
  спрайты Мясника. Не проверено вживую: удар головой хоста, броня клиента (тестовая пуля мимо).

## v2.0.1 (протокол 20)

- Вылеты хоста scrDrawPlayer (objPMacheteKill.last_sprite) и objDrink Step (objPlayer.drank): тот же
  корень, что в 1.8.1, — «objPlayer.поле» берёт первый экземпляр семейства, а это бывает объект казни
  клиента. Сборщик (раздел 15) теперь во всём коде игры (кроме net_* и objCoop*): чтения ->
  net_hud_player().поле (1092), записи -> var __npw = ...; with (net_hud_player()) поле = __npw (409),
  262 фрагмента. scrDrawPlayer: в with (objPlayer) пропуск манекена и казней клиентов.
- Проверено: полный путь (казнь клиента-Байкера objPMacheteKill + пауза хоста во время неё, падение,
  машина, итоги) без вылетов. objDrink (бар) вживую не проверен — до него стенд не доходит.
