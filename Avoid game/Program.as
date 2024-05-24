package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Program extends MovieClip
	{
		public var army:Array; //army é um vetor 
		public var newenemy:Enemy;
		public var gameTimer:Timer;
		public var head:Head;
		
		public function Program() 
		{
			army = new Array();	
			newenemy = new Enemy(100, -15);
			army.push(newenemy); //coloca um novo inimigo no topo da pilha
			addChild(newenemy);  // e o adiciona
			
			head = new Head();
			addChild(head);
			gameTimer = new Timer(25); //game timer é um tempo de 24 milesegundos
			gameTimer.addEventListener(TimerEvent.TIMER, moveEnemy);
			gameTimer.start();
		}
		
		
		
		
		///////////////////////////////////////////////////
		//                RELOGIO                        //
		///////////////////////////////////////////////////
		public function moveEnemy(timerEvent:TimerEvent): void  //esta função é executada a cada 24 milisegundos
		{
			if ( Math.random() < 0.1 )
			{
				var randomX:Number = Math.random() * 550;
				var newenemy:Enemy = new Enemy(randomX , -15); //add um novo inimigo da array na posição random
				army.push(newenemy);
				addChild(newenemy);
				gameScore.addToValue(1);
			}
			head.x = mouseX;
			head.y = mouseY;
				
		for each ( var enemy:Enemy in army){ //para cada inimigo no vetor
				
				enemy.moveDownABit();
				if (head.hitTestObject(enemy)) {
					gameTimer.stop();
					dispatchEvent( new AvatarEvent(AvatarEvent.DEAD));
				}
		}
		
		}
		public function getFinalScore():Number
		{
			return gameScore.currentValue;
		}
	}
}
