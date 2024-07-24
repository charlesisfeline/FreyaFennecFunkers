package funkin.ui.title;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import funkin.ui.MusicBeatState;
import lime.app.Application;
import funkin.ui.mainmenu.MainMenuState;
import haxe.Http;

class OutdatedState extends MusicBeatState
{
  public static var leftState:Bool = false;
  public static var updateVersion:String = "";

  override function create()
  {
    super.create();

    // var url = "https://raw.githubusercontent.com/Ethan-makes-music/Funkin/develop/gitVersion.txt";
    createText();
  }

  function createText():Void
  {
    var ver = "v" + Application.current.meta.get('version');
    var txt:FlxText = new FlxText(0, 0, FlxG.width,
      "HEY! This mod is currently work in progress! \nMost things may be unfinished for now, \nand yeah, beware of some bugs & glitches that will be \nfixed in the future.\nPress Space or ESCAPE to continue.",
      32);
    txt.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
    txt.screenCenter();
    add(txt);
  }

  override function update(elapsed:Float)
  {
    if (controls.ACCEPT)
    {
      leftState = true;
      FlxG.switchState(() -> new MainMenuState());
    }
    if (controls.BACK)
    {
      leftState = true;
      FlxG.switchState(() -> new MainMenuState());
    }
    super.update(elapsed);
  }
}
