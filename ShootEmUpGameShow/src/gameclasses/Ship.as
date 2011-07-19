package gameclasses 
{
	import org.flixel.*;
	import flash.utils.getTimer;
	
	public class Ship extends FlxSprite
	{
		[Embed(source = '../../assets/nintendo/nintendoShip.png')] private var nsTexture:Class;		
		[Embed(source = '../../assets/playstation/playstationShip.png')] private var psTexture:Class;		
		[Embed(source = '../../assets/xbox/xboxShip.png')] private var xsTexture:Class;	
		
		private var lastFired:int = 0;
		private var bulletCoolDown:int = 0;
		private var stunendTime:int = 1000;
		public var stunned:Boolean = false;
		public var timeOfStun:int = 0;
		public var weaponLevel:int = 1;
		public function Ship(shipType:String)
		{
			var texture:Class;
			switch(shipType)
			{
				case "ns":texture = nsTexture; bulletCoolDown = 1000;  break;
				case "ps":texture = psTexture; bulletCoolDown = 1600;  break;
				case "xs":texture = xsTexture; bulletCoolDown = 400;  break;
			}
			health = 100;
			alive = true;
			super(160 - 16, 320 - 30, texture);
		}
		override public function update():void
		{
			if (alive)
			{
				super.update();
				velocity.x = 0;
				velocity.y = 0;
				
				if (FlxG.keys.UP && y > 0)
				{
					velocity.y -= 100;
					if (y <= 0)
					{
						y = 0;
					}
				}
				if (FlxG.keys.DOWN && y < 305-height)
				{
					velocity.y += 100;
					if (y >= 305-height)
					{
						y = 305-height;
					}
				}
				if (FlxG.keys.LEFT && x > 0)
				{
					velocity.x -= 100;
					if (x <= 0)
					{
						x = 0;
					}
				}
				if (FlxG.keys.RIGHT && x < 320-width)
				{
					velocity.x += 100;
					if (x >= 320 - width)
					{
						x = 320 - width;
					}
				}
				if (FlxG.keys.SPACE && getTimer() > lastFired + bulletCoolDown)
				{
					fire(x, y);
					lastFired = getTimer();
				}
				if (stunned)
				{
					if (getTimer() > timeOfStun + stunendTime)
					{
						stunned = false;
						visible = true;
					}
					else if (getTimer() % 3 > 0)
					{
						visible = false;
					}
					else
					{
						visible = true;
					}
				}
			}
		}
	
		public function fire(x:int,y:int):void
		{
			//Overridden
		}
	}

}