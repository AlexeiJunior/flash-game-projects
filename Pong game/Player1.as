package  {
	
	import flash.display.MovieClip;
	
	
	public class Player1 extends MovieClip {
		
		public var moveUp:Boolean = false;
		public var moveDown:Boolean = false;
		
		public function Player1() {
			
		}
		
		public function movePlayer(speed:Number) {
			if(y > 0){
				if(moveDown) y -= speed;
			}
			if(y < stage.stageHeight){
				if(moveUp) y += speed;
			}
		}
	}
	
}
