package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import flixel.text.FlxText.FlxTextBorderStyle;

using StringTools;

class LuaText extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
		
		set('makeLuaText', function(tag:String, text:String, width:Int, x:Float, y:Float)
		{
			setTag(tag, new FlxText(x, y, width, text));
		});

		set('setTextBorder', function(tag:String, size:Float, color:FlxColor, ?style:String)
		{
			if (tagIs(tag, FlxText))
			{
				var text:FlxText = getTag(tag);
				text.borderStyle = switch(style.toLowerCase().trim())
				{
					case 'shadow':
						FlxTextBorderStyle.SHADOW;
					case 'outline':
						FlxTextBorderStyle.OUTLINE;
					case 'outline_fast':
						FlxTextBorderStyle.OUTLINE_FAST;
					default:
						FlxTextBorderStyle.NONE;
				};
				text.borderSize = size;
				text.borderColor = color;
			}
		});

		set('setTextFont', function(tag:String, newFont:String)
		{
			if (tagIs(tag, FlxText))
				getTag(tag).font = Paths.font(newFont);
		});
    }
}