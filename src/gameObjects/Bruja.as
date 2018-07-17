package gameObjects
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * 	Esta clase representa el objeto Bruja.
	 *  
	 * @author 
	 * 
	 */
	public class Bruja extends Sprite
	{
		/** Animacion de Flavia. */
		private var brujaArt:MovieClip;
		
		/** Estado de la bruja. */
		private var _state:int;
		
		public function Bruja()
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
			
			// Set the game state to idle.
			this.state = GameConstants.GAME_STATE_IDLE;
			
			// Initialize hero art and hit area.
			createBrujaArt();
		}
		
		/**
		 * Crea el arte/visuales de la bruja. 
		 * 
		 */
		
		private function createBrujaArt():void
		{
			brujaArt = new MovieClip(Assets.getAtlas().getTextures("FlaviaScarlet_"), 15);
			brujaArt.x = Math.ceil(-brujaArt.width/2);
			brujaArt.y = Math.ceil(-brujaArt.height/2);
			starling.core.Starling.juggler.add(brujaArt);
			this.addChild(brujaArt);
		}
		
		/**
		 * Get/Set:
		 * Estado de la bruja. 
		 * @return 
		 * 
		 */
		
		public function get state():int { return _state; }
		public function set state(value:int):void { _state = value; }
		
		/**
		 * Set velocidad de la animacion. 
		 * @param speed
		 * 
		 */
		public function setBrujaAnimationSpeed(speed:int):void {
			if (speed == 0) brujaArt.fps = 20;
			else brujaArt.fps = 60;
		}
		
		override public function get width():Number
		{
			if (brujaArt) return brujaArt.texture.width;
			else return NaN; //Not A Number.
		}
		
		override public function get height():Number
		{
			if (brujaArt) return brujaArt.texture.height;
			else return NaN;
		}
	}
}
