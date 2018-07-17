package IU
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	
	/**
	 * This class handles the Heads Up Display for the game.
	 *  
	 * @author 
	 * 
	 */
	public class HUD extends Sprite
	{
		/** Lives left. */
		private var _lives:int;
		
		/** Distance travelled. */
		private var _distance:int;
		
		/** Food items score. */
		private var _itemScore:int;
		
		/** Lives icon.  */		
		private var livesLabel:TextField;
		
		/** Lives TextField. */		
		private var livesText:TextField;
		
		/** Distance icon. */		
		private var distanceLabel:TextField;
		
		/** Distance TextField. */		
		private var distanceText:TextField;
		
		/** Food Score icon. */
		private var itemScoreLabel:TextField;
		
		/** Food Score TextField. */		
		private var itemScoreText:TextField;

		
		public function HUD()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{

			
			// Lives label
			livesLabel = new TextField(150, 20, "V I D A S", "Verdana", 13, 0xffffff);
			livesLabel.hAlign = HAlign.RIGHT;
			livesLabel.vAlign = VAlign.TOP;
			
			livesLabel.x = 150;
			livesLabel.y = 10;
			this.addChild(livesLabel);
			
			// Lives
			livesText = new TextField(150, 75, "5", "Verdana", 13, 0xffffff);
			livesText.hAlign = HAlign.RIGHT;
			livesText.vAlign = VAlign.TOP;
			livesText.width = livesLabel.width;
			
			livesText.x = int(livesLabel.x + livesLabel.width - livesText.width);
			livesText.y = livesLabel.y + livesLabel.height;
			this.addChild(livesText);
			
			// Distance label
			distanceLabel = new TextField(150, 20, "D I S T A N C I A", "Verdana", 13, 0xffffff);
			distanceLabel.hAlign = HAlign.RIGHT;
			distanceLabel.vAlign = VAlign.TOP;
			
			distanceLabel.x = int(stage.stageWidth - distanceLabel.width - 10);
			distanceLabel.y = 5;
			this.addChild(distanceLabel);
			
			// Distance
			distanceText = new TextField(150, 75, "0", "Verdana", 13, 0xffffff);
			distanceText.hAlign = HAlign.RIGHT;
			distanceText.vAlign = VAlign.TOP;
			distanceText.width = distanceLabel.width;
			
			distanceText.x = int(distanceLabel.x + distanceLabel.width - distanceText.width);
			distanceText.y = distanceLabel.y + distanceLabel.height;
			this.addChild(distanceText);
			
			// Score label
			itemScoreLabel = new TextField(150, 20, "P A G I N A S", "Verdana", 13, 0xffffff);
			itemScoreLabel.hAlign = HAlign.RIGHT;
			itemScoreLabel.vAlign = VAlign.TOP;
			
			itemScoreLabel.x = int(distanceLabel.x - itemScoreLabel.width - 50);
			itemScoreLabel.y = 5;
			this.addChild(itemScoreLabel);
			
			// Score
			itemScoreText = new TextField(150, 75, "0","Verdana", 13, 0xffffff);
			itemScoreText.hAlign = HAlign.RIGHT;
			itemScoreText.vAlign = VAlign.TOP;
			itemScoreText.width = itemScoreLabel.width;
			
			itemScoreText.x = int(itemScoreLabel.x + itemScoreLabel.width - itemScoreText.width);
			itemScoreText.y = itemScoreLabel.y + itemScoreLabel.height;
			this.addChild(itemScoreText);
		}
		
		/**
		 * Lives restantes. 
		 * @return 
		 * 
		 */
		public function get lives():int { return _lives; }
		public function set lives(value:int):void
		{
			_lives = value;
			livesText.text = _lives.toString();
		}
		
		/**
		 * Distancia viajada. 
		 * @return 
		 * 
		 */
		public function get distance():int { return _distance; }
		public function set distance(value:int):void
		{
			_distance = value;
			distanceText.text = _distance.toString();
		}
		
		/**
		 * Item Score. 
		 * @return 
		 * 
		 */
		public function get itemScore():int { return _itemScore; }
		public function set itemScore(value:int):void
		{
			_itemScore = value;
			itemScoreText.text = _itemScore.toString();
		}
		
		/**
		 * Agrega zeros a la puntuacion. 
		 * @param value
		 * @return 
		 * 
		 */
		private function addZeros(value:int):String {
			var ret:String = String(value);
			while (ret.length < 7) {
				ret = "0" + ret;
			}
			return ret;
		}
	}
}
