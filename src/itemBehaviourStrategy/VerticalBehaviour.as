package itemBehaviourStrategy
{
	import screens.InGame;

	public class VerticalBehaviour extends AbstractStrategy
	{
		public function VerticalBehaviour(_g:InGame)
		{
			super(_g);
		}
		
		override public function ejecutar():void{
			if (patternOnce == true)
			{
				patternOnce = false;
				
				// Asigna una posicion al azar no mas alla de la altura de la pantalla.
				patternPosY = Math.floor(Math.random() * (gameArea.bottom - gameArea.top + 1)) + gameArea.top;
				
				// Asigna una longitud de no menos de 0.4 de la pantalla, y no mas de 0.8 de la misma.
				patternLength = (Math.random() * 0.4 + 0.4) * GameConstants.STAGE_HEIGHT;
			}
			
			// Asigna la posicion inicial del patron.
			patternPosYstart = patternPosY; 
			
			//Crea la linea de items, pero asegurandose que no pase los limites establecidos de pantalla
			while (patternPosYstart + patternStep < patternPosY + patternLength && patternPosYstart + patternStep < GameConstants.STAGE_HEIGHT * 0.8)
			{	
				itemToTrack = itemFactory.getItem(GameConstants.ITEM_TYPE_1);
				g.addChild(itemToTrack);
						
				// Resetea posicion de item.
				itemToTrack.x = GameConstants.STAGE_WIDTH + itemToTrack.width;
				itemToTrack.y = patternPosYstart;
				
				// Marca el item para animar.
				g.itemsToAnimate.push(itemToTrack)
				
				// Incrementa la posicion del siguiente item basado en el patron.
				patternPosYstart += patternStep;
			}
			
		}// Fin del procedimiento calcular
			
	}
}