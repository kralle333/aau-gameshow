using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.GamerServices;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using Microsoft.Xna.Framework.Media;
using Microsoft.Xna.Framework.Net;
using Microsoft.Xna.Framework.Storage;

namespace SnakeTrampolin
{
	public class Game1 : Microsoft.Xna.Framework.Game
	{
		GraphicsDeviceManager graphics;
		SpriteBatch spriteBatch;

		Texture2D appleTexture;
		Texture2D snakeBodyTexture;
		Texture2D snakeHeadTexture;
		Texture2D background;
		Texture2D horLine;
		Texture2D verLine;
		SpriteFont highScoreFont;

		Random random = new Random();
		KeyboardState prevKeystate;
		bool playScreenActive = true;

		int timer = 0;
		int gameSpeed = 400;

		Vector2[,] playerFieldPosition = new Vector2[25, 20];
		Vector2 applePosition;
		int score = 0;
		List<int> highScore = new List<int>();

		//Snake fields
		int applesEaten = 0;
		List<Vector2> snakePosition = new List<Vector2>();
		bool addingSnakeBody = false;
		string currentDirection = "right";
		bool directionChanged = false;

		public Game1()
		{
			graphics = new GraphicsDeviceManager(this);
			graphics.IsFullScreen = true;
			graphics.PreferredBackBufferWidth = 1024;
			graphics.PreferredBackBufferHeight = 768;

			Content.RootDirectory = "Content";
		}

		protected override void Initialize()
		{
			// TODO: Add your initialization logic here


			base.Initialize();
		}

		protected override void LoadContent()
		{
			// Create a new SpriteBatch, which can be used to draw textures.
			spriteBatch = new SpriteBatch(GraphicsDevice);

			appleTexture = Content.Load<Texture2D>("apple");
			snakeBodyTexture = Content.Load<Texture2D>("snakeBody");
			snakeHeadTexture = Content.Load<Texture2D>("snakeHead");
			background = Content.Load<Texture2D>("backgroundSnake");
			horLine = Content.Load<Texture2D>("horLine");
			verLine = Content.Load<Texture2D>("verLine");
			highScoreFont = Content.Load<SpriteFont>("highScoreFont");

			for (int x = 0; x < 25; x++)
			{
				for (int y = 0; y < 20; y++)
				{
					playerFieldPosition[x, y] = new Vector2(x * 32 + 100, y * 32 + 100);
				}
			}
			SpawnSnake();
			SpawnApple();

			// TODO: use this.Content to load your game content here
		}

		protected override void UnloadContent()
		{
			// TODO: Unload any non ContentManager content here
		}

		protected override void Update(GameTime gameTime)
		{
			KeyboardState keyboardState = Keyboard.GetState();
			if (playScreenActive)
			{
				if (gameSpeed > 200)
				{
					timer += gameTime.ElapsedGameTime.Milliseconds;

					if (timer >= gameSpeed)
					{
						UpdateSnake();
						timer = 0;
						directionChanged = false;
					}
				}
				else
				{
					UpdateSnake();
				}
				if (!directionChanged)
				{
					if (keyboardState.IsKeyDown(Keys.Z) && prevKeystate.IsKeyUp(Keys.Z))
					{
						ChangeDirection("left");
					}
					else if (keyboardState.IsKeyDown(Keys.X) && prevKeystate.IsKeyUp(Keys.X))
					{
						ChangeDirection("right");
					}
				}
			}
			else
			{
				if (keyboardState.IsKeyDown(Keys.Z) && prevKeystate.IsKeyUp(Keys.Z) &&
					keyboardState.IsKeyDown(Keys.X) && prevKeystate.IsKeyUp(Keys.X))
				{
					SpawnSnake();
					SpawnApple();
					gameSpeed = 400;
					playScreenActive = true;
				}
			}
			prevKeystate = keyboardState;
			base.Update(gameTime);
		}
		private void UpdateSnake()
		{
			List<Vector2> previousPosition = new List<Vector2>();
			foreach (Vector2 position in snakePosition)
			{
				previousPosition.Add(position);
			}
			switch (currentDirection)
			{
				case "right": snakePosition[0] += new Vector2(32, 0); break;
				case "left": snakePosition[0] -= new Vector2(32, 0); break;
				case "up": snakePosition[0] -= new Vector2(0, 32); break;
				case "down": snakePosition[0] += new Vector2(0, 32); break;
				default: break;
			}
			for (int i = 1; i < snakePosition.Count; i++)
			{
				snakePosition[i] = previousPosition[i - 1];
			}
			if (addingSnakeBody)
			{
				snakePosition.Add(previousPosition[snakePosition.Count - 1]);
				addingSnakeBody = false;
			}
			if (snakePosition[0] == applePosition)
			{
				addingSnakeBody = true;
				applesEaten++;
				gameSpeed -= 20;
				score += 200;
				SpawnApple();
			}
			DetectCollision();
			score += (gameSpeed-400)/5;
		}
		private void DetectCollision()
		{
			for(int i = 1;i<snakePosition.Count;i++)
			{
				if (snakePosition[0] == snakePosition[i])
				{
					playScreenActive = false;
					highScore.Add(score);
					highScore.Sort();
					score = 0;
					break;
				}
			}
			if (snakePosition[0].X < 100 || snakePosition[0].X > (900-32) ||
				snakePosition[0].Y < 100 || snakePosition[0].Y > (740 - 32))
			{
				playScreenActive = false;
				highScore.Add(score);
				highScore.Sort();
				score = 0;
			}

		}
		private void SpawnApple()
		{
			bool positionFound;
			do
			{
				positionFound = true;
				applePosition = playerFieldPosition[random.Next(25), random.Next(20)];
				foreach (Vector2 position in snakePosition)
				{
					if (position == applePosition)
					{
						positionFound = false;
						break;
					}
				}
			}
			while (positionFound == false);
		}
		private void SpawnSnake()
		{
			snakePosition.Clear();
			snakePosition.Add(playerFieldPosition[4, 4]);
			snakePosition.Add(playerFieldPosition[3, 4]);
			snakePosition.Add(playerFieldPosition[2, 4]);
			currentDirection = "right";
		}
		private void ChangeDirection(string direction)
		{
			if (direction == "right")
			{
				switch (currentDirection)
				{
					case "right": currentDirection = "down"; break;
					case "left": currentDirection = "up"; break;
					case "up": currentDirection = "right"; break;
					case "down": currentDirection = "left"; break;
				}
			}
			else
			{
				switch (currentDirection)
				{
					case "right": currentDirection = "up"; break;
					case "left": currentDirection = "down"; break;
					case "up": currentDirection = "left"; break;
					case "down": currentDirection = "right"; break;
				}
			}
			directionChanged = true;
		}

		protected override void Draw(GameTime gameTime)
		{
			GraphicsDevice.Clear(Color.Black);

			// TODO: Add your drawing code here
			spriteBatch.Begin();
			spriteBatch.Draw(background, new Vector2(100, 100), Color.White);
			if (playScreenActive)
			{
				for (int x = 0; x < 26; x++)
				{
					spriteBatch.Draw(verLine, new Vector2(x*32+100,0+100), Color.White);
				}
				for (int y = 0; y < 21; y++)
				{
					spriteBatch.Draw(horLine, new Vector2(0+100,y*32+100), Color.White);
				}

				#region Drawing snake
				bool headDrawn = false;
				foreach (Vector2 position in snakePosition)
				{
					if (headDrawn)
					{
						spriteBatch.Draw(snakeBodyTexture, position, Color.White);
					}
					else
					{
						switch (currentDirection)
						{
							case "right": spriteBatch.Draw(snakeHeadTexture, position, Color.White); break;
							case "down": spriteBatch.Draw(snakeHeadTexture, position + new Vector2(16f, 16f), null, Color.White, (float)Math.PI/2, new Vector2(16f, 16f), 1, SpriteEffects.None, 0); break;
							case "left": spriteBatch.Draw(snakeHeadTexture, position + new Vector2(16f, 16f), null, Color.White, (float)Math.PI, new Vector2(16f, 16f), 1, SpriteEffects.None, 0); break;
							case "up": spriteBatch.Draw(snakeHeadTexture, position + new Vector2(16f, 16f), null, Color.White, (float)-(Math.PI)/2, new Vector2(16f, 16f), 1, SpriteEffects.None, 0); break;
						}
						
						headDrawn = true;
					}
				}
				#endregion
				spriteBatch.Draw(appleTexture, applePosition + new Vector2(3), Color.White);
			}
			else
			{
				for (int i = 0; i < highScore.Count; i++)
				{
					spriteBatch.DrawString(highScoreFont, (1 + i).ToString() + ": " + highScore[highScore.Count-1-i].ToString(), new Vector2(200, 200 + i * 50), Color.White);
				}
			}
			spriteBatch.End();

			base.Draw(gameTime);
		}
	}
}
