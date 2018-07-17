
package
{
	/**
	 * Esta clase representa las constantes en el juego.
	 * Modificar estas mismas permite diferentes comportamientos en el
	 * gameplay como mas vidas, diferentes velocidades etc...
	 * 
	 * @author 
	 * 
	 */
	public class GameConstants
	{
		// Estado del jugador - Que esta haciendo el jugador? -------------
		
		public static const GAME_STATE_IDLE:int = 0;
		public static const GAME_STATE_FLYING:int = 1;
		public static const GAME_STATE_OVER:int = 2;
		
		// Estados de la bruja - cual es la posicion/animation de la bruja?
		
		public static const WITCH_STATE_IDLE:int = 0;
		public static const WITCH_STATE_FLYING:int = 1;
		public static const WITCH_STATE_HIT:int = 2;
		public static const WITCH_STATE_FALL:int = 3;
		
		// Tipos de Items -----------------------------------------
		
		public static const ITEM_TYPE_1:int = 1;
	//	public static const ITEM_TYPE_2:int = 2;
	//	public static const ITEM_TYPE_3:int = 3;
	//	public static const ITEM_TYPE_4:int = 4;
	//	public static const ITEM_TYPE_5:int = 5;
		
		/** Item de Poder- Mana. */
		public static const ITEM_TYPE_MANA:int = 2;
		
		/** Item de Sabiduria - Referencia. */
		public static const ITEM_TYPE_REFERENCIA:int = 3;
		
		// Patrones de items -----------------------------------------
		
		/** Patron - Horizontal. */
		
		public static const ITEM_PATTERN_HORIZONTAL:int = 1;
		
		/** Patron - Vertical. */
		
		public static const ITEM_PATTERN_VERTICAL:int = 2;
		
		/** Patron - ZigZag. */
		
		public static const ITEM_PATTERN_ZIGZAG:int = 3;
		
		/** Patron - Random. */
		
		public static const ITEM_PATTERN_RANDOM:int = 4;
		
		
		/** Patron - Mana. */
		
		public static const ITEM_PATTERN_MANA:int = 10;
		
		
		/** Patron - Referencia. */
		
		public static const ITEM_PATTERN_REF:int = 11;
		
		
		// Enemigos/Diablos Chingos ------------------------------------------
		
		/** Diablo - Rojo. */
		public static const DIABLO_TYPE_1:int = 1;
		
		/** Diablo - Naranja. */		
		public static const DIABLO_TYPE_2:int = 2;
		
		/** Diablo - Verde. */
		public static const DIABLO_TYPE_3:int = 3;
		
		/** Diablo - Shinny. */
		public static const DIABLO_TYPE_4:int = 4;
		
		// Tipos de Particulas ------------------------------------------
		
		/** Particle - Sparkle. */		
		public static const PARTICLE_TYPE_1:int = 1;
		
		/** Particle - Wind Force. */		
		public static const PARTICLE_TYPE_2:int = 2;
		
		// Propiedades de bruja -----------------------------------------
		
		/** The Witch's initial spare lives. */		
		public static const WITCH_LIVES:int = 5;
		
		/** The Witch's minimum speed. */
		public static const WITCH_MIN_SPEED:Number = 650;
		
		/** The Witch's maximum speed when had mana. */		
		public static const WITCH_MAX_SPEED:Number = 1300;
		
		/** Movement speed - game/player/items/obstacles speed. */
		public static const GRAVITY:Number = 10;
		
		// Propiedades de diablos chingos/enemigos ----------------------------
		
		
		/** Obstacle frequency. */
		public static const DIABLO_GAP:Number = 500;
		
		/** Obstacle speed. */		
		public static const DIABLO_SPEED:Number = 40;
		
		
		// Propiedades del escenario ----------------------------
		
		/** Stage Width. */		
		public static const STAGE_WIDTH:Number = 800;
		
		/** Stage Width. */		
		public static const STAGE_HEIGHT:Number = 600;
		
		
		/**
		 * 
		 * Agregar constantes para diferentes velocidades dependiendo del color de diablo
		 * y intentar crear patrones de movimiento diferentes para cada uno. i.e Zigzag, rectas etc.
		 * 
		 */
	}
}