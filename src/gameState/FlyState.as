package gameState
{
	import IU.SoundButton;
	
	import screens.InGame;

	/**
	 * Implementación del IGameState
	 */
	
	public class FlyState implements IGameState
	{
		
		/** Sound / Mute button. */
		private var soundButton:SoundButton;
		
		
		public function FlyState(){}
		
		/** Metodo que llama al metodo setScreenState de la clase Game para establecer la pantalla del juego **/
		public function handleState(pGame:Game):void
		{
			pGame.setScreenState(new InGame(pGame));
		}
		

		
		
	}
}