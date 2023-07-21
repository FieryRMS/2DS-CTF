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
1. Both teams can also win by eliminating all the players of the other team.

### Player Character Rules

1. All characters will start with 100 health points unless otherwise specified.
1. Before the start of each round, each character can be assigned one of 3 classes by the player: Assault (A), Sniper (S), or Runner (R).
1. Defenders additionally have the option to choose one character as the Flag Carrier role.
1. There is no restriction on the number of characters that can be assigned to each class.
1. There are infinite ammo and no reloads.
1. Bullets go as far as the characters can see.

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

This is a role that is assigned to one of the carriers. It is not a class, and can be assigned to any character of class. The flag carrier will have a flag that they have to carry. The flag carrier will have a 60% movement speed penalty, and will drop the flag if they die. Players in a small radius around the flag carrier will have a damage boost and slow regen. The flag carrier will also have a small health boost.

### Code documentation

The game will call `init()` once at the start of the game, and then call `update()` every frame. If any of the functions return an invalid value or throw an error, the game will stop and the other team will win.

#### `init()`

This function will be called once at the start of the game.

Arguments:

| Variable Name  | Type  | Description  |
|--- |--- |--- |
| isDefender  | Bool  | If your team is playing the defender side, this argument will be true  |

Return:
| Variable Name  | Type  | Description  |
|--- |--- |--- |
|  PlayerType | Array[String] | An array of 5 of player types [A, S, R].  |
| FlagCarrier | int | The index of the character that will be the flag carrier. [Base 0 indexing] |
