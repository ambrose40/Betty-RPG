# GameMaker migration review

Reviewed on 2026-10-22 using the installed Windows VM runtime **2026.0.0.23**.
The original project compiled successfully; the fixes below address runtime
behavior and save-state restoration.

## Fixes

| Area | Bug and correction | Main files |
| --- | --- | --- |
| Movement | Player and bot collision lists were allocated every movement frame without being freed. Early horizontal collisions also left entries in the list used by the vertical query. Clear the list between axes and destroy it before returning. | `scripts/PlayerCollision/PlayerCollision.gml`, `scripts/BotCollision/BotCollision.gml` |
| Player lifetime | Attack hit lists survived player destruction during loading. Add a registered Clean Up event. | `objects/oPlayer/CleanUp_0.gml`, `objects/oPlayer/oPlayer.yy` |
| Pause/resume | Continue stored already-paused animation speeds and left animations stopped. Both resume paths now use a shared helper that restores animation and built-in movement speeds. Saving from the pause menu resumes before writing the snapshot. | `scripts/Helper/Helper.gml`, `objects/oGame/Step_2.gml`, `objects/oUI/Step_2.gml` |
| Paused gameplay | Collectibles could be collected, arrows could hit targets, and contact damage could hurt the player while paused. Guard those update/damage paths. | `objects/pCollectible/Step_2.gml`, `objects/oArrow/Step_0.gml`, `scripts/HurtPlayer/HurtPlayer.gml` |
| Facing | Rounding directions near 360 degrees produced direction index 4 instead of wrapping to east, breaking four-direction animation/hook selection. Wrap the index modulo 4. | `scripts/MACROS/MACROS.gml` |
| Dialogue | The captain's goodbye choice was supplied as an ignored fourth argument. Put both choices in the response array. Also support empty callback argument arrays. | `scripts/DialogueResponses/DialogueResponses.gml`, `scripts/ScriptExecuteArray/ScriptExecuteArray.gml` |
| Interaction | Invisible quest objects could still be activated. Activation could also dereference a target destroyed by its own callback. Check visibility and instance existence. | `scripts/PlayerStateFree/PlayerStateFree.gml` |
| Hook | Retraction could read a destroyed target. Check instance existence and reset the collectible flag when starting a new hook action. | `scripts/PlayerStateHook/PlayerStateHook.gml` |
| Explosions | An ancestry check excluded the player object itself, so explosions did not damage it. Include the player and calculate knockback from the explosion's coordinates. | `objects/oExplode/Step_0.gml` |
| Loot | An empty drop array attempted to read element zero. Empty arrays now produce no drops. | `scripts/DropItems/DropItems.gml` |
| Room restoration | Saved hookability and non-enemy loot lists were never restored. Preserve animation frame and throw/fuse runtime state as well. | `scripts/JSON/JSON.gml` |
| Bomb restoration | Replacing existing bombs during load invoked their Destroy event and spawned explosions. Suppress that event when replacing saved instances. Rebind bomb pickup arguments to the recreated instance ID. | `scripts/JSON/JSON.gml` |
| Shop restoration | Restored items ran Create using the default bomb type before receiving their saved type; owning bombs could destroy an unrelated restored item. Supply the saved item type before Create. | `scripts/JSON/JSON.gml` |
| Player placement | Ordinary room revisits overwrote the current doorway destination with an older room snapshot's return position. Only checkpoint loads restore saved player coordinates; apply destination coordinates to recreated players explicitly. | `scripts/JSON/JSON.gml` |
| Checkpoint copies | `file_copy` does not overwrite existing session files. Delete the destination before copying and discard session room files absent from the checkpoint. Ignore load requests with no checkpoint file. | `scripts/JSON/JSON.gml` |
| Hat quest | A room-instance ID became stale after save restoration. Find the quest owner by its activation callback, use that owner's coordinates, and disable the returned hat with the correct `-1` script sentinel. | `scripts/QuestHelper/QuestHelper.gml` |
| Map key | Opening the map on the title screen accessed a nonexistent player. Guard player existence, transitions, and conflicting player states. | `objects/oGame/KeyPress_77.gml` |

## Validation

- Compiled the original project with the installed LTS runtime as a baseline.
- Ran **39 checks with zero failures** in the actual Windows runner using a
  temporary GML harness and separate test save directories. These covered
  gameplay initialization; facing wraparound; empty callbacks/loot; pause and
  resume; paused projectiles, damage and collectibles; repeated player/bot
  collision calls; overlapping horizontal blockers; captain dialogue; destroyed
  hook targets; explosion damage; saved position and doorway placement; restored
  shops, quest sprites, loot, hookability, throws, loose/carried bomb fuses and
  pickup callbacks; legacy throw fallback; attack-list cleanup; quest completion
  after instance recreation; and checkpoint file replacement.
- Verified that this runtime serializes global script callbacks as named script
  references, and that restored pickup callbacks execute successfully.
- Removed the temporary test resource and startup hooks before the final build.
- The final normal Windows VM build completed successfully with the test hooks
  removed.
- The temporary harness is archived in
  `C:\Users\boris\AppData\Local\Temp\opencode\betty-runtime-audit.gml`.

## Save compatibility and remaining playtesting

New saves include optional animation and runtime-state fields. The loader accepts
older saves without those fields. Since an old save does not contain a thrown
object's trajectory, that object safely stops its throw and falls instead of
attempting to use missing variables. Old saves cannot recover a bomb countdown
that was never stored.

The runtime checks exercise code paths directly, rather than a full keyboard-driven
playthrough. Next, play through room crossings, map round trips, buying each item,
returning the hat, death/respawn, and saving/quitting/relaunching from a normal
numbered save slot. Visual presentation, encounter balance, and every room's
collision layout still need normal playtesting.

## Minimap and HUD follow-up

- Create a minimap in every playable room, including the world map, while avoiding
  a duplicate where the room already contains one.
- Cache all visible tile/background layers in depth order instead of requiring a
  layer named `Beach`. Collision layers remain excluded.
- Anchor the minimap to the top-right GUI corner, with a maximum map area of
  80 by 60 GUI pixels and the room's aspect ratio preserved.
- Scale the camera outline and live enemy/player markers to each room. The player
  is green; enemies are red. Mouse interaction uses GUI coordinates and the
  actual room-to-map scale.
- Recreate lost surfaces and release cached surfaces in the minimap Clean Up
  event. Remove the redundant per-frame entity surface and application-surface
  resize from the old minimap implementation.
- Group hearts, compact energy bars, weapon icon/name/ammo, and coins at the
  top-left. Show weapon ammunition beside the icon rather than over it.
- Passed 70 in-engine checks over beach, camp, ship, tent, cave, world map, and a
  return to beach. Checks covered one minimap per active room, valid cached
  rendering, size limits, top-right positioning, HUD visibility, and recovery
  after explicitly freeing the minimap surface. Screenshots were also inspected
  for the room backgrounds and final HUD layout. Temporary audit hooks were
  removed after validation.
