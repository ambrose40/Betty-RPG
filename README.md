# Betty RPG — GameMaker LTS 2026

A work-in-progress, top-down pixel-art action RPG, migrated from GameMaker Studio
2.3 to **GameMaker LTS 2026**. The current prototype includes connected exploration
areas, combat, usable items, NPC dialogue, a hat-retrieval quest, shops, and
three save slots.

**To play without the IDE, use the packaged EXE installer or ZIP below.**
To build, edit, or debug the source, open
[`Betty-RPG_LTS2026.yyp`](Betty-RPG_LTS2026.yyp) in GameMaker.

## Contents

- [Launch the game](#launch-the-game)
- [Implemented features](#implemented-features)
- [Controls](#controls)
- [Saves and captured files](#saves-and-captured-files)
- [Test the game](#test-the-game)
- [Debug the game](#debug-the-game)
- [Command-line build](#command-line-build)
- [Project structure](#project-structure)
- [Architecture overview](#architecture-overview)
- [Current limitations](#current-limitations)
- [Contributing](#contributing)
- [License](#license)

## Launch the game

### Play a packaged build — no GameMaker installation needed

| Download | Format | Current executable architecture |
| --- | --- | --- |
| [Betty-RPG_LTS2026.exe](Betty-RPG_LTS2026.exe) | Windows installer | x64 |
| [Betty-RPG_LTS2026.zip](Betty-RPG_LTS2026.zip) | ZIP containing the runnable game | x64 |
| [Betty-RPG_LTS2026_arm.exe](Betty-RPG_LTS2026_arm.exe) | ARM-labelled Windows installer | Currently contains an x64 game executable; see below. |
| [Betty-RPG_LTS2026_arm.zip](Betty-RPG_LTS2026_arm.zip) | ARM-labelled ZIP export | Currently contains an x64 game executable; see below. |

**Architecture note:** inspection of all four packages found an x64 game
executable (PE machine `0x8664`), including the `_arm` variants. The `_arm` filename
does not currently identify a native ARM64 executable. Native Windows ARM64
support needs a corrected export and testing on ARM64 hardware.

#### EXE installer

1. Download `Betty-RPG_LTS2026.exe` for a Windows x64 PC.
2. Run the installer and follow its setup wizard.
3. Launch the game using the installed shortcut, or run `Betty-RPG-2.3.exe` from
   the installation directory.
4. Press any key at the title screen, choose a slot with **Up/Down** or **W/S**,
   and confirm with **Enter/Space**.

#### ZIP build

1. Download `Betty-RPG_LTS2026.zip` and use **Extract All** into its own folder.
2. Keep these files together:

   ```text
   Betty-RPG-2.3.exe
   data.win
   options.ini
   splash.png
   ```

3. Run the extracted `Betty-RPG-2.3.exe`, then select a save slot at the title
   screen. Run it from the extracted folder, not from inside the ZIP.

The internal name `Betty-RPG-2.3.exe` is still the configured Windows executable
name; it does **not** mean the new LTS package is an old build. The `_arm` ZIP has
the same internal filenames. GameMaker and the source fonts do not need to be
installed to play these packaged builds.

Packages are snapshots of the source when exported. Running **F5** in the IDE
does not refresh the repository's installer/ZIP files; export them again to
include later source fixes.

### Development requirements

- **GameMaker LTS 2026**, with the Windows runtime installed.
- **Windows x64** for the build/run workflow verified here.
- A keyboard; a mouse is used for the minimap's camera-preview interaction.
- Install the included [m3x6.ttf](m3x6.ttf) and [m5x7.ttf](m5x7.ttf) fonts if
  GameMaker reports missing fonts or substitutes the UI text. Restart the IDE
  after installing them.

The migration was built and tested with **runtime `2026.0.0.23`**. The project
metadata records **IDE `2026.0.0.16`**. Windows **VM** is the verified target;
other platform option files are present but do not establish tested support.
No npm, Python, or external package-install step is required for the game.

### Run from the IDE

1. Open `Betty-RPG_LTS2026.yyp` in GameMaker LTS 2026.
2. Select the **Windows** target, **VM** runtime, and **Default** configuration.
3. Choose **Run** or press **F5** in the IDE.
4. In the game window, press any key to reveal the save-slot menu.
5. Select one of the three slots with **Up/Down** or **W/S**.
6. Press **Enter** or **Space**. An empty slot starts on the beach; an occupied
   slot loads its saved checkpoint.

The startup sequence is `rInit` → `oGame` initialization → `rTitle`. The game uses
a **320 × 180 logical GUI resolution** and a **60 FPS** target. Fullscreen scales
the presentation; it does not by itself change the camera's world-space size.

## Implemented features

| System | Current implementation |
| --- | --- |
| Exploration | Beach, beach camp, ship harbour, tent interior, and cave, with room exits and screen transitions. A separate world-map room can be opened and closed with **M**. |
| Player movement | Four-direction facing, diagonal movement, tile/entity collision, rolling, knockback, and action/locked/death states. |
| Combat | Sword slash, defensive action, hit tracking, temporary invulnerability, damage flashes, and camera shake. |
| Items | Consumable bombs and bow ammunition; a reusable grappling hook. Weapons can be selected after unlocking them. |
| World interaction | Talk to NPCs, read signs, buy equipment, break supported objects, collect coins/ammunition, and lift/carry/throw supported objects. |
| Enemies | Slime, bat, and Beholder enemy types, using state-based behavior such as wandering, chasing, attacking, taking damage, and dying. |
| Health and energy | Health hearts and an energy meter. Movement and actions consume energy; resting restores energy and health. Health or energy depletion triggers the death flow. |
| Dialogue and quest | Queued text boxes, selectable responses, shop purchase dialogue, and a quest to retrieve and return a missing hat. **T** also displays the princess-rescue introduction. |
| Player HUD | Top-left health, continuous blue/black energy bar, selected weapon icon/name, consumable ammo count, and coins. The hook has no ammo suffix. |
| Minimap | Top-right map in every playable room, built from visible terrain/background layers. Green marks the player; red marks enemies; the white outline shows the camera's visible room area. |
| Responsive map layout | Map sizing follows the current GUI dimensions and room proportions. Its maximum drawing area is one quarter of GUI width by one third of GUI height; cached imagery is rebuilt when its size changes. |
| Saving | Three checkpoint slots with JSON-backed inventory, stats, quest progress, player position, room entities, and supported throw/bomb runtime state. Room snapshots also preserve changes during a session. |
| Audio and capture | Music changes for exploration, combat, dialogue, map, and death. PNG screenshots and GIF recording are available. |
| Bot prototype | A separate `oBot` character has **WASD** movement. This is a development/prototype feature, not a complete cooperative-play mode. |

The death implementation includes animations, dropped coins/bomb ammunition,
stat resets, and a transition back into the room. Some code/UI calls this
“Permadeath”; it does **not** currently mean permanent deletion of the save slot.

## Controls

These bindings apply when the **game window** has focus. IDE shortcuts are
separate. Item switching and use are handled in the player's free-movement state,
so they may not respond during an attack, roll, dialogue, or transition.

### Playing

| Key | Action |
| --- | --- |
| Arrow keys | Move the player. |
| **Ctrl** | Sword slash. |
| Hold **End** | Defend. |
| Hold **Home** | Rest to recover health and energy. |
| **Space** | Interact with a nearby object/NPC; otherwise throw a carried object, or roll if empty-handed. In dialogue, reveal/advance text or confirm a response. |
| **Q / E** | Select the previous/next unlocked weapon. |
| **1 / 2 / 3** | Select Bomb / Bow / Hook, if unlocked. |
| **Alt** | Use the selected weapon. For bombs, this lights a bomb and puts it in your hands; use **Space** to throw it. |
| **M** | Open/close the world map. Opening requires normal free movement. |
| **Pause/Break** | Toggle the pause menu. Use **Up/Down**, then **Space**, to choose an option. |
| Hold **F1** | Show the in-game help overlay. |
| **Enter** | Toggle fullscreen during gameplay. |
| **Escape** | Exit the game; this does not explicitly write a checkpoint. |

In dialogue, **Up/Down** or **W/S** selects a response. In the title menu, use
**Up/Down** or **W/S** and confirm with **Enter/Space**.

### Development and utility keys

These shortcuts are currently active in normal runs as well as debugger runs.
Use save/load and player-state shortcuts after entering a gameplay room.

| Key | Action |
| --- | --- |
| **F2** | Save a checkpoint to the selected slot. Use during normal, unpaused gameplay. |
| **F3** | Load the selected slot's latest checkpoint, discarding later session changes. |
| **F4** | Save a timestamped PNG screenshot. |
| **G** | Start/stop GIF recording; stopping writes the GIF file. |
| Hold **C** | Show numeric coins, health, and energy. |
| **T** | Display the introductory mission dialogue. |
| **R** | Restart to the title flow without explicitly saving a checkpoint. |
| **X** | Force health below zero to exercise the death flow. |
| **Z** | Set energy to zero to exercise exhaustion/death. |
| Numpad **+ / -** | Increase/decrease music volume while held. |
| Numpad **0** | Mute music. |
| **W/A/S/D** | Move the prototype bot when present. |
| Left mouse button on the minimap | Preview a camera position. Normal camera following resumes afterward. |

The F1 overlay still contains a legacy **“Tab — Follow Betty”** entry. There is
currently no corresponding Tab input handler; it is not a working control.

## Saves and captured files

On the verified Windows setup, GameMaker's sandbox stores writable files under:

```text
%LOCALAPPDATA%\Betty_RPG_LTS2026\
├── save0.sav\                  # First menu slot
├── save1.sav\                  # Second menu slot
├── save2.sav\                  # Third menu slot
│   ├── savegame.json           # Checkpoint, including the current room
│   └── r*.json                # Snapshots of visited rooms
├── Save_<date_and_time>\       # Working room snapshots for a session
├── Betty RPG - Screenshot - <timestamp>.png
└── Betty RPG - Capture - <timestamp>.gif
```

The `.sav` entries are **directories**, not individual files. Exact sandbox
location can vary with the executable/project name and GameMaker platform settings.
The JSON documents are written through GameMaker string buffers, so a file may
include a trailing null terminator.

- For a normal save-and-exit flow, press **Pause/Break**, then choose **Save & Quit**
  to return to the title, or **Save and Quit to Desktop** to exit.
- Moving between rooms writes session snapshots. This is distinct from explicitly
  saving a checkpoint to a numbered slot.
- For a fresh test, select an unused slot. To reset a slot, close the game and
  move its complete `saveN.sav` directory out of the sandbox.
- Screenshot/GIF filenames are also printed to GameMaker's output log.

Older saves without the newer runtime-state fields are accepted. An old thrown
object safely stops its throw instead of using missing trajectory variables;
a bomb timer that was never stored cannot be reconstructed. See
[`CODE_REVIEW.md`](CODE_REVIEW.md) for the migration details.

## Test the game

### Test the EXE and ZIP distributions

1. **Installer:** install the standard EXE, launch the installed game, and start
   an unused save slot. Work through the smoke-test checklist below.
2. **ZIP:** extract the standard ZIP into a separate folder and launch its own
   `Betty-RPG-2.3.exe`. Repeat the same checklist so both distributions are tested.
3. **Persistence:** in each distribution, use **Save and Quit to Desktop**,
   relaunch that distribution, and load the same slot. Check inventory, quest
   progress, player position, and the HUD.
4. **Export freshness:** check weapon selection, the hook label without an ammo
   suffix, the continuous left-side energy bar, and the minimap in multiple rooms.
   If a package differs from a fresh IDE run, rebuild and re-export the package.
5. **ARM-labelled packages:** test these separately from the standard downloads.
   Their current x64 payloads are not evidence of native ARM64 compatibility;
   native ARM64 validation must use an actual ARM64 export on ARM64 hardware.

IDE and packaged builds can share the same save sandbox. Use an unused slot when
checking a distribution. When reporting a problem, include the exact package
filename, Windows/device architecture, reproduction steps, and an **F4** screenshot
or **G** recording when useful.

### Repeatable smoke-test checklist

Run these checks on an unused save slot in the installed game, extracted ZIP
build, or IDE run. Use the IDE debugger when investigating a failure:

1. **Startup and HUD:** reach the beach from the title menu. Check hearts, energy,
   coins, the weapon panel, and the top-right minimap. A new game starts without
   unlocked item weapons; the sword attack is separate.
2. **Movement and interaction:** move in all directions, roll into walls and
   objects, talk to NPCs, advance queued text, and select dialogue responses.
3. **Loot and shops:** break supported pots/plants/rocks, collect coins, and buy
   bombs, bow, and hook. Check that unlocked weapons can be selected with both
   **Q/E** and the number keys. Locked weapons must not become selectable.
4. **Items:** shoot arrows, light/throw a bomb, and grapple supported objects.
   Bombs/arrows consume stock; the hook is reusable and displays no `x0` suffix.
5. **Rooms and map:** visit the beach, camp, ship, tent, and cave. Check their
   individual minimap backgrounds and markers. From an outdoor room, open the
   world map with **M**, then return and check the player position.
6. **Pause/resume:** pause while enemies, loot, or a projectile are active. Check
   that movement, collection, and damage stop, then resume normally.
7. **Save/relaunch:** save and quit, launch again, select the same slot, and verify
   position, inventory, ammo, coins, health/energy, and quest progress. Also check
   room revisits use the correct entry doorway.
8. **Transient save state:** save with a lit/carried bomb or thrown object, then
   load and check the fuse/trajectory and pickup behavior continue correctly.
9. **Quest:** talk to the hat's owner in the ship area, retrieve the hat from the
   tent, carry it back, and complete the dialogue. Save/load and verify completion.
10. **Death and recovery:** exercise ordinary enemy damage, **X**, and **Z**.
    Check the death presentation and room-recovery flow for runtime errors.
11. **Presentation:** toggle fullscreen with **Enter**, hold **F1/C**, take an
    **F4** screenshot, and record/stop a short GIF with **G**.

### Validation already performed

The LTS Windows VM build has compiled successfully. Previous temporary in-engine
audits passed these batches with zero failures:

- **39 checks:** gameplay initialization, collision/resource cleanup, combat,
  pause behavior, dialogue/quests, and save/load restoration.
- **70 checks:** minimap/HUD presence across room changes, cached surface recovery,
  positioning, and dimensions; room screenshots were also inspected.
- **70 checks:** responsive GUI/camera sizing, room-clipped viewports, resized
  surfaces, and exact weapon labels, including a zero-ammo hook.

These are recorded validation results, not a checked-in automated test suite.
The temporary harnesses and startup hooks were removed. A fresh checkout should
use the smoke tests above; full gameplay, room layouts, and balance still need
regular playtesting. Details are in [`CODE_REVIEW.md`](CODE_REVIEW.md).

## Debug the game

The development/utility keys above also work in packaged builds. For source-level
breakpoints, variable inspection, and stepping, reproduce the issue in the IDE:

1. Choose **Debug** / **F6** in the IDE instead of a normal run.
2. Set breakpoints in object events or GML functions before reproducing the issue.
3. Inspect the call stack, local variables, globals, and watches when execution
   pauses. Step through the failing state or interaction.
4. Read the **Output** / **Compile Errors** panes for build errors, runtime
   exceptions, and `show_debug_message` output. Runtime errors identify the object
   event/function and usually the relevant line.

Useful starting points:

| Problem | Code to inspect | Useful watches |
| --- | --- | --- |
| Startup/room changes | `oGame` Create and Room Start; `RoomTransition`; `oRoomExit` Step | `room`, `global.targetXPlayer`, `global.targetYPlayer`, `global.gameLoad` |
| Movement/collision | `oPlayer` Step; `PlayerStateFree`; `PlayerCollision` | `oPlayer.state`, `oPlayer.hSpeed`, `oPlayer.vSpeed`, `oPlayer.collisionMap` |
| Items/combat | `UseItemFuncs`; `PlayerStateHook`; `PlayerAttackFuncs`; `HurtPlayer` | `global.playerEquipped`, `global.playerItemUnlocked`, `global.playerAmmo`, `global.iLifted` |
| HUD/minimap | `oUI` Draw GUI; `oMinimap` Create/Draw GUI | `oMinimap.w`, `oMinimap.h`, `oMinimap.surfMinimapBg`, GUI dimensions, `view_camera[0]` |
| Saves/quests | `SaveGame`, `LoadGame`, `LoadRoom` in `JSON`; `QuestHelper` | `global.gameSaveSlot`, `global.saveFolder`, `global.questStatus` |

For a minimap resize check, temporarily call `display_set_gui_size(640, 360)` in
an initialized game through a debug edit, then restore
`display_set_gui_size(320, 180)`. Check that the map resizes/rebuilds and remains
top-right. Camera-size changes can be tested with `camera_set_view_size`; the
white outline should reflect the actual visible part of the room.

For faster iteration, `ROOM_START` in `scripts/MACROS/MACROS.gml` can temporarily
target `rBeach`, while keeping `rInit` first in the room order so globals and
managers are initialized. Restore `ROOM_START` to `rTitle` before testing title
selection and checkpoint loading.

## Command-line build

The IDE is the easiest starting point. After **one successful Windows IDE build**,
this PowerShell example reuses the runtime and user-directory paths from the IDE's
generated `build.bff`. Run it from the repository root. It writes build output
under your temporary directory, outside the source tree.

```powershell
$project = (Resolve-Path -LiteralPath '.\Betty-RPG_LTS2026.yyp').Path
$optionsPath = Join-Path $env:LOCALAPPDATA 'GameMakerStudio2-LTS2026\GMS2TEMP\build.bff'
$buildOptions = Get-Content -LiteralPath $optionsPath -Raw | ConvertFrom-Json
$runtime = $buildOptions.runtimeLocation
$userDir = $buildOptions.userDir
$igor = Join-Path $runtime 'bin\igor\windows\x64\Igor.exe'
$buildRoot = Join-Path $env:TEMP 'Betty-RPG-LTS2026-build'

New-Item -ItemType Directory -Path $buildRoot -Force | Out-Null

$compileArgs = @(
    "--project=$project"
    "--rp=$runtime"
    "--user=$userDir"
    "--cache=$buildRoot\cache"
    "--temp=$buildRoot\temp"
    "--of=$buildRoot\Betty-RPG_LTS2026.win"
    '--runtime=VM'
    '--config=Default'
    '--'
    'Windows'
    'Compile'
)

& $igor @compileArgs
if ($LASTEXITCODE -ne 0) { throw 'GameMaker compilation failed.' }
```

To launch the compiled game in the same PowerShell session:

```powershell
$runner = Join-Path $runtime 'windows\x64\Runner.exe'
$game = Join-Path $buildRoot 'Betty-RPG_LTS2026.win'
& $runner -game $game
```

If `build.bff` is absent, build through the IDE first. Installation paths and the
active runtime version can differ between machines. This compiles a VM game-data
file for the runner; use the IDE's executable-packaging workflow to distribute
a standalone Windows build.

## Project structure

| Path | Purpose |
| --- | --- |
| `Betty-RPG_LTS2026.yyp` | Current project entry point and resource references. |
| `Betty-RPG_LTS2026.resource_order` | IDE resource ordering. |
| `Betty-RPG_LTS2026.exe`, `Betty-RPG_LTS2026.zip` | Standard Windows x64 installer and runnable ZIP distribution. |
| `Betty-RPG_LTS2026_arm.exe`, `Betty-RPG_LTS2026_arm.zip` | ARM-labelled distribution files; current game payloads are x64, as noted above. |
| `objects/` | GML object events and `.yy` definitions. Important managers are `oGame`, `oUI`, `oCamera`, and `oMinimap`. |
| `scripts/` | Player/bot/enemy states, combat, items, dialogue, quests, JSON saving, and helpers. |
| `rooms/` | Startup/title, exploration rooms, world map, and parent room. |
| `sprites/`, `tilesets/` | Character/world artwork and tile definitions. |
| `fonts/`, `sounds/`, `shaders/`, `timelines/` | Supporting GameMaker resources. |
| `options/` | Game and platform build settings. `options/html5/` is configuration, not a generated HTML5 export. |
| `datafiles/` | Included-data directory; consult the `.yyp` for resources actually included in a build. |
| `CODE_REVIEW.md` | Migration fixes, save compatibility notes, and validation history. |
| `.agents/MEMORY.md` | Maintained project context, implementation details, and behavior to preserve. |
| `CONTRIBUTING.md` | Development workflow, coding conventions, issue reports, and pull-request guidance. |
| `LICENSE` | MIT license. |

Open resource definitions through GameMaker where practical. Several directories
contain legacy/backup files; the `.yyp` resource list determines what the project
uses. The old top-level `html5/` export and `support/` source-asset collections
were removed during repository cleanup.

## Architecture overview

The game uses GML object events and script functions, with GameMaker resource
metadata connecting the code, rooms, and assets:

- **Initialization and room lifecycle:** `oGame` initializes shared globals and
  the GUI, enters `ROOM_START`, and handles room restoration and minimap creation
  at Room Start. Startup and resolution constants live in `scripts/MACROS/MACROS.gml`.
- **Player state machine:** `oPlayer` reads keyboard input in Step and executes its
  current state function while unpaused. `PlayerStateFree` handles movement,
  interaction, weapon selection, and item use; other `PlayerState*` scripts handle
  actions such as rolling, attacking, grappling, and death.
- **World entities:** `pEntity`, `pEnemy`, and `pCollectible` provide shared object
  hierarchies. Activation and hit callbacks connect entities to interaction,
  combat, loot, and quest functions.
- **Presentation:** `oCamera` controls the view, `oUI` draws the HUD and overlays,
  and each playable room owns an `oMinimap` with a cached terrain/background
  surface and live player/enemy markers.
- **Persistence and pause:** `scripts/JSON/JSON.gml` serializes game and room state.
  `scripts/Helper/Helper.gml` provides save-path/buffer helpers and the shared
  `SetGamePaused` function. Session room snapshots and numbered checkpoints serve
  different purposes, as described in [Saves and captured files](#saves-and-captured-files).

When adding resources, keep the `.yyp` resource references, `.yy` definitions, and
object event registrations consistent. See [CONTRIBUTING.md](CONTRIBUTING.md) for
the development workflow and regression checks.

## Current limitations

- This is a playable development prototype, not a finished princess-rescue
  campaign. The hat quest and introductory mission text are implemented.
- `AttackSpin()` is a placeholder; no spinning attack is implemented.
- The bot is a movement prototype, and the F1 Tab-follow entry is legacy text.
- Keyboard input is implemented; a gamepad control scheme is not currently wired.
- Normal window resizing is disabled in Windows options. Fullscreen switching is
  supported; the minimap also responds to explicit GUI-size changes.
- Only the Windows VM workflow described here has been validated. HTML5, other
  platform exports, and YYC builds require their own testing.
- The new installer and ZIP contents have been inspected, but installation and a
  full packaged-build playthrough have not been validated by the source-code
  audits. Use the distribution tests above. The `_arm` packages currently contain
  x64 game executables, so native ARM64 support is not yet established.

## Contributing

Bug reports, gameplay fixes, documentation improvements, and playtesting are
welcome. Read [CONTRIBUTING.md](CONTRIBUTING.md) for setup, GML/resource conventions,
validation expectations, and what to include in an issue or pull request.

## License

This project is licensed under the [MIT License](LICENSE).
