package  {
	
	import flash.display.MovieClip;
	
	
	public class Player2 extends MovieClip {
		
		public var moveUp:Boolean = false;
		public var moveDown:Boolean = false;
		
		public function Player2() {
			
		}
		
		public function movePlayer(speed:Number)
		{
			if(y > 0){
				if(moveDown) y -= speed;
			}
			if(y < stage.stageHeight){
				if(moveUp) y += speed;
			}
		}
	}
	
}
