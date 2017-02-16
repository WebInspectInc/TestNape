package;

import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.FlxObject;

import nape.dynamics.InteractionFilter;
import nape.callbacks.InteractionListener;
import nape.shape.Circle;
import nape.callbacks.*;
import nape.callbacks.CbType;
import flixel.addons.nape.FlxNapeSpace;

using flixel.util.FlxSpriteUtil;

class Player extends FlxNapeSprite {

	// TODO: Move into some "entity" class.
	private var moving:Bool;
	private var moveAngle:Float;
	private var moveDirection:Int = 0;
	public var facingDirection:Int = 1;

	public var grounded = false;

	private var moveSpeed:Int = 200;
	public var state:PlayState; // TODO: make this private properly.

	private var floorCollisionType:CbType = new CbType();
	private var floorSensor:nape.shape.Shape;

	private var playerCbType:CbType = new CbType();

	public function new(?X:Float=0, ?Y:Float=0, state:PlayState)
	{
		super(X, Y);
		this.state = state;
		// var canvas = new FlxSprite();
		// var lineStyle:LineStyle = { color: FlxColor.RED, thickness: 1 };
		// var drawStyle:DrawStyle = { smoothing: true };
		// canvas.drawCircle(0, 0, 16, FlxColor.RED, lineStyle, drawStyle);
		makeGraphic(16, 16, FlxColor.RED);
		createRectangularBody();
		body.allowRotation = false;
		setBodyMaterial(0, 0, .5, 2);
		body.cbTypes.add(playerCbType); // this seems required to have shape cbtypes work :(

		floorSensor = new Circle(4);
		floorSensor.sensorEnabled = true;
		// var sensorFilter = new InteractionFilter();
		// sensorFilter.sensorGroup = Constants.sensorFilterGroup;
		// sensorFilter.sensorMask = Constants.mapFilterGroup;
		// sensorFilter.collisionMask = 0;
		// sensorFilter.userData.data = this;
		// floorSensor.filter = sensorFilter;
		floorSensor.translate(new nape.geom.Vec2(0, 12));
		floorSensor.cbTypes.add(floorCollisionType);
		floorSensor.userData.data = this;

		//FlxNapeSpace.space.listeners.add(new InteractionListener(CbEvent.BEGIN, InteractionType.SENSOR, floorCollisionType, Reg.mapCbType, hitFloor));
		//FlxNapeSpace.space.listeners.add(new InteractionListener(CbEvent.END, InteractionType.SENSOR, floorCollisionType, Reg.mapCbType, leftFloor));

		body.shapes.add(floorSensor);

		this.maxVelocity.y = 400;
	}

	function hitFloor(cb:InteractionCallback)
	{
		var self:Player = cb.int1.userData.data;
		self.grounded = true;
	}

	function leftFloor(cb:InteractionCallback)
	{
		var self:Player = cb.int1.userData.data;
		self.grounded = false;
	}

	public function setMoving(moving:Bool)
	{
		this.moving = moving;
	}

	public function setMoveDirection(moveDirection:Int)
	{
		this.moveDirection = moveDirection;
		if (moveDirection != 0) {
			this.facingDirection = moveDirection;
		}
	}

	override public function update(delta:Float)
	{
		body.velocity.x = this.moveSpeed * this.moveDirection;

		// trace(grounded);

		// body.velocity.y = body.velocity.y + 600 * delta;

		super.update(delta);
	}

	public function jump() {
		if (grounded == true) {
			body.velocity.y = -300;
			grounded = false;
		}
	}
}