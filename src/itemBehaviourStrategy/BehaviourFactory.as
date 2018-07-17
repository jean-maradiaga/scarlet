package itemBehaviourStrategy
{
	import flash.utils.Dictionary;
	import screens.InGame;
	
	public class BehaviourFactory
	{
		private static var pool:Dictionary = new Dictionary;
		private static var BeFactory:BehaviourFactory=null;
		
		/**
		 * Constructor
		 */
		public function BehaviourFactory(s:Singleton)
		{
			if (s == null) throw new Error("Error, there is not BehaviourFactory created");
		}
		
		/**
		 * Metodo get, retorna la fabrica de comportamientos
		 */
		public static function getBehaviourFactory():BehaviourFactory{
			
			if (BeFactory == null) BeFactory = new BehaviourFactory (new Singleton());
			return BeFactory;
			
		}
		
		/**
		 * Metodo get, retorna el behaviour según el valor dado.
		 */
		public function getBehaviour(_g:InGame,_type:int):ItemStrategyBase
		{
			var behaviour:ItemStrategyBase;
			
			if(pool[_type] == null){
				//Crea los objetos del tipo itemStrategyBase si ve que este no ha sido instanciado y guardado en la pool
				switch (_type){
					
					case GameConstants.ITEM_PATTERN_HORIZONTAL:
						behaviour = new HorizontalBehaviour(_g);
						pool[_type] = behaviour;
						break;
					
					case GameConstants.ITEM_PATTERN_VERTICAL:
						behaviour = new VerticalBehaviour(_g);
						pool[_type] = behaviour;
						break;
					
					case GameConstants.ITEM_PATTERN_ZIGZAG:
						behaviour = new ZigZagBehaviour(_g);
						pool[_type] = behaviour;
						break;
					
					case GameConstants.ITEM_PATTERN_RANDOM:	
						behaviour = new MultiRandomBehaviour(_g);
						pool[_type] = behaviour;
						break;
					
					case GameConstants.ITEM_PATTERN_MANA:	
						behaviour = new ManaSphereBehaviour(_g);
						pool[_type] = behaviour;
						break;
					
					case GameConstants.ITEM_PATTERN_REF:	
						behaviour = new ReferenceBehaviour(_g);
						pool[_type] = behaviour;
						break;
					
				}//Fin del Switch
				
			}else{
				behaviour = pool[_type];//Recupera un objeto itemStrategyBase
			}//Fin frl if/else
			

			return behaviour;
		}//Fin del function getBehaviour 
		
	}
}

class  Singleton {}