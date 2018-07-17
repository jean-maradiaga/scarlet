package itemBehaviourStrategy
{
	import screens.InGame;

	public class ReferenceBehaviour extends AbstractStrategy
	{
		public function ReferenceBehaviour(_g:InGame)
		{
			super(_g);
		}
		
		override public function ejecutar():void{
			if (Math.random() > 0.3)
			{
				// Asigan los items y se asegura que no esten muy cerca de los bordes.
				patternPosY = Math.floor(Math.random() * (gameArea.bottom - gameArea.top + 1)) + gameArea.top;
			}
			
			itemToTrack = itemFactory.getItem(GameConstants.ITEM_TYPE_REFERENCIA);
			g.addChild(itemToTrack);
			
			// Resetea posicion del item.
			itemToTrack.x = GameConstants.STAGE_WIDTH + itemToTrack.width ;
			itemToTrack.y = patternPosY;
			
			// Marca el item para animacion.
			g.itemsToAnimate.push(itemToTrack);
			
		}// Fin del procedimiento calcular
		
	}// Fin de la clase ReferenceStrategy 
}