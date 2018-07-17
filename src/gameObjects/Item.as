

package gameObjects
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	/**
	 * Esta clase representa todos los items que se ven en pantalla. 
	 * Como las paginas.
	 * @author 
	 * 
	 */
	public class Item extends Sprite
	{
		/** Item type. */
		private var _itemType:int;
		
		/** Item visuals. */
		private var itemImage:MovieClip;
		
		public function Item(_itemType:int)
		{
			super();
			
			this.itemType = _itemType;
		}

		/**
		 * Set el tipo de item a mostrar (visual). 
		 * @param value
		 * 
		 */
		public function set itemType(value:int):void
		{
			_itemType = value;
	
			// Si reutilisamos, esconde la previa animacion/grafico, basado en que se ocupe en ese instante.
			hidePreviousInstance();
			
			// Crea grafico de enemigo.
			createItemArt();
			
			
		}
		
		private function hidePreviousInstance():void
		{
				// Si reutilizamos grafico y era una animacion, remuevala del juggler.
				// Solo no removueve si esta vez es una animacion.
			
			
				if (itemImage != null && _itemType <= 3)
				{
					itemImage.visible = false;
					Starling.juggler.remove(itemImage);
				}

		}
		

		private function createItemArt():void
		{
			
			switch(_itemType)
			{
				case GameConstants.ITEM_TYPE_1:
					
					if (itemImage == null)
					{
						// Crear por primera vez
						
						itemImage = new MovieClip(Assets.getAtlas().getTextures("Hoja" + "_"), 10);
						itemImage.width = 50;
						itemImage.height = 40;
						this.addChild(itemImage);
						Starling.juggler.add(itemImage);
						
						
					}
					else
					{
						// Para reutilizar
						itemImage.visible = true;
						Starling.juggler.add(itemImage);
						
					}
					
					break;
				
				case GameConstants.ITEM_TYPE_MANA:
					
					if (itemImage == null)
					{
						// Crear por primera vez
						
						itemImage = new MovieClip(Assets.getAtlas().getTextures("ManaSphere" + "_"), 10);
						itemImage.width = 60;
						itemImage.height = 60;
						this.addChild(itemImage);
						Starling.juggler.add(itemImage);
						
						
					}
					else
					{
						// Para reutilizar
						//itemImage.texture = Assets.getAtlas().getTexture("HojaRef" + "_");
						itemImage.visible = true;
						Starling.juggler.add(itemImage);
						
					}
					
					break;
				
				case GameConstants.ITEM_TYPE_REFERENCIA:
					
					if (itemImage == null)
					{
						// Crear por primera vez
						
						itemImage = new MovieClip(Assets.getAtlas().getTextures("HojaRef" + "_"), 10);
						itemImage.width = 50;
						itemImage.height = 39;
						this.addChild(itemImage);
						Starling.juggler.add(itemImage);
						
						
					}
					else
					{
						// Para reutilizar
						itemImage.visible = true;
						Starling.juggler.add(itemImage);
						
					}
					
					
					
					break;
				
				itemImage.x = -itemImage.width/2;
				itemImage.y = -itemImage.height/2;
			}
		}		
			

		/**
		 * Return the type of food item this object is visually representing. 
		 * @return 
		 * 
		 */
		public function get itemType():int
		{
			return _itemType;
		}
	}
}