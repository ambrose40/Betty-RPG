# Betty RPG — project memory

Last updated: 2026-10-23. This is a maintained context snapshot; check the current code
and Git status before continuing work.

## Project identity and entry points

- A work-in-progress, top-down pixel-art action RPG migrated from GameMaker Studio
  2.3 to GameMaker LTS 2026.
- Workspace directory:
  `E:\PROJLIB\GAME\GameMakerStudio2026\Betty-RPG_LTS2026.yyp`.
  Despite its suffix, this path is a directory. The actual project file inside it
  is `Betty-RPG_LTS2026.yyp`.
- Verified platform: Windows x64, VM runtime, Default configuration.
- Tested runtime: `2026.0.0.23`; project IDE metadata: `2026.0.0.16`.
- Default logical GUI: 320 × 180; target frame rate: 60 FPS.
- Startup: `rInit` initializes `oGame` and globals, then `ROOM_START` selects
  `rTitle`. Keep initialization intact when bypassing the title for debugging.
- Main documentation: `README.md` for launch, controls, testing, and debugging;
  `CODE_REVIEW.md` for fixes and validation history; `CONTRIBUTING.md` for the
  development workflow and contribution conventions. `LICENSE` contains the MIT
  license (2026 Betty RPG contributors).
- No npm/Python dependency installation is needed to build the game.

## User requirements to preserve

1. **Top-left HUD:** health hearts, original continuous blue/black energy bar,
   selected weapon icon/name, consumable ammunition, and coins.
2. **Energy appearance:** the user explicitly rejected separated energy slots,
   thin black rectangular outlines, gaps, and half-height rendering. Keep the
   original full-height sprite rendering on the left:
   `draw_sprite(sEnergy, _imageIndex, 8 + ((i - 1) * 14), 22)`.
3. **Top-right minimap:** present in every playable room, not only the first beach.
   Preserve room proportions and respond to current GUI dimensions.
4. **Viewport outline:** show the actual visible camera area relative to the room,
   clipped to available room bounds; do not hard-code a 320 × 180 outline.
5. **Hook is reusable:** show `Hook`, never `Hook x0` or another ammunition suffix.
   Existing saves may store zero hook ammo. Hide counts based on item type rather
   than relying only on an ammo value of `-1`.
6. Weapon cycling/direct selection must be documented in F1 help.
7. README must describe real implemented behavior and actual packaged files,
   rather than promise unfinished features or unverified platforms.

## Implemented gameplay

- Exploration rooms: `rBeach`, `rBeachCamp`, `rBeachShip`, `rBeachTent`, `rCave`.
- `rMap` is the world-map room; `rInit`, `rTitle`, and `rParent` support startup,
  title selection, and room inheritance.
- Movement, diagonal travel, rolling, tile/entity collision, lifting, carrying,
  throwing, sword slashing, defense, knockback, flashes, and temporary immunity.
- Items: bombs, bow/arrows, reusable grappling hook. Weapons must be unlocked.
- Enemies include slimes, bats, and Beholders with state-based behavior.
- Coins/ammo drops, shops, queued dialogue with responses, and the missing-hat
  quest. The princess-rescue story is currently introductory text, not a finished
  campaign.
- Health/energy consumption, resting recovery, death animations, drops, stat
  reset, and room recovery. The label “Permadeath” does not mean save-slot deletion.
- Contextual music, screenshots, GIF recording, pause menu, and three save slots.
- `oBot` has prototype WASD movement; it is not complete cooperative gameplay.

## Controls

Bindings below apply to the game window, not the IDE:

| Input | Behavior |
| --- | --- |
| Arrow keys | Player movement |
| Ctrl | Sword attack |
| Hold End / Home | Defend / rest |
| Space | Interact; otherwise throw held object or roll; advance/confirm dialogue |
| Q / E | Previous / next unlocked weapon |
| 1 / 2 / 3 | Bomb / bow / hook, if unlocked |
| Alt | Use selected weapon; light/lift a bomb before throwing with Space |
| M | Open/close world map; opening requires free movement |
| Pause/Break | Pause menu; Up/Down and Space select an option |
| Hold F1 / C | Help / numeric stats overlay |
| Enter / Escape | Fullscreen toggle during gameplay / exit without explicit checkpoint save |
| F2 / F3 | Save / load selected checkpoint; use F2 during unpaused gameplay |
| F4 / G | PNG screenshot / toggle GIF recording |
| T / R | Introductory mission dialogue / restart to title |
| X / Z | Development shortcuts: force health depletion / energy depletion |
| Numpad +, -, 0 | Increase volume, decrease volume, mute |
| WASD | Prototype bot movement when present |

- Title: any key reveals slots, Up/Down or W/S selects, Enter/Space confirms.
- Dialogue responses: Up/Down or W/S, then Space.
- Item switching/use is handled by `PlayerStateFree`; actions/locks can delay input.
- F1 still contains an obsolete “Tab — Follow Betty” line. No Tab handler exists.
- Development shortcuts are active in normal builds too; they are not debugger-only.

## Code organization and implementation details

- `objects/`: object events and `.yy` metadata. Managers: `oGame`, `oUI`,
  `oCamera`, `oMinimap`. Core parents: `pEntity`, `pEnemy`, `pCollectible`.
- `scripts/`: player/bot/enemy state functions, items, combat, dialogue, quest,
  JSON save/load, helpers, macros.
- `.yyp` resource references determine active assets. There are legacy/backup
  files in resource directories; do not mistake them for active definitions.
- Register new object events in the object's `.yy`, not only by adding a GML file.
- Runtime flow: `oPlayer/Step_0.gml` collects input and executes the current state
  function while unpaused. `PlayerStateFree` handles movement, activation, weapon
  selection, and item use. Shared entity behavior uses the parent hierarchy and
  activation/hit callbacks.
- Match nearby GML style: tabs, PascalCase function/resource names, camelCase
  instance/global variables, underscore-prefixed local variables and arguments,
  and uppercase macro/enum names. Existing prefixes include `o`, `p`, `r`, `s`,
  `f`, and `sh` for objects, parents, rooms, sprites, fonts, and shaders.
- Player collision obtains its tilemap from the room's `Col` layer. Preserve that
  contract when editing room layers or collision layout.
- The `.yyp` currently has an empty `IncludedFiles` list. Files in `datafiles/`
  are not automatically evidence of data included in the build.
- Some rooms are persistent. A room-local minimap can retain its cache while its
  room is inactive; prevent duplicate minimaps on return.

### Minimap

- `oGame/Other_4.gml` creates a minimap at Room Start if absent, excluding `rInit`,
  `rTitle`, and `rParent`. The original beach also contains a placed minimap.
- Minimap depth is 10000 so it draws behind HUD/dialogue/transition overlays.
- Methods defined in `oMinimap/Create_0.gml`:
  - `UpdateMinimapLayout()`: fit the room into one quarter of current GUI width
    and one third of GUI height; position at the top-right with a 10-pixel inset.
    Free/invalidate the cached surface when dimensions change.
  - `GetMinimapViewport()`: convert camera coverage into map pixels and clip to
    room bounds. Return undefined if there is no camera.
  - `RefreshMapBG()`: lazily build cached terrain/background imagery in Draw GUI.
- Layout updates from both Step and Draw GUI, including while paused.
- Enumerate visible layers in depth order, then inspect their elements using
  `layer_get_element_type` and `layerelementtype_tilemap/background`.
  Exclude the `Col` collision layer.
- Do not hard-code a `Beach` tile layer. Tent/cave/world-map layers have other names.
- `layertype_tiles` and `layertype_background` are not valid constants in this
  runtime. `layer_get_type` describes room/UI layer kinds, not tile/background
  element kinds. This previously caused a runtime error despite successful compilation.
- Draw live enemy markers red, player green, and the clipped viewport outline white.
- Mouse interaction uses `device_mouse_x_to_gui` / `device_mouse_y_to_gui` and
  current room-to-map scaling.
- `oMinimap/CleanUp_0.gml` releases the cached surface. Lost surfaces are rebuilt.
- Fullscreen changes presentation scaling; it does not automatically enlarge the
  camera's world-space view. Test GUI resizing and camera resizing separately.

### HUD and weapon selection

- `oUI/Draw_64.gml` draws the HUD, overlays, and pause presentation.
- Only `ITEM.BOMB` and `ITEM.BOW` receive ammo suffixes; `ITEM.HOOK` does not.
- Player Step reads Q/E and number-key input. `PlayerStateFree` selects the weapon
  before using it and bounds the cycling loop to prevent hangs with no unlocked items.

## Save system and important fixes

- Save code: `scripts/JSON/JSON.gml`; paths/buffers: `scripts/Helper/Helper.gml`.
- Observed Windows sandbox: `%LOCALAPPDATA%\Betty_RPG_LTS2026\`.
- Checkpoint slots are directories `save0.sav`, `save1.sav`, `save2.sav`, containing
  `savegame.json` and room JSON snapshots. Working session snapshots use
  `Save_<date_and_time>` directories.
- `.json` files are written through string buffers and may end in a null terminator.
- Pause-menu Save & Quit returns to the title; Save and Quit to Desktop exits.
- Room snapshots are distinct from explicit numbered-slot checkpoints.
- New saves preserve optional `image_index` and `runtimeState` fields for throws,
  gravity, bomb stage, and fuse countdown. Old saves without trajectory state
  safely stop throws; missing historical fuse data cannot be recovered.
- This LTS runtime serializes global script callbacks as named references such as
  `@ref script(ActivateLiftable)`. Restored pickup callbacks were executed in tests.
- Restored pickup arguments must use newly created IDs, including bombs whose
  `entityActivateType` is not `pickup`.
- Supply a shop item's saved `item` in the creation-variable struct before Create
  runs; default bomb ownership could otherwise destroy an unrelated restored item.
- Suppress Destroy events with `instance_destroy(id, false)` when replacing saved
  entities, so existing bombs do not explode during loading. Clean Up still runs.
- Ordinary room revisits preserve the new doorway destination; checkpoint loads
  restore saved player coordinates. Apply placement explicitly to recreated players.
- GameMaker `file_copy` does not overwrite. Checkpoint copying deletes destination
  files first and removes session room files absent from the checkpoint.

Other completed bug fixes:

- Player/bot movement lists are cleared between axes and destroyed after use.
- Player attack lists are freed by a registered Clean Up event.
- `SetGamePaused` saves/restores animation and built-in movement speeds; paused
  arrows, collectible updates, and player damage paths are guarded.
- Facing index uses `(round(direction / 90) mod 4)` to wrap directions near 360.
- Captain dialogue includes the goodbye response in the response array.
- `ScriptExecuteArray` accepts empty argument arrays; empty loot arrays do nothing.
- Hook retraction checks target existence; activation ignores invisible entities
  and checks a target still exists after executing its callback.
- Explosions include the player object itself in their hit check and calculate
  knockback from explosion coordinates.
- Hat completion locates the NPC by `ActivateHatCat`, not a stale room-instance
  ID; returned hats disable activation with `-1` and use the correct owner's position.
- Map access checks player existence and conflicting player states.

## Launch, build, and debug

- IDE: open `Betty-RPG_LTS2026.yyp`, Windows / VM / Default, F5 to run, F6 to debug.
- Install included `m3x6.ttf` / `m5x7.ttf` if the IDE substitutes missing fonts.
- README has a verified PowerShell CLI build example. It reads `runtimeLocation`
  and `userDir` from the IDE-generated
  `%LOCALAPPDATA%\GameMakerStudio2-LTS2026\GMS2TEMP\build.bff` after an IDE build.
- Current runtime location:
  `C:\ProgramData\GameMakerStudio2-LTS2026\Cache\runtimes\runtime-2026.0.0.23`.
  Compiler: `bin\igor\windows\x64\Igor.exe`; use `Windows Compile`, `--runtime=VM`.
  Runner: `windows\x64\Runner.exe -game <compiled .win path>`.
- Agent scratch/build artifacts have been stored outside the repository in
  `C:\Users\boris\AppData\Local\Temp\opencode`.
- Breakpoint targets: `PlayerCollision`, `HurtPlayer`, `PlayerStateHook`,
  `SaveGame`/`LoadRoom`, `UpdateMinimapLayout`, and `GetMinimapViewport`.
- Useful globals: `playerEquipped`, `playerAmmo`, `playerItemUnlocked`, `iLifted`,
  `gamePaused`, `gameSaveSlot`, `saveFolder`, `questStatus`, and target player position.

## Validation history

- Windows VM compilation succeeded repeatedly, including a fresh run of the
  README's CLI build example.
- Temporary in-engine audits passed:
  - 39 gameplay/save/load/resource-cleanup checks.
  - 70 multi-room minimap/HUD/surface-recovery checks, with screenshots inspected.
  - 70 responsive GUI/camera/room and exact weapon-label checks.
- Responsive cases included GUI sizes 320×180, 640×360, 480×270; smaller/larger
  camera views; clipped/off-room coverage; and a hook with stored ammo zero.
- Audit hooks/resources were removed. There is no checked-in automated test runner;
  do not describe the historical audit commands as a portable test suite.
- README contains the repeatable manual smoke-test checklist.
- Regular playtesting is still needed for complete room layouts, encounter balance,
  keyboard-driven quest/save/relaunch flows, and packaged distributions.

## Packaged distributions

Files currently provided at repository root:

- `Betty-RPG_LTS2026.exe`: NSIS Windows installer.
- `Betty-RPG_LTS2026.zip`: runnable ZIP export.
- `Betty-RPG_LTS2026_arm.exe`: ARM-labelled NSIS installer.
- `Betty-RPG_LTS2026_arm.zip`: ARM-labelled runnable ZIP export.

Both ZIPs contain `Betty-RPG-2.3.exe`, `data.win`, `options.ini`, `splash.png`.
Keep these together after extraction. The internal executable name remains the
configured legacy name; it does not imply the new package is the old build.

**Important observed packaging issue:** inspecting the game executable inside
all four packages found PE machine `0x8664` (x64), including the `_arm` variants.
Native ARM64 support is not established; verify/re-export rather than assuming
architecture from the filename. All four archives passed `7z t` integrity tests.
Installers were inspected without installation; a full packaged playthrough was
not performed as part of the source audits.

F5 builds do not refresh repository installers/ZIPs. Re-export packages when
source changes need to be distributed. Packaged and IDE runs can share save slots.

## Git context at the time of writing

- Repository exists in the workspace directory above.
- Current branch: `migration/lts2026`, tracking `new-origin/migration/lts2026`.
- Recent commits:
  - `579d41e4`: README content and installer/ZIP distributions.
  - `852b0e89`: beach shack/house collision correction.
  - `d9281adf`: responsive minimap, hook HUD label, and energy appearance fixes.
  - `4f1903c0`: LTS2026 migration and gameplay bug fixes.
  - `64b050ef`: removal of old top-level `html5/` and `support/` folders.
- `options/html5/` is platform configuration and remains part of the project.
- At the start of the 2026-10-23 documentation review, `.agents/` was untracked;
  tracked files were clean. The existing memory was preserved and updated in place.
  Recheck status rather than assuming future room edits or exports belong to the
  current task.

## Documentation maintenance

- The 2026-10-23 review compared the README and memory with project metadata,
  startup/Room Start, player input/state handling, HUD/minimap, save helpers, and
  migration notes. README now includes an architecture overview and links to
  memory, contribution guidance, and the MIT license.
- `CONTRIBUTING.md` documents Windows VM setup, resource/event registration,
  save/pause/HUD/minimap invariants, issue/PR details, and targeted smoke testing.
- Keep public usage instructions in README, contributor workflow in CONTRIBUTING,
  historical audit results in CODE_REVIEW, and implementation context here.
- Documentation-only changes do not require a game build. Do not present the
  historical runtime audits as freshly executed validation.

## Known unfinished areas

- `AttackSpin()` is a placeholder.
- Princess-rescue story/campaign and full bot/co-op functionality are unfinished.
- F1's Tab-follow text has no corresponding control.
- Debug shortcuts are exposed in normal runs.
- Gamepad input is not wired; normal Windows window resizing is disabled.
- Native ARM64, other platform exports, and YYC require separate verification.
