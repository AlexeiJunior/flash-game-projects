package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class GameOverScreen extends MovieClip {
		
		
		public function GameOverScreen() {
			// constructor code
			restartButton.addEventListener(MouseEvent.CLICK, onClickRestart);
		}
		
		public function onClickRestart(mouseEvent:MouseEvent):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.RESTART));
		}
		
		public function setFinalScore( scoreValue:Number ):void
		{
			finalScore.text = scoreValue.toString();
		}

	}
	
}
