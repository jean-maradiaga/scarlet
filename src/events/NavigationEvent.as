
package events
{
	import starling.events.Event;
	
	/**
	 * Esta clase define eventos customisados para navegar el juego.
	 * 
	 */
	public class NavigationEvent extends Event
	{
		/** Change of a screen. */		
		public static const CHANGE_SCREEN:String = "changeScreen";
		
		/** Objeto customisado para pasar parametros a las pantallas. */
		public var params:Object;
		
		public function NavigationEvent(type:String, _params:Object, bubbles:Boolean=false)
		{
			super(type, bubbles);
			params = _params;
		}
	}
}