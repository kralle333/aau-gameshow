package  
{
	import adobe.utils.CustomActions;
	import gameclasses.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import flash.utils.getTimer;

	public class GameState extends FlxState 
	{
		[Embed(source = '../assets/pixels/yellow.png')]private var yellowpixel:Class;
		[Embed(source = '../assets/pixels/red.png')]private var redpixel:Class;
		[Embed(source = '../assets/pixels/wii.png')]private var wiipixel:Class;
		private var score:FlxText;
		private var healthBar:FlxBar;
		private var weaponBar:FlxBar;
		public function GameState() 
		{
			
		}
		override public function create():void 
		{
			add(Registry.Player);
			add(Registry.Enemies);
			add(Registry.PlayerBullets);
			playerStatsInit();
		}
		override public function update():void 
		{
			super.update();
			FlxG.overlap(Registry.Player, Registry.PowerUps, powerupCollision);
			
			FlxG.overlap(Registry.PlayerBullets, Registry.Enemies, enemyCollision);
			if (FlxG.score > Registry.Enemies.enemyLevel* 1000)
			{
				Registry.Enemies.boostEnemies();
			}
			else if (FlxG.score > Registry.Enemies.enemyLevel* 1500)
			{
				Registry.Enemies.enemiesAllowed += 5;
			}
			if (!Registry.Player.stunned)
			{
				FlxG.overlap(Registry.Player, Registry.Enemies, playerCollision);
			}
		}	
		
		public function enemyCollision(bullet:FlxObject, enemy:FlxObject):void
		{
			var enemyHit:Enemy =  Enemy(enemy);
			var bulletHit:Bullet = Bullet(bullet);
			for each(var e:Enemy in bulletHit.enemiesHit)
			{
				if (e == enemyHit)
				{
					return;
				}
			}
			enemyHit.hurt(bulletHit.damage*Registry.Player.weaponLevel);
			if (Registry.Player is NintendoShip)
			{
				var emitterNin:FlxEmitter = createEmitter(wiipixel,5);
				emitterNin.at(bulletHit);
				bulletHit.explode();
				
			}
			if (enemyHit.alive && bulletHit.exists)
			{
				bulletHit.enemiesHit.push(enemyHit);
			}
			else if (!enemyHit.alive)
			{
				var emitter:FlxEmitter = createEmitter(yellowpixel,20);
				emitter.at(enemyHit);
				emitter = createEmitter(redpixel,20);
				emitter.at(enemyHit);
				FlxG.score += 50;
				score.text = "Score: " + FlxG.score.toString();
				if (Math.floor(Math.random()*8)==1)
				{
					var powerup:PowerUp = new PowerUp(enemyHit.x, enemyHit.y);
					add(powerup);
					Registry.PowerUps.add(powerup);
				}
			}
		}
		public function playerCollision(ship:FlxObject, enemy:FlxObject):void
		{
			Registry.Player.health -= 2;
			if (Registry.Player.weaponLevel > 1)
			{
				Registry.Player.weaponLevel--;
			}
			FlxG.shake(0.01,0.2);
			Registry.Player.stunned = true;
			Registry.Player.timeOfStun = getTimer();
			if (Registry.Player.health  <= 0)
			{
				var emitter:FlxEmitter = createEmitter(yellowpixel,50);
				emitter.at(Registry.Player);
				emitter = createEmitter(redpixel,50);
				emitter.at(Registry.Player);
				Registry.Player.alive = false;
				remove(Registry.Player);
				FlxG.switchState(new GameOverState());
			}
		}
		public function powerupCollision(player:FlxObject, powerup:FlxObject):void
		{
			Registry.PowerUps.remove(powerup);
			PowerUp(powerup).exists = false;
			if (Ship(player).weaponLevel < 3)
			{
				Ship(player).weaponLevel++;
			}
		}
		private function playerStatsInit():void
		{
			FlxG.score = 0;
			Registry.Player.health = 20;
			var healthText:FlxText = new FlxText(5, 305, 50, "Health: ", true);
			healthText.size = 10;
			add(healthText);
			healthBar = new FlxBar(55, 306, FlxBar.FILL_LEFT_TO_RIGHT, 60, 12, Registry.Player, "health",0,20,true);
			healthBar.createFilledBar(0xFF0000FF, 0xFF00FFFF);
			add(healthBar);
			weaponBar = new FlxBar(280, 306, FlxBar.FILL_LEFT_TO_RIGHT, 30, 12, Registry.Player, "weaponLevel", 1, 4, true);
			weaponBar.createFilledBar(0xFF00FFFF, 0xFF00F00F);
			add(weaponBar);
			score = new FlxText(120, 305, 160, "Score: " + FlxG.score.toString(), true);
			score.size = 10;
			add(score);
			var weaponText:FlxText = new FlxText(220, 305, 200, "Weapon: ", true);
			weaponText.size = 10;
			add(weaponText);
		}
		private function createEmitter(graphic:Class,numberOfParticles:int):FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.makeParticles(graphic,numberOfParticles, 16, false, 0);
			add(emitter);
			emitter.start(true, 5);
			emitter.at(Registry.Player);
			return emitter;
		}
		
	}

}