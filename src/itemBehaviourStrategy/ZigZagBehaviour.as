package itemBehaviourStrategy
{
	import screens.InGame;

	public class ZigZagBehaviour extends AbstractStrategy
	{
		public function ZigZagBehaviour(_g:InGame)
		{
			super(_g);
		}
		
		override public function ejecutar():void{
			
			if (patternDirection == 1 && patternPosY > gameArea.bottom - 50)
			{
				patternDirection = -1;
			}
			else if ( patternDirection == -1 && patternPosY < gameArea.top )
			{
				patternDirection = 1;
			}
			
			if (patternPosY >= gameArea.top && patternPosY <= gameArea.bottom)
			{
				itemToTrack = itemFactory.getItem(GameConstants.ITEM_TYPE_1);
				g.addChild(itemToTrack);
				
				// Resetea posicion de item.
				itemToTrack.x = GameConstants.STAGE_WIDTH + itemToTrack.width ;
				itemToTrack.y = patternPosY;
				
				g.itemsToAnimate.push(itemToTrack)
				
				// Incrementa la posicion y direccion del siguiente item basado en el patron.
				patternPosY += patternStep * patternDirection;
			}
			else
			{
				patternPosY = gameArea.top;
			}
		}// Fin del procedimiento calcular
		
	}
}