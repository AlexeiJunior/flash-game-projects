package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.media.SoundChannel;
	
	public class PongGame extends MovieClip 
	{
		public var ballSpeed:Number = 15;
		public var playerSpeed:Number = 15;
		
		
		public var backgroundMusic:BackgroundMusic; 
        public var bgmSoundChannel:SoundChannel; 
		public var sfxSoundChannel:SoundChannel;
		public var enemyAppearSound:EnemyAppearSound;
		
		public var player1:Player1;
		public var player2:Player2;
		public var Score01:Number = 0;
		public var Score02:Number = 0;
		public var ball:Ball;
		public var ballSpeedX:Number = ballSpeed;
		public var ballSpeedY:Number = ballSpeed;
		
		public function PongGame() 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keydown);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyup);
			
			Score1.text = Score01.toString();
			Score2.text = Score02.toString();
			
			player1 = new Player1();
			player1.x = 10;
			player1.y = 200;
			addChild(player1);
			
			player2 = new Player2();
			player2.x = 540;
			player2.y = 200;
			addChild(player2);
			
			ball = new Ball();
			ball.x = 275;
			ball.y = 200;
			addChild(ball);
			
			backgroundMusic = new BackgroundMusic();
			enemyAppearSound = new EnemyAppearSound();
			
			
			
			
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		function gameLoop(e:Event):void{
			
				if(ball.y+ball.height/2 > stage.stageHeight || ball.y-ball.height/2 < 0){
					ballSpeedY *= -1;
				}
				if(ball.hitTestObject(player1) || ball.hitTestObject(player2)){
					sfxSoundChannel = enemyAppearSound.play();
					ballSpeedX *= -1;
				}
				
				if(ball.x < -60){
					bgmSoundChannel = backgroundMusic.play();
					var randomX:Number = Math.random() * 200;
					ball.x = 275;
					ball.y = randomX;
					ballSpeedX *= -1;
					Score01++;
					Score1.text = Score01.toString();
				}
				
				if(ball.x > stage.stageWidth+60){
					bgmSoundChannel = backgroundMusic.play();
					var randomXI:Number = Math.random() * 200;
					ball.x = 275;
					ball.y = randomXI;
					ballSpeedX *= -1;
					Score02++;
					Score2.text = Score02.toString();
				}
				
				player1.movePlayer(playerSpeed);
				player2.movePlayer(playerSpeed);
				
				ball.moveBall(ballSpeedX,ballSpeedY);
		}
		
		
		function keyup(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.W:
					player1.moveDown = false;
				break;
				case Keyboard.S:
					player1.moveUp = false;
				break;
				case Keyboard.UP:
					player2.moveDown = false;
				break;
				case Keyboard.DOWN:
					player2.moveUp = false;
				break;
			}
		}
		
		function keydown(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.W:
					player1.moveDown = true;
				break;
				case Keyboard.S:
					player1.moveUp = true;
				break;
				case Keyboard.UP:
					player2.moveDown = true;
				break;
				case Keyboard.DOWN:
					player2.moveUp = true;
				break;
			}
		}
		
	}
}
