package screens
{
	
	import flash.media.SoundMixer;
	
	import gameState.FlyState;
	
	import IU.SoundButton;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;


	
	public class Welcome extends BaseScreen
	{
		
		/** Imagen de fondo. */
		private var bg:Image;
		
		/** Titulo del juego. */
		private var title:Image;
		
		/** Play button. */
		private var playBtn:Button;
		
		/** About button. */
		private var aboutBtn:Button;
		
		/** Easter Egg button. */
		private var laughBtn:Button;
		
		/** About text field. */
		private var aboutText:TextField;
		
		/** Imagen de la Bruja. */
		private var bruja:Image;
		
		/** Back button. */
		private var backBtn:Button;
		
		/** Modo de pantalla - "welcome" or "about". */
		private var screenMode:String;
		
		/** Fecha de hoy. */
		private var _currentDate:Date;
		
		
		/**Bruja objecto tipo tween. */
		private var tween_bruja:Tween;
		
		/**Contexto del juego. Usado para el patron state */
		private var contextGame:Game;
		
		/** Sound / Mute button. */
		private var soundButton:SoundButton;
		
		
		public function Welcome(pContextGame:Game)
		{
			super();
			this.visible = false;
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
		//	trace("Bienvenido!");
			drawScreen();
		}
		
		/**
		 * Dibuja los elementos en pantalla. 
		 * 
		 */
		
		private function drawScreen():void
		{
			// GENERAL ELEMENTS
			
			bg = new Image(Assets.getTexture("BgWelcome"));
			bg.blendMode = BlendMode.NONE;
			this.addChild(bg);
			
			title = new Image(Assets.getTexture(("Logo")));
			title.x = 220;
			title.y = 10;
			this.addChild(title);
			
			// WELCOME ELEMENTS
			
			bruja = new Image(Assets.getTexture("BgScarlet"));
			bruja.x = -bruja.width;
			bruja.y = 100;
			this.addChild(bruja);
			
			playBtn = new Button(Assets.getTexture("PlayBtn"));
			playBtn.x = 340;
			playBtn.y = 300;
			playBtn.addEventListener(Event.TRIGGERED, onPlayClick);
			this.addChild(playBtn);
			
			aboutBtn = new Button(Assets.getTexture("AboutBtn"));
			aboutBtn.x = 740;
			aboutBtn.y = 550;
			aboutBtn.addEventListener(Event.TRIGGERED, onAboutClick);
			this.addChild(aboutBtn);
			
			laughBtn = new Button(Assets.getTexture("LaughBtn"));
			laughBtn.hasVisibleArea;
			laughBtn.x = 540;
			laughBtn.y = 365;
			laughBtn.addEventListener(Event.TRIGGERED, onLaughClick);
			this.addChild(laughBtn);
			
			// ELEMENTOS DEL ABOUT
			

			
			aboutText = new TextField(400, 600, "", "Arial", 16, 0xffffff);
			aboutText.visible = false;
			aboutText.text = "Los diablos chingos han robado las páginas del grimorio, se deben de recuperar a toda costa mientras se evitan los diablos. Se tiene 3 intentos, buena suerte!\n" +
				" \nProgramación y Animación:\n" +
				" \nRandall Liu y Jean Maradiaga.\n" +
				" \nArte:\n" +
				" \nLa Garra Liu Lin\n" +
				" \nMúsica:\n" +
				" \nLord Maldron con asesoría de Herr Lisandro Selva\n" +
				" \nMenciones de honor:\n" +
				" \nProf. Antonio Luna y Hemanth Sharma\n" +
				" \nCreado con fines educativos para el curso de Patrones, Universidad Cenfotec utilizando Adobe Flash y Starling Framework.";
			aboutText.x = 50;
			aboutText.y = 170;
			aboutText.hAlign = HAlign.CENTER;
			aboutText.vAlign = VAlign.TOP;
			aboutText.height = aboutText.textBounds.height + 30;
			this.addChild(aboutText);
			
			
			backBtn = new Button(Assets.getTexture("BackBtn"));
			backBtn.visible = false;
			backBtn.x = 570;
			backBtn.y = 320;
			backBtn.addEventListener(Event.TRIGGERED, onAboutBackClick);
			this.addChild(backBtn);
			
			// Crea y agrege el boton de sonido
			soundButton = new SoundButton();
			soundButton.x = int(soundButton.width * 0.5);
			soundButton.y = int(soundButton.height * 0.5);
			soundButton.addEventListener(Event.TRIGGERED, onSoundButtonClick);
			this.addChild(soundButton)
			
			initialize();
		}
		

		/**
		 * Init pantalla de Inicio. 
		 * 
		 */
		
		override public function initialize():void
		{
			disposeTemporarily();
			
			this.visible = true;
			
			// Si no estamos regresando de about, reinicia la musica de fondo.
			if (screenMode != "about")
			{
				if (!Sounds.muted) Sounds.sndBgMain.play(0, 999);
			}
			
			screenMode = "welcome";
			
			bruja.visible = true;
			playBtn.visible = true;
			aboutBtn.visible = true;
			
			aboutText.visible = false;
			backBtn.visible = false;
			
			 bruja.x = -bruja.width;
			 bruja.y = 100;
			
			tween_bruja = new Tween(bruja, 4, Transitions.EASE_OUT);
			tween_bruja.animate("x", 20);
			Starling.juggler.add(tween_bruja);
			
			this.addEventListener(Event.ENTER_FRAME, floatingAnimation);
		}
		
		/**
		 * Retorna a la pantalla de inicio al presionar volver. 
		 * @param event
		 * 
		 */
		private function onAboutBackClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndVolver.play();
			
			initialize();
		}
		
		/**
		 * On play button click. 
		 * @param event
		 * 
		 */
		
		private function onPlayClick(event:Event):void
	    {
			if (!Sounds.muted) Sounds.sndDiabloChingo.play();
			
			new FlyState().handleState(contextGame);
		}
		
		/**
		 * On about button click. 
		 * @param event
		 * 
		 */
		private function onAboutClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndCreditos.play();
			showAbout();
		}
		
		/**
		 * On about laugh click. 
		 * @param event
		 * 
		 */
		
		private function onLaughClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndEaster.play();
		}		
		
		
		/**
		 * Muestra pantalla de about. 
		 * 
		 */
		override public function showAbout():void
		{
			screenMode = "about";
			
			bruja.visible = false;
			playBtn.visible = false;
			aboutBtn.visible = false;
			
			aboutText.visible = true;
			backBtn.visible = true;
		}
		
		/**
		 * Animate floating objects. 
		 * @param event
		 * 
		 */
		private function floatingAnimation(event:Event):void
		{
			_currentDate = new Date();
			bruja.y = 230 + (Math.cos(_currentDate.getTime() * 0.001)) * 20;

		}
		
		/**
		 * Dispose objects temporarily. 
		 * 
		 */
		
		override public function disposeTemporarily():void
		{
			this.visible = false;
			
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, floatingAnimation);
			
			if (screenMode != "about") SoundMixer.stopAll();
		}
		
		/**
		 * On click of the sound/mute button. 
		 * @param event
		 * 
		 */
		
		private function onSoundButtonClick(event:Event = null):void
		{
			if (Sounds.muted)
			{
				Sounds.muted = false;
				if (this.visible) Sounds.sndBgMain.play(0, 999);
				soundButton.showUnmuteState();
			}
			else
			{
				Sounds.muted = true;
				SoundMixer.stopAll();
				
				soundButton.showMuteState();
			}
		}
		
	} //Fin Assets
	
	
	
} //Fin package