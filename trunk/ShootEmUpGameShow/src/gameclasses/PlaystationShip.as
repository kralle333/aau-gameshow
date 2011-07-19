package gameclasses 
{
	/**
	 * ...
	 * @author Kralle
	 */
	public class PlaystationShip extends Ship
	{
		
		public function PlaystationShip() 
		{
			super("ps");
		}
		override public function fire(x:int, y:int):void 
		{
			Registry.PlayerBullets.fire(x+2, y-20);
		}
	}

}