package  
{
	import flash.display.Sprite;
	import org.flixel.*;

	public class SelectShipState extends FlxState
	{
		[Embed(source = '../assets/nintendo/nintendoShip.png')] private var nsTexture:Class;		
		[Embed(source = '../assets/playstation/playstationShip.png')] private var psTexture:Class;		
		[Embed(source = '../assets/xbox/xboxShip.png')] private var xsTexture:Class;
		private var psText:FlxText = new FlxText(20,80,200,"Special Weapon: Blu-rays");
		private var wiiText:FlxText=  new FlxText(20,180,200,"Special Weapon: Wiimote-missiles");
		private var xboxText:FlxText=  new FlxText(20,280,200,"Special Weapon: Red Rings of Death");
		public function SelectShipState() 
		{
			
		}
		override public function create():void 
		{
			super.create();
			add(new FlxButton(10, 50, "Playstation3", psClick));
			add(new FlxButton(10, 150, "Wii", nsClick));
			add(new FlxButton(10, 250, "Xbox360", xsClick));
			add(psText);
			add(wiiText);
			add(xboxText);
			add(new FlxSprite(100, 50, psTexture));
			add(new FlxSprite(100, 150, nsTexture));
			add(new FlxSprite(100, 250, xsTexture));
		}
		
		private function psClick():void
		{
			Registry.init("ps");
			FlxG.mouse.hide();
			FlxG.switchState(new GameState());
		}
		private function nsClick():void
		{
			Registry.init("ns");
			FlxG.mouse.hide();
			FlxG.switchState(new GameState());
		}
		private function xsClick():void
		{
			Registry.init("xs");
			FlxG.mouse.hide();
			FlxG.switchState(new GameState());
		}
	}
}