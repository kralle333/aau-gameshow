package gameclasses 
{
	import org.flixel.*;
	
	public class PowerUp extends FlxSprite
	{
		[Embed(source = '../../assets/powerup.png')]private var texture:Class;
		public function PowerUp(x:int,y:int) 
		{
			super(x, y, texture);
			velocity.x += Math.random() * 4 - 2;
			velocity.y += 10;
		}
	}

}