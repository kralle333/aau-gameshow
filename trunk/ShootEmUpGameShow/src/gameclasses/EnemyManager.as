package gameclasses 
{
	import org.flixel.*;

	public class EnemyManager extends FlxGroup
	{
		public var enemiesAllowed:int = 10;
		private var enemySpeedX:int = 20;
		private var enemySpeedY:int = 100;
		private var enemyHealth:int = 4;
		public var enemyLevel:int = 1;
		private var enemyColor:uint = 0xFFFFFF;
		public function EnemyManager() 
		{
			for (var i:int = 0; i < enemiesAllowed; i++)
			{
				add(new Enemy);
			}
		}
		public function boostEnemies():void
		{
			enemyHealth += 1;
			enemySpeedX += 1;
			enemySpeedY += 1;
			enemyLevel++;
			switch(enemyLevel)
			{
				case 2: enemyColor = 0xFF00FF; break;
				case 3: enemyColor = 0x0FF0F3; break;
				case 4: enemyColor = 0xF0FF93; break;
				case 5: enemyColor = 0x0014FF; break;
			}
		}
		private function spawnEnemy():void
		{
			var enemy:Enemy = Enemy(getFirstDead());
			if (enemy)
			{
				enemy.spawn(enemySpeedX, enemySpeedY, enemyHealth);
				enemy.color = enemyColor;
				if (enemyLevel > 4)
				{
					enemy.angularVelocity = 500;
				}
			}
		}
		private function updateAmount():void
		{
			if ((countLiving() + countDead()) < enemiesAllowed)
			{
				var enemiesToAdd:int = enemiesAllowed - (countLiving() + countDead());
				for (var j:int = 0; j < enemiesToAdd; j++)
				{
					add(new Enemy);
				}
				
			}
		}
		override public function update():void 
		{
			super.update();
			updateAmount();
			if (enemiesAllowed > countLiving())
			{
				spawnEnemy();
			}
		}
	}

}