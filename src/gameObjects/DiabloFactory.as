package gameObjects
{
	/**
	 * Clase DiabloFactory, encargada de la creación de diablos del juego
	 */
	public class DiabloFactory
	{
		/**Fabrica de diablos**/
		private static var factory:DiabloFactory=null;
		
		public function DiabloFactory(s:Singleton)
		{
			if (s == null) throw new Error("Error, there is no diabloFactory created");
		}
		
		/**
		 * Metodo get, retorna la fabrica de diablos
		 */
		public static function getDiabloFactory():DiabloFactory{
			
			if (factory == null) factory = new DiabloFactory (new Singleton());
			return factory;
			
		}
		
		/**
		 * Metodo get, retorna el diablo según el valor dado.
		 */
		public function getDiablo(_type:int, _distance:Number):Diablo
		{
			var diabloToTrack:Diablo ;
			
			if (diabloToTrack == null) {
				diabloToTrack = new Diablo(_type, _distance);
				
			}
			
			return diabloToTrack;
		}
		
		
	}// fin de la clase Diablo Factory
}


class  Singleton {}