package gameObjects
{
	/**
	 * Clase ItemFactory, encargada de la creación de items del juego
	 */
	public class ItemFactory
	{
		/**Fabrica de items**/
		private static var factory:ItemFactory=null;
		
		public function ItemFactory(s:Singleton)
		{
			if (s == null) throw new Error("Error, there is not itemFactory created");
		}
		
		/**
		 * Metodo get, retorna la fabrica de items
		 */
		public static function getItemFactory():ItemFactory{
			
			if (factory == null) factory = new ItemFactory (new Singleton());
			return factory;
			
		}
		
		/**
		 * Metodo get, retorna el item según el valor dado.
		 */
		public function getItem(value:int):Item
		{
			var itemToTrack:Item ;
			
			if (itemToTrack == null) {
				itemToTrack = new Item(value);
				
			}
			
			return itemToTrack;
		}
		
		
	}// fin de la clase Item Factory
}

class  Singleton {}