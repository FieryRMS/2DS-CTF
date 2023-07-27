# ROADMAP for the Capture the Flag Game

This is a rough roadmap for the game. It is subject to change as I go along.

## Phase 1: Game Core and Basic Mechanics

- [x] Create simple game character and bullet mechanics. For now use keyboard input to control the character.
- [ ] Create simple tilemap and use it to create a simple map. Remember to implement collisions.
- [ ] Create a base character class that has the following properties and connect these properties to the game mechanics:
  - [x] Movement speed (MS)
  - [x] Character rotation speed (RS)
  - [ ] Damage dealt (DMG)
  - [ ] Base spread (BS)
  - [ ] Spread multiplier (SM)
  - [ ] Spread recovery speed (RR)
  - [x] Fire Rate (FR)
  - [ ] view distance (VD)
  - [ ] view angle (VA)
  - [x] Bullet speed (BlS)
  - [x] health (HP)
- [ ] use the base character class to create the following classes:
  - [ ] Assault (A)
  - [ ] Sniper (S)
  - [ ] Runner (R)
  worry about balancing later
- [ ] Implement the flag carrier role
- [ ] add buffs and debuffs of the flag carrier
- [ ] implement inner and outer circle damage
- [ ] implement the flag drop on death and flag pickup on touch
- [ ] implement the flag capture when the attacker flag carrier stays in the base for 10 seconds
- [ ] implement the timer for the round
- [ ] implement the win conditions for the round

## Phase 2: AI and Game Logic

- [ ] Implement the `CharacterStatus`, `BulletStatus` and `CharacterCommands` classes
- [ ] use the python AST library to sanitize user code
- [ ] implement the `init()` and `update()` functions
- [ ] implement the fixed frame rate mechanic
