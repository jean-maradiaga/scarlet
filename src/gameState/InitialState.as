package gameState
{	
	import screens.Welcome;
	
	/**
	 * Implementación del IGameState
	 */

	public class InitialState implements IGameState
	{
		public function InitialState(){}
		
		/** Metodo que llama al metodo setScreenState de la clase Game para establecer la pantalla de inicio **/
		public function handleState(pGame:Game):void
		{
			pGame.setScreenState(new Welcome(pGame));
		}
		
	}
}