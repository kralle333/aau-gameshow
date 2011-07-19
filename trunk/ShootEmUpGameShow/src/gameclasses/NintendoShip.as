package gameclasses 
{
	/**
	 * ...
	 * @author Kralle
	 */
	public class NintendoShip extends Ship
	{
		
		public function NintendoShip() 
		{
			super("ns");
		}
		override public function fire(x:int, y:int):void 
		{
			Registry.PlayerBullets.fire(x, y - 10);
			Registry.PlayerBullets.fire(x+10, y-10);
		}
	}

}