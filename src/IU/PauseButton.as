package IU
{
	import flash.display.BitmapData;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * This class is the pause button for the in-game screen.
	 *  
	 * @author 
	 * 
	 */
	public class PauseButton extends Button
	{
		/** Pause button image. */
		private var pauseImage:Image;
		
		public function PauseButton()
		{
			super(Texture.fromBitmapData(new BitmapData(Assets.getTexture("PauseBtn").width, Assets.getTexture("PauseBtn").height, true, 0)));
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Pause Image
			pauseImage = new Image(Assets.getTexture("PauseBtn"));
			this.addChild(pauseImage);
		}
	}
}