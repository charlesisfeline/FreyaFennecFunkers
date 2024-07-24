package funkin.ui.options;

import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import funkin.ui.AtlasText.AtlasFont;
import funkin.ui.options.OptionsState.Page;
import funkin.ui.options.items.CheckboxPreferenceItem;
import funkin.ui.options.items.NumberPreferenceItem;
import funkin.graphics.FunkinCamera;
import funkin.ui.TextMenuList.TextMenuItem;

class PreferencesMenu extends Page
{
  inline static final DESC_BG_OFFSET_X = 15.0;
  inline static final DESC_BG_OFFSET_Y = 15.0;
  static var DESC_TEXT_WIDTH:Null<Float>;

  var items:TextMenuList;
  var preferenceItems:FlxTypedSpriteGroup<FlxSprite>;

  var preferenceDesc:Array<String> = [];

  var menuCamera:FlxCamera;
  var camFollow:FlxObject;

  var descText:FlxText;
  var descTextBG:FlxSprite;

  public function new()
  {
    super();

    if (DESC_TEXT_WIDTH == null) DESC_TEXT_WIDTH = FlxG.width * 0.8;

    menuCamera = new FunkinCamera('prefMenu');
    FlxG.cameras.add(menuCamera, false);
    menuCamera.bgColor = 0x0;
    camera = menuCamera;

    descTextBG = new FlxSprite().makeGraphic(1, 1, 0x80000000);
    descTextBG.scrollFactor.set();
    descTextBG.antialiasing = false;
    descTextBG.active = false;

    descText = new FlxText(0, 0, 0, "idk buddy...", 26);
    descText.scrollFactor.set();
    descText.font = Paths.font("vcr.tff");
    descText.alignment = CENTER;
    descText.setBorderStyle(OUTLINE, FlxColor.BLACK, 2);
    descText.antialiasing = Preferences.antialiasing;

    descTextBG.x = descText.x - DESC_BG_OFFSET_X;
    descTextBG.scale.x = descText.width + DESC_BG_OFFSET_X * 2;
    descTextBG.updateHitbox();

    add(descTextBG);
    add(descText);

    add(items = new TextMenuList());
    add(preferenceItems = new FlxTypedSpriteGroup<FlxSprite>());

    createPrefItems();

    camFollow = new FlxObject(FlxG.width / 2, 0, 140, 70);
    if (items != null) camFollow.y = items.selectedItem.y;

    menuCamera.follow(camFollow, null, 0.06);
    var margin:Int = 100;
    menuCamera.deadzone.set(0, margin, menuCamera.width, menuCamera.height - margin * 2);

    var prevIndex = 0;
    var prevItem = items.selectedItem;

    items.onChange.add(function(selected) {
      camFollow.y = selected.y;

      prevItem.x = 120;
      selected.x = 150;

      final newDesc = preferenceDesc[items.selectedIndex];
      final showDesc = (newDesc != null && newDesc.length != 0);
      descText.visible = descTextBG.visible = showDesc;
      if (showDesc)
      {
        descText.text = newDesc;
        descText.fieldWidth = descText.width > DESC_TEXT_WIDTH ? DESC_TEXT_WIDTH : 0;
        descText.screenCenter(X).y = FlxG.height * 0.85 - descText.height * 0.5;

        descTextBG.x = descText.x - DESC_BG_OFFSET_X;
        descTextBG.y = descText.y - DESC_BG_OFFSET_Y;
        descTextBG.scale.set(descText.width + DESC_BG_OFFSET_X * 2, descText.height + DESC_BG_OFFSET_Y * 2);
        descTextBG.updateHitbox();
      }

      prevIndex = items.selectedIndex;
      prevItem = selected;
    });
  }

  /**
   * Create the menu items for each of the preferences.
   */
  function createPrefItems():Void
  {
    createPrefItemCheckbox('Ghost Tapping', 'Enable to disable ghost misses', function(value:Bool):Void {
      Preferences.ghostTapping = value;
    }, Preferences.ghostTapping);
    #if !web
    createPrefItemNumber('FPS Cap', 'Set the cap of the framerate that the game is running on', function(value:Float) {
      Preferences.framerate = Std.int(value);
    }, null, Preferences.framerate, 12, 360, 1, 0);
    #end
    createPrefItemCheckbox('Naughtiness', 'Toggle displaying raunchy content', function(value:Bool):Void {
      Preferences.naughtyness = value;
    }, Preferences.naughtyness);
    createPrefItemCheckbox('Downscroll', 'Enable to make notes move downwards', function(value:Bool):Void {
      Preferences.downscroll = value;
    }, Preferences.downscroll);
    createPrefItemCheckbox('Middlescroll', 'Enable to move the player strums to the center', function(value:Bool):Void {
      Preferences.middlescroll = value;
    }, Preferences.middlescroll);
    createPrefItemCheckbox('Expanded Score Text', 'Enable to display misses and accuracy', function(value:Bool):Void {
      Preferences.expandedScore = value;
    }, Preferences.expandedScore);
    createPrefItemCheckbox('Note Splashes', 'Disable to remove splash animations when hitting notes', function(value:Bool):Void {
      Preferences.noteSplash = value;
    }, Preferences.noteSplash);
    createPrefItemCheckbox('Colored Health Bar', 'Enable to use the health bar with character-based colors', function(value:Bool):Void {
      Preferences.coloredHealthBar = value;
    }, Preferences.coloredHealthBar);
    createPrefItemCheckbox('Flashing Lights', 'Disable to dampen flashing effects', function(value:Bool):Void {
      Preferences.flashingLights = value;
    }, Preferences.flashingLights);
    createPrefItemCheckbox('Camera Zooming on Beat', 'Disable to stop the camera bouncing to the song', function(value:Bool):Void {
      Preferences.zoomCamera = value;
    }, Preferences.zoomCamera);
    // Graphics, you need this.
    createPrefItemCheckbox('Antialiasing', 'Disable to increase performance at the cost of sharper visuals.', function(value:Bool):Void {
      Preferences.antialiasing = value;
    }, Preferences.antialiasing);
    createPrefItemCheckbox('FPS Counter', 'Enable to show FPS and other debug stats', function(value:Bool):Void {
      Preferences.debugDisplay = value;
    }, Preferences.debugDisplay);
    createPrefItemCheckbox('Auto Pause', 'Automatically pause the game when it loses focus', function(value:Bool):Void {
      Preferences.autoPause = value;
    }, Preferences.autoPause);
  }

  override function update(elapsed:Float):Void
  {
    super.update(elapsed);

    // Indent the selected item.
    // TODO: Only do this on menu change?
    items.forEach(function(daItem:TextMenuItem) {
      var thyOffset:Int = 0;
      // Initializing thy text width (if thou text present)
      var thyTextWidth:Int = 0;
      if (Std.isOfType(daItem, NumberPreferenceItem)) thyTextWidth = cast(daItem, NumberPreferenceItem).lefthandText.getWidth();

      if (thyTextWidth != 0)
      {
        // Magic number because of the weird offset thats being added by default
        thyOffset += thyTextWidth - 75;
      }

      if (items.selectedItem == daItem)
      {
        thyOffset += 150;
      }
      else
      {
        thyOffset += 120;
      }

      daItem.x = thyOffset;
    });
  }

  function createPrefItemCheckbox(prefName:String, prefDesc:String, onChange:Bool->Void, defaultValue:Bool):Void
  {
    var checkbox:CheckboxPreferenceItem = new CheckboxPreferenceItem(0, 120 * (items.length - 1 + 1), defaultValue);

    items.createItem(0, (120 * items.length) + 30, prefName, AtlasFont.BOLD, function() {
      var value = !checkbox.currentValue;
      onChange(value);
      checkbox.currentValue = value;
    }, true);

    preferenceItems.add(checkbox);
    preferenceDesc.push(prefDesc);
  }

  function createPrefItemNumber(prefName:String, prefDesc:String, onChange:Float->Void, ?valueFormatter:Float->String, defaultValue:Int, min:Int, max:Int,
      step:Float = 0.1, precision:Int):Void
  {
    var item = new NumberPreferenceItem(0, (120 * items.length) + 30, prefName, defaultValue, min, max, step, precision, onChange, valueFormatter);
    items.addItem(prefName, item);
    preferenceItems.add(item.lefthandText);
  }
}
