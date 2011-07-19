package  
{
	import gameclasses.*;
	import org.flixel.FlxGroup;

	public class Registry 
	{
		public static var Player:Ship;
		public static var PlayerBullets:BulletManager;
		public static var Enemies:EnemyManager;
		public static var EnemyBullets:BulletManager;
		public static var PowerUps:FlxGroup = new FlxGroup(30);
		public static function init(shipType:String):void
		{
			switch(shipType)
			{
				case "ps": Player = new PlaystationShip(); break;
				case "ns": Player = new NintendoShip(); break;
				case "xs": Player = new XboxShip(); break;				
			}
			PlayerBullets = new BulletManager();
			EnemyBullets = new BulletManager();
			Enemies = new EnemyManager();
		}
	}

}