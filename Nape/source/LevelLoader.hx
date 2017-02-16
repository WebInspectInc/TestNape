package;

import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.nape.FlxNapeTilemap;
import flixel.FlxG;

import nape.callbacks.CbType;
import nape.dynamics.InteractionFilter;
import nape.phys.Material;

class LevelLoader 
{
	public static function loadLevel(state: PlayState, level: String) 
	{
		var tilemap = new TiledMap("assets/data/" + level + ".tmx");
		FlxG.worldBounds.setSize(tilemap.fullWidth, tilemap.fullWidth); // makes collision work

		var mainLayer:TiledTileLayer = cast tilemap.getLayer("foreground");
		//var enemyLayer:TiledObjectLayer = cast tilemap.getLayer('enemies');

		state.map = new FlxNapeTilemap();

		var mapFilter = new InteractionFilter();
		mapFilter.collisionGroup = 2;
		mapFilter.sensorGroup = 2;

		state.map.loadMapFromArray(mainLayer.tileArray,
								   mainLayer.width,
								   mainLayer.height,
								   AssetPaths.tinytiles__png,
		                           32, 32, 1);

		state.map.body.cbTypes.add(Reg.mapCbType);
		state.map.setupTileIndices([for (i in 1...671) i]);
		state.map.body.setShapeFilters(mapFilter);
		state.map.body.cbTypes.add(new CbType());

		state.add(state.map);

		// for (enemyObject in enemyLayer.objects) {
		// 	if (enemyObject.type == "SimpleEnemy") {
		// 		var enemy = new SimpleEnemy(enemyObject.x, enemyObject.y);
		// 		state.addEnemy(enemy);
		// 	} else if (enemyObject.type == "ShieldEnemy") {
		// 		var enemy = new ShieldEnemy(enemyObject.x, enemyObject.y);
		// 		state.addEnemy(enemy);
		// 	}
		// }
	}
}