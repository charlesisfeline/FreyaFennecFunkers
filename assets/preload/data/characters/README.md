# README

Notes to self:
- After the idle/sing animation finishes, the game immediately transitions to (and loops, if enabled in the JSON) the `-hold` (or `-end`) animation.
  - In `dad.json` and `parents-christmas.json`, this is used to keep their eyes flickering during long notes.
  - In `mom-car.json`, this animation is used to keep her hair blowing while singing, and between bops of her idle.

## Example:
```jsonc
{
  "version": "1.0.0", // The version of... I don't know.
  "renderType": "sparrow", // The type of spritehseet you got. (Sparrow, Packer, AnimateAltas, and MultiSparrow.)
  "offsets": [0, 0], // The global offsets.
  "danceEvery": 1, // Every time your character bops on beat, I think.
  "scale": 1.0, // The size of the character, 6 for pixel.
  "name": "Daddy Dearest", // The character name, shown in the Chart Editor.
  "flipX": true, // Flips the character.
  "cameraOffsets": [0, 0], // The offsets the camera should get to when it's this character's turn.
  "singTime": 8.0, // Probably for the non-hold notes.
  "startingAnimation": "idle", // I don't know, the idle animation set?
  "isPixel": false, // Whether it's a pixel character or not.
  "assetPath": "characters/daddyDearest", // The path of your spritesheet, THE XML FILENAME MUST BE THE SAME AS THE SPRITESHEET NAME!!!
  "healthIcon": { // The health icon prefs.
    "offsets": [0, 0], // Offsets.
    "id": "dad", // Your icon name.
    "flipX": false, // Flips the icons.
    "isPixel": false, // Pixel icon?
    "scale": 1 // The icon size.
  },
  "pixelIcon": { // Used in Freeplay & Chart Editor.
    "id": "daddy" // Your icon name.
  },
  "animations": [ // The array of animations your character has.
    {
      "name": "idle", // The animation name.
      "prefix": "idle", // The animation prefix/name, in the XML.
      "looped": false, // Whether your animation loops or not, useful for hold animations.
      "frameRate": 24, // FPS of your animation, however it isn't functional. (Tested to see.)
      "flipY": false, // Flipped vertically?
      "flipX": false, // Flipped horizionally?
      "offsets": [0, 0] // The animation offsets!
    },
    {
      "name": "idle-hold",
      "prefix": "idle",
      "looped": true,
      "frameRate": 24,
      "flipY": false,
      "flipX": false,
      "frameIndices": [11, 12],
      "offsets": [0, 0]
    },
    {
      "name": "singLEFT",
      "prefix": "singLEFT",
      "looped": false,
      "flipY": false,
      "flipX": false,
      "offsets": [-10, 10]
    },
    {
      "name": "singLEFT-hold",
      "prefix": "singLEFT",
      "looped": true,
      "frameRate": 24,
      "flipY": false,
      "flipX": false,
      "frameIndices": [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
      "offsets": [-10, 10]
    },
    {
      "name": "singDOWN",
      "prefix": "singDOWN",
      "looped": false,
      "flipY": false,
      "flipX": false,
      "offsets": [0, -30]
    },
    {
      "name": "singDOWN-hold",
      "prefix": "singDOWN",
      "looped": true,
      "frameRate": 24,
      "flipY": false,
      "flipX": false,
      "frameIndices": [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
      "offsets": [0, -30]
    },
    {
      "name": "singUP",
      "prefix": "singUP",
      "looped": false,
      "flipY": false,
      "flipX": false,
      "offsets": [-6, 50]
    },
    {
      "name": "singUP-hold",
      "prefix": "singUP",
      "looped": true,
      "frameRate": 24,
      "flipY": false,
      "flipX": false,
      "frameIndices": [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
      "offsets": [-6, 50]
    },
    {
      "name": "singRIGHT",
      "prefix": "singRIGHT",
      "looped": false,
      "flipY": false,
      "flipX": false,
      "offsets": [0, 27]
    },
    {
      "name": "singRIGHT-hold",
      "prefix": "singRIGHT",
      "frameRate": 24,
      "flipY": false,
      "flipX": false,
      "looped": true,
      "frameIndices": [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
      "offsets": [0, 27]
    }
  ]
}
```
