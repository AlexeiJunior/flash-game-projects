package  {
	
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	
	
	public class PlayScreen extends MovieClip {
		
		public var playScreen:Program;
		public var gameOverScreen:GameOverScreen;
		public var menuScreen:MenuScreen;
		
		public function PlayScreen() {
			// constructor code
			menuScreen = new MenuScreen();
			menuScreen.addEventListener(NavigationEvent.START, onRequestStart);
			menuScreen.x = 0;
			menuScreen.y = 0;
			addChild(menuScreen);
		}
		
		public function onAvatarDeath(avatarEvent:AvatarEvent):void
		{
			var finalScore:Number = playScreen.getFinalScore();
			
			gameOverScreen = new GameOverScreen();
			gameOverScreen.addEventListener(NavigationEvent.RESTART,onRequestRestart); 
			playScreen.x = 0;
			playScreen.y = 0;
			
			gameOverScreen.setFinalScore( finalScore );
			
			addChild(gameOverScreen);
			Mouse.show();
			playScreen = null;
		}
		
		public function restartGame() {
			// constructor code
			Mouse.hide();
			playScreen = new Program();
			playScreen.addEventListener(AvatarEvent.DEAD, onAvatarDeath);
			playScreen.x = 0;
			playScreen.y = 0;
			addChild(playScreen);
			
			gameOverScreen = null;
			
		}
		
		public function onRequestRestart(navigationEvent:NavigationEvent):void
		{
			restartGame();
		}
		
		public function onRequestStart(navigationEvent:NavigationEvent):void
		{
			Mouse.hide();
			playScreen = new Program();
			playScreen.addEventListener(AvatarEvent.DEAD, onAvatarDeath);
			playScreen.x = 0;
			playScreen.y = 0;
			addChild(playScreen);
			menuScreen = null;
		}
	}
	
}
