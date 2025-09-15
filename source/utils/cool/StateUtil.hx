package utils.cool;

class StateUtil
{
	public static function resetState()
	{
		CoolVars.skipTransOut = true;
		
		FlxG.resetState();
	}

    public static function switchState(state:flixel.FlxState, skipTransIn:Bool = null, skipTransOut:Bool = null)
    {
        if (state is CustomState)
        {
			var scriptName = cast(state, CustomState).scriptName;
			
            if (Paths.exists('scripts/states/' + scriptName + '.hx') || Paths.exists('scripts/states/' + scriptName + '.lua'))
                transitionSwitch(state, skipTransIn, skipTransOut);
            else
                debugTrace('Custom State called "' + scriptName + '" doesn\'t Exist', MISSING_FILE);
        } else {
			transitionSwitch(state, skipTransIn, skipTransOut);
		}
    }

	private static function transitionSwitch(state:flixel.FlxState, skipTransIn:Bool = null, skipTransOut:Bool = null)
	{
		if (skipTransIn != null)
			CoolVars.skipTransIn = skipTransIn;

		if (skipTransOut != null)
			CoolVars.skipTransOut = skipTransOut; 

        if (CoolVars.skipTransIn)
		{
            CoolVars.skipTransIn = false;

			FlxG.switchState(state);
		} else {
            #if cpp
			openSubState(new CustomSubState(
				CoolVars.data.transition,
				null,
				[
					'transIn' => true,
					'transOut' => false,
					'finishCallback' => () -> { FlxG.switchState(state); }
				],
				[
					'transIn' => true,
					'transOut' => false,
					'finishCallback' => () -> { FlxG.switchState(state); }
				]
			));
			#end
		}
	}

	public static function openSubState(subState:flixel.FlxSubState = null)
	{
		if (subState == null)
			return;

        if (subState is CustomSubState)
        {
            var custom:CustomSubState = Std.downcast(subState, CustomSubState);
            
            if (Paths.exists('scripts/substates/' + custom.scriptName + '.hx') || Paths.exists('scripts/substates/' + custom.scriptName + '.lua'))
                FlxG.state.openSubState(subState);
            else
                debugTrace('Custom SubState called "' + custom.scriptName + '" doesn\'t Exist', MISSING_FILE);

            return;
        }

		FlxG.state.openSubState(subState);
	}
}