package gameclasses 
{
	import org.flixel.*;

	public class Enemy extends FlxSprite
	{
		[Embed(source = '../../assets/enemy.png')]private var texture:Class;
		public function Enemy() 
		{
			super(0, 0, texture);
			alive = false;
		}
		public function spawn(xspeed:int,yspeed:int,hp:int):void
		{
			velocity.x = Math.random()*xspeed*2-xspeed;
			velocity.y = Math.random() * yspeed+10;
			x = Math.random() * 320;
			y = 0;
			alive = true;
			health = hp;
		}
		
		override public function hurt(Damage:Number):void 
		{
			super.hurt(Damage);
			
			//Shaking after hit
			x -= Math.random() * 3;
			y -= Math.random() * 3;
		}
		override public function kill():void 
		{ 	
			alive = false;
			super.kill();
			
		}
		override public function update():void 
		{
			super.update();
			if (x < 0 - width || x > 320 || y > 305)
			{
				alive = false;
				velocity.y = 0;
				velocity.x = 0;
			}
		}
	}

}