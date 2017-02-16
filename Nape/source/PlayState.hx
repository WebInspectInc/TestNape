package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.FlxCamera.FlxCameraFollowStyle;

import flixel.addons.nape.FlxNapeTilemap;

class PlayState extends FlxState
{
	public var map:FlxNapeTilemap;
	public var player:Player;
	public var controller:PlayerController;

	public var time:Float = 0;

	override public function create():Void
	{
		super.create();

		LevelLoader.loadLevel(this, "main");

		this.player = new Player(50, 50, this);
		this.controller = new PlayerController(player);
		add(player);

		//FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		time += delta;
		
		controller.update();
	}
}
