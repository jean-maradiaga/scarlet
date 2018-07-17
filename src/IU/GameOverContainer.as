package IU
{
	import gameState.FlyState;
	import gameState.InitialState;
	
	import events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.VAlign;
	
	public class GameOverContainer extends Sprite
	{
		/**Imagen de Background. */
		private var bg:Quad;
		
		/** Text Field para mensajes. */
		private var messageText:TextField;
		
		/** Contenedor de la puntuacion. */
		private var scoreContainer:Sprite;
		
		/** Display de puntuacion - distancia. */
		private var distanceText:TextField;
		
		/** Display de puntuacion - paginas. */
		private var scoreText:TextField;
		
		/** Jugar de nuevo. */
		private var playAgainBtn:Button;
		
		/** Boton de Main Menu. */
		private var mainBtn:Button;
		
		/** About button. */
		private var aboutBtn:Button;
		
		
		/**  Valor de puntuacion - distancia. */
		private var _distance:int;
		
		/** Valor de puntuacion - paginas. */
		private var _score:int;
		
		private var contextGame:Game;
		
		public function GameOverContainer(pContextGame:Game)
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			contextGame = pContextGame;
		}
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawGameOver();
		}
		
		/**
		 * Draw game over screen. 
		 * 
		 */
		private function drawGameOver():void
		{

			
			// Background quad.
			bg = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.75;
			this.addChild(bg);
			
			// Message text field.
			messageText = new TextField(stage.stageWidth, stage.stageHeight * 0.5  + 35, "ESA VIDA!", "Verdana", 25, 0xf3e75f, true);
			messageText.vAlign = VAlign.TOP;
			messageText.height = messageText.textBounds.height;
			messageText.y = (stage.stageHeight * 20)/100;
			this.addChild(messageText);
			
			// Score container.
			scoreContainer = new Sprite();
			scoreContainer.y = (stage.stageHeight * 40)/100;
			this.addChild(scoreContainer);
			
			distanceText = new TextField(stage.stageWidth, 100, "DISTANCIA: 0000000", "Verdana", 16, 0xffffff);
			distanceText.vAlign = VAlign.TOP;
			distanceText.height = distanceText.textBounds.height +10;
			scoreContainer.addChild(distanceText);
			
			scoreText = new TextField(stage.stageWidth, 100, "PAGINAS: 0000000", "Verdana", 16, 0xffffff);
			scoreText.vAlign = VAlign.TOP;
			scoreText.height = scoreText.textBounds.height + 10;
			scoreText.y = distanceText.bounds.bottom + scoreText.height * 0.5;
			scoreContainer.addChild(scoreText);
			
			// Navigation buttons.
			mainBtn = new Button(Assets.getTexture("Home"));
			mainBtn.y = (stage.stageHeight * 70)/100;
			mainBtn.addEventListener(Event.TRIGGERED, onMainClick);
			this.addChild(mainBtn);
			
			playAgainBtn = new Button(Assets.getTexture("RePlay"));
			playAgainBtn.y = mainBtn.y + mainBtn.height * 0.5 - playAgainBtn.height * 0.5;
			playAgainBtn.addEventListener(Event.TRIGGERED, onPlayAgainClick);
			this.addChild(playAgainBtn);
			
			
			mainBtn.x = stage.stageWidth * 0.5 - (mainBtn.width + playAgainBtn.width + 40) * 0.5;
			playAgainBtn.x = mainBtn.bounds.right + 20;

		}
		
		/**
		 * On play-again button click. 
		 * @param event
		 * 
		 */
		private function onPlayAgainClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndDiabloChingo.play();
			
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "playAgain"}));
		}
		
		/**
		 * On main menu button click. 
		 * @param event
		 * 
		 */
		private function onMainClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndDiabloChingo.play();
			
			//this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "mainMenu"}, true));
			
			new InitialState().handleState(contextGame);
		}
		
		/**
		 * On about button click. 
		 * @param event
		 * 
		 */
		private function onAboutClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndDiabloChingo.play();
			
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "about"}, true));
		}
		
		/**
		 * Initialize Game Over container. 
		 * @param _score
		 * @param _distance
		 * 
		 */
		public function initialize(_score:int, _distance:int):void
		{
			this._distance = _distance;
			this._score = _score;
			
			distanceText.text = "DISTANCIA: " + this._distance.toString();
			scoreText.text = "PAGINAS: " + this._score.toString();
			
			this.alpha = 0;
			this.visible = true;
		}
		
		/**
		 * Score. 
		 * @return 
		 * 
		 */
		public function get score():int { return _score; }
		
		/**
		 * Distance. 
		 * @return 
		 * 
		 */
		public function get distance():int { return _distance; }
	}
}
