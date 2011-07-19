package gameclasses 
{
	import org.flixel.*;
	
	public class Bullet extends FlxSprite
	{
		[Embed(source = '../../assets/nintendo/nintendoBullet.png')]private var nBulletTexture:Class;
		[Embed(source = '../../assets/xbox/xboxBullet.png')]private var xBulletTexture:Class;
		[Embed(source = '../../assets/playstation/playstationBullet.png')]private var pBulletTexture:Class;
		private var speed:int;
		public var enemiesHit:Array = new Array();
		public var damage:int;
		public function Bullet() 
		{
			var texture:Class;
			if (Registry.Player is NintendoShip) { texture = nBulletTexture; speed = 100; damage = 2; }
			else if (Registry.Player is PlaystationShip) { texture = pBulletTexture; speed = 300; damage = 4; }
			else if (Registry.Player is XboxShip) { texture = xBulletTexture; speed = 100; damage = 2;}
			super(200, 200, texture)
			exists = false;
		}
		public function fire(fx:int, fy:int):void
		{
			x = fx;
			y = fy;
			velocity.y -= speed;
			if(Registry.Player is XboxShip) {angularVelocity = 300;}
			exists = true;
		}
		override public function update():void 
		{
			super.update();
			if (y < 0 && exists)
			{
				velocity.y = 0;
				exists = false;
				enemiesHit = new Array();
			}
		}
		public function explode():void
		{
			if (Registry.Player is NintendoShip) 
			{
				velocity.y = 0;
				exists = false;
				enemiesHit = new Array();
			}
		}
	}

}