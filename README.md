# 2DS-CTF

A 2D Shooter Capture The Flag Coding Game - You make the AI to control your team and compete against other AIs.

The rules and documentation is still a work in progress and subject to change. I am just writing down my ideas as I go along.

## Rules

### Basic Gameplay Rules

1. There will be two teams, attackers and defenders.
1. Each team will have 5 characters.
1. Defenders will have a flag to carry and protect.
1. Attackers will have to steal the flag, bring it back to their base and stay there for 10 seconds to score.
1. If the flag is not captured within 1 minute and 30 seconds, defenders win.
1. Both teams can also win by eliminating all the characters of the other team.

### Team Character Rules

1. All characters will start with 100 health points unless otherwise specified.
1. Before the start of each round, each character can be assigned one of 3 classes by your program: Assault (A), Sniper (S), or Runner (R).
1. Defenders additionally have the option to choose one character as the Flag Carrier role.
1. There is no restriction on the number of characters that can be assigned to each class.
1. There are infinite ammo and no reloads.
1. Bullets go as far as the characters can see.
1. Characters will have a small inner circle, if bullets hit the inner circle, they will deal full damage, else they deal reduced damage.

### Class Rules

1. Each class has a different weapon and different stats.

1. Properties include:

    - Movement speed (MS)
    - Character rotation speed (RS)
    - Damage dealt (DMG)
    - Base spread (BS)
    - Spread multiplier (SM)
    - Spread recovery speed (RR)
    - Fire Rate (FR)
    - view distance (VD)
    - view angle (VA)
    - Bullet speed (BlS)
    - health (HP)

#### Assault (A)

This class is the standard class. The rest of the classes are balanced around this class.

#### Sniper (S)

This class has a sniper rifle that deals high damage, low movement and rotation speed, no base spread, high spread multiplier, low spread recovery speed, low fire rate, high view distance, low view angle, high bullet speed.

#### Runner (R)

This class has an SMG that deals low damage, high movement and rotation speed, high base spread, low spread multiplier, high spread recovery speed, high fire rate, low view distance, high view angle, low bullet speed.

#### Flag Carrier (FC)

This is a role that is assigned to one of the carriers. It is not a class, and can be assigned to any character of class. The flag carrier will have a flag that they have to carry. The flag carrier will have a 60% movement speed penalty, and will drop the flag if they die. Characters in a small radius around the flag carrier will have a damage boost and slow regen. The flag carrier will also have a small health boost.

### Code documentation

The game will call `init()` once at the start of the game, and then call `update()` every frame. If any of the functions return an invalid value or throw an error, the game will stop and the other team will win.

The game will run at a constant 30/60/120 frames per second depending on difficulty. If your `update()` cannot return a value in time, the previous value will be used until a valid value is returned. So writing faster code will give you an advantage.

Your program will not be shut down between rounds, so you can store and carry over data to the next round. However, you will not be able to store data between games. Before the start of each round, the game will call `init()` again to let you know that a new round has started.

Language support will be limited to Python for now, but I will try to add more languages in the future. (I have hopes to add C++)

#### `init()`

This function will be called once at the start of the game.

Arguments:

| Variable Name  | Type  | Description  |
|--- |--- |--- |
| isDefender  | `bool`  | If your team is playing the defender side, this argument will be true  |
| Map  | `array[array[int]]`  | A 2D array of integers representing the map. 0 represents empty space, 1 represents a wall.  |

Return:
| Variable Name  | Type  | Description  |
|--- |--- |--- |
|  CharacterClasses | `array[string]` | An array of 5 of character classes [A, S, R].  |
| FlagCarrier | `int` | The index of the character that will be the flag carrier. [Base 0 indexing] |

#### `update()`

This function will be called every frame. It will be called with the current state of the game, and it will return the actions that the characters will take.

Arguments:

| Variable Name | Type | Description |
|---|---|---|
| TeamCharacterStatus | `array[CharacterStatus]` | An array of 5 giving details of the team characters. Check the `CharacterStatus` section for more details. |
| OpponentCharacterStatus | `array[CharacterStatus]` |An array giving details of the opponent characters. This array will be empty if the opponent team is not visible. |
| BulletStatus | `array[BulletStatus]` | An array giving details of the bullets seen by the team. Check the `BulletStatus` section for more details. |
| FlagStatus | `Vector2` | if the flag is on the ground and is visible, this will be the position of the flag. If the flag is not visible, this will be `null`. |

Return:
| Variable Name | Type | Description |
|---|---|---|
| TeamCharacterCommands | `array[CharacterCommands]` | This array should have 5 elements, each element giving the command for the corresponding character. Check the `CharacterCommands` section for more details. |

#### `CharacterStatus`

This is a class that will be passed to the `update()` function. It will contain the following properties:

| Variable Name | Type | Description |
|---|---|---|
| Position | `Vector2` | The position of the character. |
| Rotation | `float` | The rotation of the character in radians. |
| Class | `string` | The class of the character. |
| IsFlagCarrier | `bool` | True if the character is carrying the flag. |
| Health | `int` | The health of the character. This value is only present for team characters. |
| Spread | `float` | The current spread of the character. This value is only present for team characters. |
| SeenBy | `array[int]` | An array of indices of the characters that can see this opponent character. Value is not set for team characters. |

#### `BulletStatus`

This is a class that will be passed to the `update()` function. It will contain the following properties:

| Variable Name | Type | Description |
|---|---|---|
| Position | `Vector2` | The position of the bullet. |
| Rotation | `float` | The rotation of the bullet in radians. |
| Team | `int` | The team of the character that shot the bullet. |

#### `CharacterCommands`

This is a class that will be returned by the `update()` function. It will contain the following properties:

| Variable Name | Type | Description |
|---|---|---|
| Move | `Vector2` | The direction in which the character should move. Vector will be normalized before use if magnitude greater than 1. Valid values range from -1 to 1 in both x and y. |
| Crosshair | `Vector2` | The direction in which the character should aim. Point can be anywhere on the map. |
| Shoot | `bool` | True if the character should shoot. |
