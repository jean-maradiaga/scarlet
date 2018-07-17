package itemBehaviourStrategy
{
	import flash.geom.Rectangle;
	
	import gameObjects.Item;
	import gameObjects.ItemFactory;
	
	import screens.InGame;
	
	/**
	 * Clase Abstracta(Seria una abstracta pero en ActionScript no soporta abstraciones, por lo tanto es solo una clase) que 
	 * implementa la interfaz ItemStrategyBase y que sera extendida por las clases hijas.
	 */

	public class AbstractStrategy implements ItemStrategyBase
	{
		
		public var itemToTrack:Item;
		
		/** Patron actual de hojas - 0 = horizontal, 1 = vertical, 2 = zigzag, 3 = random, 4 = special item. */
		public var pattern:int;
		
		/** Coordenada Y del item en el patron. */
		public var patternPosY:int;
		
		/** Cada cuanto se crear el patron verticalmente. */
		public var patternStep:int;
		
		/** Direccion del patron creado - usado para zigzag. */
		public var patternDirection:int;
		
		/** Distancia horizontal entre items en el patron. */
		public var patternGap:Number;
		
		/** Contador entre distancias. */
		public var patternGapCount:Number;
		
		/** Cada cuando se cambia el patron basado en distancias volada. */
		public var patternChange:Number;
		
		/** Distancias del patron creado vertical? */
		public var patternLength:Number;
		
		/** Trigger para utilizar un patron solo una vez. */
		public var patternOnce:Boolean;
		
		/** Coordenada Y del patron - Usado solo en verticales. */
		public var patternPosYstart:Number;
		
		public var g:InGame;
		
		/** Area de interaccion del juego. */		
		public var gameArea:Rectangle;
		
		public var itemFactory:ItemFactory;
		
		public function AbstractStrategy(g:InGame)
		{
			//Setea el InGame
			this.g = g;	
			//Setea el area del juego actual
			gameArea = 	g.gameArea;
			//Obtiene una fabrica de items
			itemFactory = ItemFactory.getItemFactory();
			
			//Setea los valores por defecto de los patrones
			pattern = 1;
			patternPosY = gameArea.top;
			patternStep = 15;
			patternDirection = 1;
			patternGap = 20;
			patternGapCount = 0;
			patternChange = 100;
			patternLength = 50;
			patternOnce = true;
			
			
		}
		
		/** Metodos */
		public function ejecutar():void{}
		
		public function getPattern():int{return pattern};
		public function getPatternPosY():int{return patternPosY};
		public function getPatternStep():int{return patternStep};
		public function getPatternDirection():int{return patternDirection};
		public function getPatternGap():Number{return patternGap};
		public function getPatternGapCount():Number{return patternGapCount};
		public function getPatternChange():Number{return patternChange};
		public function getPatternLength():Number{return patternLength};
		public function getPatternOnce():Boolean{return patternOnce};
		public function getPatternPosYstart():Number{return patternPosYstart};
		
	}//Fin de la clase abstractStrategy
}