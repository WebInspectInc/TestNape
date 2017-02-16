package;

import flixel.FlxG;
import flixel.math.FlxAngle;

class PlayerController
{
	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;

	var _jump:Bool = false;
	var _attack:Bool = false;
	var _dash:Bool = false;
	var _shoot:Bool = false;

	var playerEntity:Player;

	public function new(playerEntity:Player)
	{
		this.playerEntity = playerEntity;
	}

	public function update()
	{
		_up = FlxG.keys.anyPressed([UP]);
		_down = FlxG.keys.anyPressed([DOWN]);
		_left = FlxG.keys.anyPressed([LEFT]);
		_right = FlxG.keys.anyPressed([RIGHT]);

		_jump = FlxG.keys.anyJustPressed([Z]);
		_attack = FlxG.keys.anyJustPressed([X]);
		_dash = FlxG.keys.anyJustPressed([S]);
		_shoot = FlxG.keys.anyJustPressed([A]);

		// Cancel opposite directions
		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;

		var mA:Int = 0;
		if (_left)
		    mA = -1;
		else if (_right)
		    mA = 1;
		else
			mA = 0;

		this.playerEntity.setMoveDirection(mA);

		if (_jump)
			this.playerEntity.jump();
	}
}