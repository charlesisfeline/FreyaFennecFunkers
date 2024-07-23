package source; // Yeah, I know...

import sys.io.File;

/**
 * A script which executes before the game is built.
 */
class Prebuild
{
  static inline final BUILD_TIME_FILE:String = '.build_time';

  static function main():Void
  {
    saveBuildTime();
    haxe.Log.trace('Building...', null);
    #if !macro
    haxe.Log.trace('You are not in macro mode, ok.', null);
    #else
    haxe.Log.trace("You're on macro mode, WHY are you macro mode?!?!?!?", null);
    #end
  }

  static function saveBuildTime():Void
  {
    var fo:sys.io.FileOutput = File.write(BUILD_TIME_FILE);
    var now:Float = Sys.time();
    fo.writeDouble(now);
    fo.close();
  }
}
