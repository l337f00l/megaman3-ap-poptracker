# Mega Man 3 Archipelago PopTracker Pack

This is a PopTracker pack for Silvris' Mega Man 3 Archipelago. Install it in your PopTracker packs folder.

Stage select overview maps for Robot Masters, Doc Robot stages, Break Man, and Wily Fortress, plus individual stage maps showing item locations.

When using Archipelago auto tracking, settings and logic will be set automatically. For manual operation click the **Open Pack Settings** button at the top of PopTracker.

---

## Features

- Stage select overview maps with accessibility indicators
  - Robot Masters (8 stages)
  - Doc Robot stages (4 stages)
  - Break Man
  - Wily Fortress (6 stages)
- Individual stage maps with check locations for all stages
- Auto-tracking via Archipelago client
- Boss portrait items with X overlay when defeated
- Doc Robot stage portraits with locked/unlocked/defeated states
- Sequential Wily stage unlocking (each stage opens after its boss is defeated)
- Settings toggles for E-Tank/1-Up checks and Weapon/Health Energy checks

---

## Settings

Settings are accessed via the **Open Pack Settings** button (gear icon) at the top of PopTracker.

| Setting | Description |
|---------|-------------|
| **E-Tanks & 1-Ups In Pool** | Show E-Tank and 1-Up pickup checks on stage maps. Disable if your seed does not have these shuffled. |
| **Weapon & Health Energy In Pool** | Show Weapon Energy and Health Energy pickup checks on stage maps. Disable if your seed does not have these shuffled. |

Both settings are **enabled by default**. If your YAML does not include consumables or energy pickups in the item pool, toggle them off to hide those checks.

---

## Logic Notes

- **Robot Master stages** unlock when the corresponding access code item is received
- **Doc Robot stages** unlock when the corresponding Robot Master is defeated OR when the Doc stage access code item is received (handles both shuffled and unshuffled seeds)
- **Break Man** all 4 Doc Robot stages completed
- **Wily Stage 1** unlocks when Break Man is defeated
- **Wily Stages 2–6** unlock sequentially as each Wily boss is defeated
- **Wily Stage 4** (Robot Master refights) unlocks alongside Wily Stage 5 since it has no boss check of its own
- **Wily Stage 1 and 3** Hard Knuckle is now checked and items will show up Red if Hard Knuckle hasn't been received yet.

---

## Auto-Tracking Notes

- Connect via the AP button at the top of PopTracker
- Item states (boss portraits, doc stage icons, weapons, consumables) restore correctly after reset and reconnect
- The stage select and individual stage maps reflect check completion state independently

---

## Credits

Created by [l337f00l](https://github.com/l337f00l)

Based on the [Mega Man 2 AP PopTracker pack](https://github.com/BrianCumminger/megaman2-ap-poptracker) by MeridianBC / BrianCumminger

Mega Man 3 APWorld by [Silvris](https://github.com/Silvris)

Stage maps generated from Mega Man 3 (NES)
