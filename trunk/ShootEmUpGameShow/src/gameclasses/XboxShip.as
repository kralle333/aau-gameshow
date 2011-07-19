package gameclasses 
{
	/**
	 * ...
	 * @author Kralle
	 */
	public class XboxShip extends Ship
	{
		
		public function XboxShip()
		{
			super("xs");
		}
		override public function fire(x:int, y:int):void 
		{
			Registry.PlayerBullets.fire(x+10, y - 10);
		}
	}

}