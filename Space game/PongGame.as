package  
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.media.SoundChannel;
	
	public class PongGame extends MovieClip
	{
		public var player:Player;
		public var speed:Speed; //velocidade da nave
		public var gameTimer:Timer;
		public var aux:Number = 35;//velocidade aux
		public var vel:Number = 35;//velocidade do tiro*2 e da nave e tamanho
		public var time:Number = 24;
		public var tiroG:Boolean = false; //tamanho do tiro 
		public var tempoTiro:Number = 0;
		
		//direcao da nave .. teclado
		public var s:Boolean = false;
		public var w:Boolean = false;
		public var d:Boolean = false;
		public var a:Boolean = false;
		
		//lados do mapa que nao vai poder passar
		public var left:Number = 0;
		public var right:Number = -2560;
		public var down:Number = -1600;
		public var up:Number = 0;
		
		public var tiro:Tiro;
		public var borda:Borda;
		public var mapa:Mapa;
		public var wood:Wood; //madeira que agora é o aço
		public var mat:Array; //MATRIZ
		public var onTiro:Boolean = false; //caso atire
		
		//sound
		public var backgroundMusic:BackgroundMusic; 
        public var bgmSoundChannel:SoundChannel; 
		public var sfxSoundChannel:SoundChannel;
		public var enemyAppearSound:EnemyAppearSound;
		
		public function PongGame()
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,mover);
			stage.addEventListener(KeyboardEvent.KEY_UP,desmover);
		    
			player = new Player();
			
			mapa = new Mapa();
			mapa.x = right/2;
			mapa.y = down/2;
			addChild(mapa);
			
			borda = new Borda();
			borda.x = mapa.x;
			borda.y = mapa.y;
			addChild(borda);
			
			speed = new Speed();
			speed.x = 0;
			speed.y = 0;
			addChild(speed);
			
			wood = new Wood();
			wood.x = 0;
			wood.y = 0;
			addChild(wood);
			
			player.x = 550;//meio da tela
			player.y = 400;//meio da tela
			addChild(player);
			
			backgroundMusic = new BackgroundMusic();
			enemyAppearSound = new EnemyAppearSound();
			
			mat = new Array;
			gameTimer = new Timer(time); //24 milisegundos
			gameTimer.addEventListener(TimerEvent.TIMER, relogio);
			gameTimer.start();
		}
		
		function desmover(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.SPACE:
					onTiro = false;
				break;
				case Keyboard.S:
					s = false;
				break;
				case Keyboard.W:
					w = false;
				break;
				case Keyboard.A:
					a = false;
				break;
				case Keyboard.D:
					d = false;
				break;
			}
		}
		
		function mover(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.S:
					s = true;
				break;
				case Keyboard.W:
					w = true;
				break;
				case Keyboard.A:
					a = true;
				break;
				case Keyboard.D:
					d = true;
				break;
				case Keyboard.SPACE:
					 onTiro = true;
				break;
			}
			
		}
		
		function relogio(timerEvent:TimerEvent)
		{
			rotacaoDiagonal();
			movendoNave();
			trace(speed.x,speed.y);
			if(onTiro){
				
				posicaoTiro();
				
				if(tiroG){
					tempoTiro++;
					
					if(tempoTiro == 100){
						tempoTiro = 1;
						tiroG = false;
						vel = aux;
					}
					
					sfxSoundChannel = enemyAppearSound.play();
					
				}else{
					
					bgmSoundChannel = backgroundMusic.play();
				}
			}
			movendoTiro();
				
			if(player.hitTestPoint(speed.x,speed.y))
			{
				removeChild(speed);
				vel = 100;
				tiroG = true;
			}
			if(tiroG){
				tiro.width = 200;
				tiro.height = 200;
			}
		}
		
		public function rotacaoDiagonal()
		{
			if(s){
				player.rotation = 180;
			}
			if(d){
				player.rotation = 90;
			}
			if(a){
				player.rotation = -90;
			}
			if(w){
				player.rotation = 0;
			}
			if(s && d){
				player.rotation = 135;
			}
			if(s && a){
				player.rotation = -135;
			}
			if(w && a){
				player.rotation = -45;
			}
			if(d && w){
				player.rotation = 45;
			}
		}
		
		public function movendoNave()
		{
			
			if(s){
					mapa.y -= vel;
			}
			if(w){
					mapa.y += vel;
			}
			if(a){
					mapa.x += vel;
			}
			if(d){
					mapa.x -= vel;
			}
			
			speed.y = mapa.y+500;
			speed.x = mapa.x+600;
			if(wood.hitTestPoint(player.x,player.y,true)){
			   trace("true");
			}
			else{
				trace("false");
			}
				wood.y = mapa.y+1200;
				wood.x = mapa.x+1800;
				borda.x = mapa.x;
				borda.y = mapa.y;
		}
		
		public function posicaoTiro()
		{
				tiro = new Tiro(player.rotation);// a direção definida na classe construtora (baseada na rotaçao da nave) 
				mat.push(tiro);
				tiro.x = player.x;
				tiro.y = player.y;
				tiro.width = vel;
				tiro.height = vel;
				addChild(tiro);
		}
		
		public function movendoTiro()
		{
			for each (var tiro:Tiro in mat)
			{
				switch (tiro.direcao)  // Variavel da classe construtora, dessa forma cada tiro vai ser tratado com uma direção unica
				{
						case 0: // move up
						tiro.y -= vel*2;
						break;
						
						case 180: // move down
						tiro.y += vel*2;
						break;
						
						case -90: // move left
						tiro.x -= vel*2;
						break;
						
						case 90: // move right hue
						tiro.x += vel*2;
						break;
						
						case -135: // s a
						tiro.y += vel*2;
						tiro.x -= vel*2;
						break;
						
						case 135: // d s
						tiro.x += vel*2;
						tiro.y += vel*2;
						break;
						
						case -45: // w a
						tiro.y -= vel*2;
						tiro.x -= vel*2;
						break;
						
						case 45: // d w
						tiro.x += vel*2;
						tiro.y -= vel*2;
						break;
				}
			}
		}
	}
}