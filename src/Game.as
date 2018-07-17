package
{
	
	/** Paquetes de Witch. */
	
	
	
	import IU.SoundButton;
	import flash.media.SoundMixer;
	
	
	import events.NavigationEvent;
	
	import screens.BaseScreen;
	import screens.Welcome;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	public class Game extends Sprite
	{
		/************************************************************************/
		
		/** Sound / Mute button. */
		private var soundButton:SoundButton;
		/** Contiene un screen(Pantalla) **/
		private var screen:BaseScreen;
		
		/************************************************************************/
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedtoStage);
		}
		
		/**
		 * Evento que llama a la funcion de inicializar las pantallas. 
		 * 
		 */
		private function onAddedtoStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedtoStage);
			initScreens();
		}
		
		/**
		 * Init las pantallas del juego. 
		 * 
		 */
		private function initScreens():void {
			
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			screen = new Welcome(this);
			this.addChild(screen);
			screen.initialize(); 
		}
		
		/**
		 * Navegar a pantallas diferentes, Welcome y About. 
		 * @param event
		 * 
		 */
		private function onInGameNavigation(event:NavigationEvent):void
		{
			switch (event.params.id)
			{
				case "mainMenu":
					screen.initialize();
					break;
				case "about":
					screen.initialize();
					screen.showAbout();
					break;
			}
		}
		
		/**
		 * Para cambiar pantalla a modo juego. 
		 * @param event
		 * 
		 */
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch (event.params.id)
			{

				case "play":
					screen.disposeTemporarily();
					screen.initialize();
					break;
			}
		}
		
		/**
		 * Metodo que recibe una pantalla y lo establece susttuyendo en la que tenia
		 */
		public function setScreenState(newScreen:BaseScreen):void
		{
			screen.disposeTemporarily();
			screen = newScreen;
			this.addChild(screen);
			screen.initialize();
		}
		
	} //Fin Game
	
} //Fin pack