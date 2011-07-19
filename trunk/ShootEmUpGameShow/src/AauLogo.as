package  
{
	import org.flixel.FlxSprite;
	//Fordi man ikke kan loade graphics ellers >_<
	public class AauLogo extends FlxSprite
	{
		[Embed(source = '../assets/aau.jpg')]private var texture:Class;
		public function AauLogo(x:int,y:int) 
		{
			super(x, y, texture);
		}
		
	}

}