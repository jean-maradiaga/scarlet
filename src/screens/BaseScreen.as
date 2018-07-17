package screens
{
	import starling.display.Sprite;
	
	public class BaseScreen extends Sprite
	{
		/**
		 * Clase abstracta que sera implementada por las clases Screen(Toda pantallas del juego a mostrarse)
		 */
		public function BaseScreen()
		{
			super();
		}
		/** Metodos **/
		public function disposeTemporarily():void{};
		public function initialize():void{};
		public function showAbout():void{};
	}
}