package  {
	
	import flash.display.MovieClip;
	
	
	public class Ball extends MovieClip {
		
		public function Ball() {

		}
		
		public function moveBall(speedX:Number,speedY:Number) {
			y += speedY;
			x += speedX;
		}
	}
	
}
