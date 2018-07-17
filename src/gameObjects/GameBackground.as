
package gameObjects
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * Esta clase define el fondo del juego, y permite soportar multiples capas de fondo.
	 *  
	 * @author
	 * 
	 */
	
	public class GameBackground extends Sprite
	{
		/**
		 * Diferentes capas de fondo. 
		 */
		
		private var bgLayer1:BgLayer;
		private var bgLayer2:BgLayer;
		private var bgLayer3:BgLayer;
		private var bgLayer4:BgLayer;
		
		/** Velocidad actual de la animacion de fondo. */
		private var _speed:Number = 0;
		
		/** Stado del juego. */		
		private var _state:int;
		
		/** Pausado? */
		private var _gamePaused:Boolean = false;
		
		public function GameBackground()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//Primeras dos imagenes son de fondo.
			bgLayer1 = new BgLayer(1);
			bgLayer1.parallaxDepth = 0.02;
			this.addChild(bgLayer1);
			
	//		bgLayer2 = new BgLayer(2);
	//		bgLayer2.parallaxDepth = 0.2;
	//		this.addChild(bgLayer2);
			
			// Capa Numero 3.
		//	bgLayer3 = new BgLayer(3);
		//	bgLayer3.parallaxDepth = 0.5;
		//	this.addChild(bgLayer3);
			
			//Capa Numero 4.
			
		//	bgLayer4 = new BgLayer(4);
		//	bgLayer4.parallaxDepth = 1;
		//	this.addChild(bgLayer4);
			
			// Inicia animacion de fondo.
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * En cada frame, anima cada capa basado en su fondo de parallax y velocidad de la bruja. 
		 * @param event
		 * 
		 */
		private function onEnterFrame(event:Event):void
		{
			if (!gamePaused)
			{
				// Math.ceil() retorna un integer igual o de mayor valor al numero dado, i.e .75 -> 1.
				// Background 1 - Cielo
				bgLayer1.x -= Math.ceil(_speed * bgLayer1.parallaxDepth);
				
				// Bruja volando a la izquierda
				if (bgLayer1.x > 0) bgLayer1.x = -stage.stageWidth;
				// Bruja volando a la derecha
				if (bgLayer1.x < -stage.stageWidth) bgLayer1.x = bgLayer1.x + stage.stageWidth;
				
				// Background 2 - Hills
			//	bgLayer2.x -= Math.ceil(_speed * bgLayer2.parallaxDepth);
				
				// Bruja volando a la izquierda
			//	if (bgLayer2.x > 0) bgLayer2.x = -stage.stageWidth;
				// Bruja volando a la derecha
			//	if (bgLayer2.x < -stage.stageWidth ) bgLayer2.x = 0;
				
				// Background 3 - Buildings
			//	bgLayer3.x -= Math.ceil(_speed * bgLayer3.parallaxDepth);
				
				// Bruja volando a la izquierda
			//	if (bgLayer3.x > 0) bgLayer3.x = -stage.stageWidth;
				// Bruja volando a la derecha
			//	if (bgLayer3.x < -stage.stageWidth ) bgLayer3.x = 0;
				
				// Background 4 - Trees
			//	bgLayer4.x -= Math.ceil(_speed * bgLayer4.parallaxDepth);
				
				// Bruja volando a la izquierda
			//	if (bgLayer4.x > 0) bgLayer4.x = -stage.stageWidth;
				// Bruja volando a la derecha
			//	if (bgLayer4.x < -stage.stageWidth ) bgLayer4.x = 0;
			}
		}
		
		/**
		 * Pausa GET/SET? 
		 * @return 
		 * 
		 */
		public function get gamePaused():Boolean { return _gamePaused; }
		public function set gamePaused(value:Boolean):void { _gamePaused = value; }
		
		/**
		 *  
		 * Estado de partida.
		 * 
		 */
		public function get state():int { return _state; }
		public function set state(value:int):void { _state = value; }

		/**
		 * Velocidad de bruja.
		 * Perminet consegir y cambiar la velocidad desde fuera de esta clase.
		 */
		public function get speed():Number { return _speed; }
		public function set speed(value:Number):void { _speed = value; }
	}
}