package  
{
	import org.flixel.*;
	public class GameOverState extends FlxState
	{
		private var playButton:FlxButton;
		private var menuButton:FlxButton;
		private var gameTitle:FlxText;
		public function GameOverState() 
		{
		}
		override public function create():void 
		{
			FlxG.mouse.show();
			gameTitle = new FlxText(0, 60, 320, "Game Over \n Your score was "+FlxG.score, true);
			gameTitle.alignment = "center";
			gameTitle.size = 20;
			playButton = new FlxButton(120, 160, "Play again", playPressed);
			menuButton = new FlxButton(120, 200, "Main screen", menuPressed);
			
			add(gameTitle);
			add(playButton);
			add(menuButton);
		}
		private function playPressed():void
		{
			FlxG.switchState(new SelectShipState());
		}
		private function menuPressed():void
		{
			FlxG.switchState(new MainMenuState());
		}
	}

}