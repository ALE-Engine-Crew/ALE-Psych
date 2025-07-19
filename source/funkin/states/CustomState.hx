package funkin.states;

import haxe.ds.StringMap;

class CustomState extends ScriptState
{
    public static var instance:CustomState;

    public var scriptName:String = '';

    private var arguments:Array<Dynamic>;
    
    private var hsVariables:StringMap<Dynamic>;
    private var luaVariables:StringMap<Dynamic>;

    @:unreflective private var reloadThread:Bool = CoolVars.data.developerMode && CoolVars.data.scriptsHotReloading;

    override public function new(script:String, ?arguments:Array<Dynamic>, ?hsVariables:StringMap<Dynamic>, ?luaVariables:StringMap<Dynamic>)
    {
        super();

        scriptName = script;

        this.arguments = arguments;

        this.hsVariables = hsVariables;
        this.luaVariables = luaVariables;
    }

    override public function create()
    {        
        super.create();

        if (CoolVars.data.scriptsHotReloading && CoolVars.data.developerMode)
        {
            for (ext in ['.hx', '.lua'])
            {
                for (file in [scriptName, 'global'])
                {
                    CoolUtil.createSafeThread(() -> {
                            if (!Paths.fileExists('scripts/states/' + file + ext))
                                return;

                            var lastTime = FileSystem.stat(Paths.getPath('scripts/states/' + file + ext)).mtime.getTime();

                            while (reloadThread)
                            {
                                if (!Paths.fileExists('scripts/states/' + file + ext))
                                {
                                    resetCustomState();

                                    break;
                                }
    
                                var newTime = FileSystem.stat(Paths.getPath('scripts/states/' + file + ext)).mtime.getTime();

                                if (newTime != lastTime)
                                {
                                    lastTime = newTime;

                                    resetCustomState();
                                }
                                
                                Sys.sleep(0.1);
                            }
                    });
                }
            }
        }

        instance = this;

        loadScripts();

        setOnScripts('arguments', arguments);

        for (map in [hsVariables, luaVariables])
            if (map != null)
                for (key in map.keys())
                    if (map == hsVariables)
                        setOnHScripts(key, map.get(key));
                    else
                        setOnLuaScripts(key, map.get(key));

        setOnScripts('resetCustomState', resetCustomState);
        
        callOnScripts('onCreate');

        callOnScripts('postCreate');
    }

    public function loadScripts()
    {
        loadScript('scripts/states/' + scriptName);
        loadScript('scripts/states/global');
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        callOnScripts('onUpdate', [elapsed]);

        callOnScripts('postUpdate', [elapsed]);
    }

    override public function destroy()
    {
        if (CoolVars.data.scriptsHotReloading && CoolVars.data.developerMode)
            reloadThread = false;

        super.destroy();

        callOnScripts('onDestroy');

        instance = null;

        callOnScripts('postDestroy');

        destroyScripts();
    }

    override public function stepHit()
    {
        super.stepHit();

        setOnScripts('curStep', curStep);

        callOnScripts('onStepHit');

        callOnScripts('postStepHit');
    }

    override public function beatHit()
    {
        super.beatHit();

        setOnScripts('curBeat', curBeat);

        callOnScripts('onBeatHit');

        callOnScripts('postBeatHit');
    }

    override public function sectionHit()
    {
        super.sectionHit();

        setOnScripts('curSection', curSection);

        callOnScripts('onSectionHit');

        callOnScripts('postSectionHit');
    }

    override public function onFocus()
    {
        super.onFocus();

        callOnScripts('onOnFocus');

        callOnScripts('postOnFocus');
    }

    override public function onFocusLost()
    {
        super.onFocusLost();

        callOnScripts('onOnFocusLost');

        callOnScripts('postOnFocusLost');
    }

    override public function openSubState(substate:flixel.FlxSubState):Void
    {
        super.openSubState(substate);

        callOnHScripts('onOpenSubState', [substate]);
        callOnLuaScripts('onOpenSubState', [Type.getClassName(Type.getClass(substate))]);

        callOnHScripts('postOpenSubState', [substate]);
        callOnLuaScripts('postOpenSubState', [Type.getClassName(Type.getClass(substate))]);
    }

    override public function closeSubState():Void
    {
        super.closeSubState();

        callOnScripts('onCloseSubState');

        callOnScripts('postCloseSubState');
    }

    public function resetCustomState()
    {
        shouldClearMemory = false;

        CoolUtil.switchState(new CustomState(scriptName, arguments, hsVariables, luaVariables), true, true);

        if (CoolVars.data.scriptsHotReloading && CoolVars.data.developerMode)
            reloadThread = false;
    }
}