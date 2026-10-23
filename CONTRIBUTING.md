# Contributing to Betty RPG

Thanks for helping improve Betty RPG! Bug reports, playtesting, gameplay fixes,
and documentation improvements are welcome.

## Development setup

1. Fork or clone the repository and create a branch for your change.
2. Open `Betty-RPG_LTS2026.yyp` in **GameMaker LTS 2026**. The project records IDE
   `2026.0.0.16`; the documented Windows VM validation used runtime `2026.0.0.23`.
3. Select **Windows / VM / Default**, then press **F5** to run or **F6** to debug.
4. Install the included `m3x6.ttf` and `m5x7.ttf` fonts if GameMaker reports missing
   fonts or substitutes text; restart the IDE afterward.
5. Start an unused save slot for testing. IDE runs and packaged builds can share
   the same save sandbox.

No external package-install step is required. See the [README](README.md) for
controls, save locations, command-line builds, and the full smoke-test checklist.
For orientation, read its [architecture overview](README.md#architecture-overview),
the migration history in [CODE_REVIEW.md](CODE_REVIEW.md), and the implementation
context in [.agents/MEMORY.md](.agents/MEMORY.md).

## Code and GameMaker resources

- Keep changes focused and follow the style of nearby code. GML generally uses
  tabs, PascalCase function names, camelCase instance/global variables, and
  underscore-prefixed local variables and arguments. Macros and enum names use
  uppercase names.
- Follow existing resource prefixes: `o` for objects, `p` for parent objects,
  `r` for rooms, `s` for sprites, `f` for fonts, and `sh` for shaders.
- Use GameMaker to create or rename resources where practical. Include the related
  `.yy`, `.yyp`, and resource-order changes. A new event's `.gml` file must also be
  registered in its object's `.yy` definition.
- Check the `.yyp` resource list before editing legacy or backup files. That list
  determines which resources are active. Included data also needs project
  registration; the current `IncludedFiles` list is empty.
- Keep `rInit` first in the room order, and restore `ROOM_START` to `rTitle` after
  temporary debugging changes. Player collision expects a tile layer named `Col`.
- Release lists, buffers, and surfaces when their work or owning instance ends.
  Rendering code must tolerate lost surfaces and restore drawing state it changes.
- Keep build caches, local saves, captures, and temporary audit harnesses outside
  the source tree. Review generated metadata for unrelated changes before submission.

### Behavior to preserve

- **HUD:** health, the continuous full-height blue/black energy bar, weapon, ammo,
  and coins belong at the top-left. The reusable hook displays `Hook` without an
  ammo suffix, including when an older save stores zero hook ammo.
- **Minimap:** every playable room has one, anchored top-right with room proportions
  preserved. Layout follows current GUI dimensions, and the camera outline uses
  the actual visible room area. Cached backgrounds recover after surface loss.
- **Pause:** use the shared `SetGamePaused` helper. Gameplay updates, collection,
  projectiles, and damage must respect the pause state.
- **Persistence:** preserve compatibility with older saves when adding fields.
  Numbered checkpoints and session room snapshots are distinct. Test both loading
  a checkpoint and revisiting rooms through their current entry doorways.
- **Input:** item selection remains restricted to unlocked weapons. Update the
  README and in-game F1 help when changing controls.

## Validate your change

There is no checked-in automated test runner. The audit counts in `CODE_REVIEW.md`
record previous temporary in-engine checks, not a suite available in a fresh clone.

For gameplay, resource, or build-setting changes:

1. Compile and run the Windows VM target. Check the Output and Compile Errors panes.
2. Exercise the changed behavior and the relevant checks from the
   [README smoke tests](README.md#repeatable-smoke-test-checklist).
3. Check startup, movement/interaction, room transitions, HUD/minimap, pause/resume,
   and save/quit/relaunch when your change can affect these shared systems.
4. For save changes, test a fresh checkpoint, an existing save, and any affected
   transient state such as a carried bomb or thrown object.
5. For presentation changes, check multiple rooms and fullscreen. Minimap changes
   also need explicit GUI-size and camera-size checks; fullscreen alone does not
   change the camera's world-space view.

For documentation-only changes, verify paths, links, and statements against the
current source. State which checks you actually performed in your pull request.

F5 does not refresh the repository's EXE/ZIP distributions. If your change includes
new exports, test the installer and extracted ZIP separately using the
[distribution checklist](README.md#test-the-exe-and-zip-distributions). Verify the
payload architecture: the existing `_arm` packages contain x64 game executables.

## Report a bug or suggest a feature

Include enough detail to reproduce or evaluate the request:

- A short description and the expected versus actual behavior.
- Numbered reproduction steps, the room, and whether you used a fresh or saved slot.
- The commit or exact package filename, Windows/device architecture, and GameMaker
  IDE/runtime versions when relevant.
- Runtime error text and object/event names, plus an **F4** screenshot or **G** GIF
  when useful. For persistence bugs, include a reproducible save if possible.

For feature suggestions, explain how the feature fits the current prototype and
what a small, testable implementation would do.

## Submit a pull request

1. Keep the pull request focused on one fix or improvement.
2. Explain the change, link any related issue, and list the checks you performed
   with their target/runtime. Include screenshots or a GIF for visible changes.
3. Update the README for user-facing changes and project memory for lasting
   architecture or workflow changes. Keep historical validation claims accurate.
4. Review the diff for unrelated room edits, asset changes, exports, and temporary
   debug hooks. Use a concise, descriptive commit message; recent messages commonly
   start with `+`, such as `+ Fix minimap resizing.`

## License

Contributions are made under the project's [MIT License](LICENSE). Preserve
existing copyright and attribution notices.
