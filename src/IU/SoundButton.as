package IU
{
	import flash.display.BitmapData;
	import flash.media.SoundMixer;
	
	import screens.BaseScreen;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * Esta clase es el boton de sonido, permite poner/quitar el mute.
	 *  
	 * @author 
	 * 
	 */
	public class SoundButton extends Button
	{
		/** Imagen cuando hay sonido.  */
		private var mcUnmuteState:Image;
		
		/** Image cuando NO hay sonido i.e mute. */
		private var imageMuteState:Image;
		


		
		
		public function SoundButton()
		{
			super(Texture.fromBitmapData(new BitmapData(Assets.getTexture("SoundMute").width, Assets.getTexture("SoundMute").height, true, 0)));
			
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
	
			setButtonTextures();
			showUnmuteState();

		}
		

		
		/**
		 * Set textures for button states. 
		 * 
		 */
		private function setButtonTextures():void
		{
			// Normal state - image
			mcUnmuteState = new Image(Assets.getTexture("SoundBtn"));
			this.addChild(mcUnmuteState);
			
			// Selected state - animation
			imageMuteState = new Image(Assets.getTexture("SoundMute"));
			this.addChild(imageMuteState);
		}
		
		/**
		 * Show Off State - Show the mute symbol (sound is muted). 
		 * 
		 */
		public function showUnmuteState():void
		{
			mcUnmuteState.visible = true;
			imageMuteState.visible = false;
		}
		
		/**
		 * Show On State - Show the unmute animation (sound is playing). 
		 * 
		 */
		public function showMuteState():void
		{
			mcUnmuteState.visible = false;
			imageMuteState.visible = true;
		}
		
	
	}
}
