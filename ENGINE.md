# CardGameEngine

A data driven engine for [Bang!](<https://en.wikipedia.org/wiki/Bang!_(card_game)>) card game

**#turn based game, #state machine, #rules scripting #multiplayer online**

[![CI Status](https://img.shields.io/travis/Telolahy/CardGameEngine.svg?style=flat)](https://travis-ci.org/Telolahy/CardGameEngine)
[![Version](https://img.shields.io/cocoapods/v/CardGameEngine.svg?style=flat)](https://cocoapods.org/pods/CardGameEngine)
[![License](https://img.shields.io/cocoapods/l/CardGameEngine.svg?style=flat)](https://cocoapods.org/pods/CardGameEngine)
[![Platform](https://img.shields.io/cocoapods/p/CardGameEngine.svg?style=flat)](https://cocoapods.org/pods/CardGameEngine)

## Data-driven design

- Everything in a game engine can be thought of as manipulating a chunk of data to produce another chunk of data.
- Code is a poor location for behaviour that needs to be changed frequently
- Each custom behaviour should be able to function in isolation from other custom behaviours, so it is easier to test and manage
- Behaviour should be treated as “data”, rather than code, and be managed accordingly

## Concepts

### Card

- Cards are unique game entity: brown, blue, figure
- Each card behaviour is then scripted in JSON file instead of compiled instruction.
- JSON is a computer- and human-readable file format.

### State

- State is complete game data at a specific point in time: player, deck, discard, store
- state is readonly
- Because state can be sent between client and server, state must be a JSON-serializable object

### Moves

- Move is a command performed by player or system
- A Move is what begins when a player Action is taken. A Move consists of one or more Events, that are resolved in order.
- Active moves are actions a player chooses to take on their turn while nothing is happening.
- Resolving moves are playing out all related consequences, one at a time.
- Triggered moves are automatically performed when a particular event occurred

### Events

- Event is an elementary change applicable to the state
- An Event is any change in the game state. For example: Damage Event, Heal Event, Eliminate Event, etc.
- Event represents a running animation that will be sent as state change. But just to be sure, after the animations have played, we update all our objects against the game state ensuring they're in the correct locations.
- An event is used to advance the game state. It is somewhat analogous to a move, except that events are provided by the framework (as opposed to moves, which are pushed by user).
- Additionally, all Moves have an associated Event(s).

### Turn

A turn is a period of the game that is associated with an individual player. It typically consists of one or more moves made by that player before it passes on to another player. Other players are allowed to play reaction moves during your turn.

### Phase

A is a period in the game that happens within a turn. A turn may be subdivided into many phases, each allowing a different set of moves and overriding other game configuration options while that phase is active.

### Abilities

- Abilities are unique features related to a card
- Ability effects script determine the exact sequence of events based on the initial state when it is played
- Active abilities are effects that apply if user chooses to play it
- Triggered abilities are effects that activate in response to specific events.

### Play Requirements

- The playRequirements attribute contains an array of key: param values which determine various requirements which have to be met for the card to be played and what it can target.
- The key corresponds to a PlayReq enum string representation.
- Most play requirements ignore the parameter, which is thus 0.

### Passive abilities

- These are ability of an object that is always "on", and cannot be turned "off". Gun or mustang are examples of static abilities.
  Static abilities apply only when the object they appear on is in play unless the card specifies otherwise or the ability could only logically function in some other zone. Static abilities are always 'on' and do not use the stack. The ability takes effect as soon as the card enters the appropriate zone and only stops working when the card leaves that zone.

## Engine rules

- A move is only applicable when all of its effects are applicable, unless it is market _optional_
- When resolving simultaneous triggered moves, Engine must resolve one move before it begins resolving the next.
- When resolving simultaneous triggered moves, Engine must resolve them by priority

## Effect rules

1. Cannot target eliminated players
2. Cannot have more health than maxHealth
3. Cannot have two copy of the same card inPlay
4. Must discard brown played cards immediately
5. Must discard previous gun while playing a gun
6. Must apply in clockwise order the effects to all players
7. Must Resolved all hits before playing active moves

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Testing

Moves are just functions, so they lend themselves to unit testing.

## Requirements

- iOS 9.3+
- XCode 12+

## Installation

CardGameEngine is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CardGameEngine'
```

## Author

Telolahy, stephano.telolahy@gmail.com

## License

CardGameEngine is available under the MIT license. See the LICENSE file for more info.

## References

- [hearthstonejson.com](https://hearthstonejson.com/docs/cards.html)
- [hearthstore advanced rulebook](https://hearthstone.gamepedia.com/Advanced_rulebook#Advanced_mechanics_101_.28READ_THIS_FIRST.29)
- [boardgame.io](https://boardgame.io/documentation/#/)
