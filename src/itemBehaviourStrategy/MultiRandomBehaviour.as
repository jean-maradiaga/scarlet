package itemBehaviourStrategy
{
	import screens.InGame;

	public class MultiRandomBehaviour extends AbstractStrategy
	{
		public function MultiRandomBehaviour(_g:InGame)
		{
			super(_g);
		}
		
		override public function ejecutar():void{
			if (Math.random() > 0.3)
			{
				// Asigan los items y se asegura que no esten muy cerca de los bordes.
				// Constante del juego o funcion?
				patternPosY = Math.floor(Math.random() * (gameArea.bottom - gameArea.top + 1)) + gameArea.top;
				
				// Pone items en pantalla, pero sin salirse de los bordes
				while (patternPosY + patternStep < gameArea.bottom)
				{
					itemToTrack = itemFactory.getItem(GameConstants.ITEM_TYPE_1);
					g.addChild(itemToTrack);
					
					// Resetea posicion del item.
					itemToTrack.x = GameConstants.STAGE_WIDTH + itemToTrack.width ;
					itemToTrack.y = patternPosY;
					
					// Marca el item para animacion.
					g.itemsToAnimate.push(itemToTrack)
					
					// Incrementa la posicion y direccion del siguiente item basado en el patron.
					patternPosY += Math.round(Math.random() * 100 + 100);	
				}
			}
			
		}// Fin del procedimiento calcular
		
	}// Fin de la clase RandomStrategy
}