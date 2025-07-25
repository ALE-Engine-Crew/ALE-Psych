package scripting.haxe;

import flixel.input.keyboard.FlxKey;

import flixel.system.macros.FlxMacroUtil;

class HScriptFlxKey
{
	public static var fromStringMap(default, null):Map<String, FlxKey> = FlxMacroUtil.buildMap("flixel.input.keyboard.FlxKey", false, []);
	public static var toStringMap(default, null):Map<FlxKey, String> = FlxMacroUtil.buildMap("flixel.input.keyboard.FlxKey", true, []);

	public static var ANY = -2;
	public static var NONE = -1;
	public static var A = 65;
	public static var B = 66;
	public static var C = 67;
	public static var D = 68;
	public static var E = 69;
	public static var F = 70;
	public static var G = 71;
	public static var H = 72;
	public static var I = 73;
	public static var J = 74;
	public static var K = 75;
	public static var L = 76;
	public static var M = 77;
	public static var N = 78;
	public static var O = 79;
	public static var P = 80;
	public static var Q = 81;
	public static var R = 82;
	public static var S = 83;
	public static var T = 84;
	public static var U = 85;
	public static var V = 86;
	public static var W = 87;
	public static var X = 88;
	public static var Y = 89;
	public static var Z = 90;
	public static var ZERO = 48;
	public static var ONE = 49;
	public static var TWO = 50;
	public static var THREE = 51;
	public static var FOUR = 52;
	public static var FIVE = 53;
	public static var SIX = 54;
	public static var SEVEN = 55;
	public static var EIGHT = 56;
	public static var NINE = 57;
	public static var PAGEUP = 33;
	public static var PAGEDOWN = 34;
	public static var HOME = 36;
	public static var END = 35;
	public static var INSERT = 45;
	public static var ESCAPE = 27;
	public static var MINUS = 189;
	public static var PLUS = 187;
	public static var DELETE = 46;
	public static var BACKSPACE = 8;
	public static var LBRACKET = 219;
	public static var RBRACKET = 221;
	public static var BACKSLASH = 220;
	public static var CAPSLOCK = 20;
	public static var SCROLL_LOCK = 145;
	public static var NUMLOCK = 144;
	public static var SEMICOLON = 186;
	public static var QUOTE = 222;
	public static var ENTER = 13;
	public static var SHIFT = 16;
	public static var COMMA = 188;
	public static var PERIOD = 190;
	public static var SLASH = 191;
	public static var GRAVEACCENT = 192;
	public static var CONTROL = 17;
	public static var ALT = 18;
	public static var SPACE = 32;
	public static var UP = 38;
	public static var DOWN = 40;
	public static var LEFT = 37;
	public static var RIGHT = 39;
	public static var TAB = 9;
	public static var WINDOWS = 15;
	public static var MENU = 302;
	public static var PRINTSCREEN = 301;
	public static var BREAK = 19;
	public static var F1 = 112;
	public static var F2 = 113;
	public static var F3 = 114;
	public static var F4 = 115;
	public static var F5 = 116;
	public static var F6 = 117;
	public static var F7 = 118;
	public static var F8 = 119;
	public static var F9 = 120;
	public static var F10 = 121;
	public static var F11 = 122;
	public static var F12 = 123;
	public static var NUMPADZERO = 96;
	public static var NUMPADONE = 97;
	public static var NUMPADTWO = 98;
	public static var NUMPADTHREE = 99;
	public static var NUMPADFOUR = 100;
	public static var NUMPADFIVE = 101;
	public static var NUMPADSIX = 102;
	public static var NUMPADSEVEN = 103;
	public static var NUMPADEIGHT = 104;
	public static var NUMPADNINE = 105;
	public static var NUMPADMINUS = 109;
	public static var NUMPADPLUS = 107;
	public static var NUMPADPERIOD = 110;
	public static var NUMPADMULTIPLY = 106;
	public static var NUMPADSLASH = 111;

	public static inline function fromString(s:String)
	{
		s = s.toUpperCase();

		return fromStringMap.exists(s) ? fromStringMap.get(s) : NONE;
	}

	public inline function toString(value:FlxKey):String
		return toStringMap.get(value);
}