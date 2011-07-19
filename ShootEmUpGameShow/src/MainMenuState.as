package  
{
	import org.flixel.*;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class MainMenuState extends FlxState 
	{
		private var gameTitle:FlxText;
		private var playButton:FlxButton;
		private var aauLogo:AauLogo;
		override public function create():void 
		{
			FlxG.mouse.show();
			FlxG.bgColor = 0xff0000ff;
			gameTitle = new FlxText(0, 60, 320, "The Console War", true);
			gameTitle.alignment = "center";
			gameTitle.size = 20;
			playButton = new FlxButton(120, 160, "Play Game", playPressed);
			aauLogo = new AauLogo(60,320-55);
			add(aauLogo);
			add(gameTitle);
			add(playButton);
		}
		
		private function playPressed():void
		{
			FlxG.switchState(new SelectShipState());
		}
	}

}