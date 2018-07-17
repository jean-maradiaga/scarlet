

package screens {
	
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.getTimer;
	
	import IU.GameOverContainer;
	import IU.HUD;
	import IU.PauseButton;
	import IU.SoundButton;
	
	import de.flintfabrik.starling.display.FFParticleSystem;
	import de.flintfabrik.starling.display.FFParticleSystem.SystemOptions;
	
	import events.NavigationEvent;
	
	import gameObjects.Bruja;
	import gameObjects.Diablo;
	import gameObjects.DiabloFactory;
	import gameObjects.GameBackground;
	import gameObjects.Item;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;
	import itemBehaviourStrategy.*;


	
	/**
	 * Esta clase contiene el codigo de la mecanias del juego.
	 *  
	 * @author 
	 * 
	 */
	public class InGame extends BaseScreen 
	{
		/** Objeto para fondo del juego. */
		private var bg:GameBackground;
		
		/** Bruja character. */		
		private var bruja:Bruja;
		
		/** Time calculation for animation. */
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		
		// ------------------------------------------------------------------------------------------------------------
		// INTERACCION DEL JUEGO 
		// ------------------------------------------------------------------------------------------------------------
		
		/** Bruja's current X position. */
		private var brujaX:int;
		
		/** Bruja's current Y position. */
		private var brujaY:int;
		
		/** Area de interaccion del juego. */		
		public var gameArea:Rectangle;
		
		/** El juego esta haciendo rendering por hardware o software? */
		private var isHardwareRendering:Boolean;
		
		/** Juego pausado? */
		private var gamePaused:Boolean = false;
		
		/** Estado del jugador. */		
		private var gameState:int;
		
		/** Velocidad de vuelo del jugador. */
		private var playerSpeed:Number;
		
		/** Altura total recorrida por el jugador. */
		private var scoreDistance:Number = 0;
		
		/** Cuanto vamos a agitar la camara al colisionar? */
		private var cameraShake:Number;
		
		/** Total de paginas recuperadas. */
		private var scoreItems:int = 0;
		
		/** Diablo counter - asigna la probabilidad de encontrar diablos. */
		private var diabloGapCount:Number = 0;
		
		/** El poder/vida del diablo despues de ser colisionado. */
		private var hitDiablo:Number = 0;
		
		/** Vidas. */		
		private var lives:int;
		
		/** Por cuanto tiempo se tuvo el poder de una referencia (pagina dorada). */
		private var referencia:Number = 0;
		
		/** Duracion de la particula referencia. */
		private var partRef:Number = 0;
		
		/** Por cuanto tiempo se tuvo el poder de la mana sphere. */
		private var mana:Number = 0;
		
		/** Collision detection for bruja vs items. */
		private var brujaItem_xDist:Number;
		private var brujaItem_yDist:Number;
		private var brujaItem_sqDist:Number;
		
		/** Collision detection for bruja vs diablo. */
		private var brujaDiablos_xDist:Number;
		private var brujaDiablos_yDist:Number;
		private var brujaDiablos_sqDist:Number;
		
		/** Fabrica de items **/
		public var diabloFactory:DiabloFactory;
		
		/** Sound / Mute button. */
		private var soundButton:SoundButton;
		
		// ------------------------------------------------------------------------------------------------------------
		// PATRON PARA EL MANEJO DE CRACION Y MANIPULAMIENTO DE ITEMS
		// ------------------------------------------------------------------------------------------------------------

		/** Patron actual de hojas - 0 = horizontal, 1 = vertical, 2 = zigzag, 3 = random, 4 = special item. */
		private var pattern:int;
		
		/** Cada cuanto se crear el patron verticalmente. */
		private var patternStep:int;
		
		/** Direccion del patron creado - usado para zigzag. */
		private var patternDirection:int;
		
		/** Distancia horizontal entre items en el patron. */
		private var patternGap:Number;
		
		/** Contador entre distancias. */
		private var patternGapCount:Number;
		
		/** Cada cuando se cambia el patron basado en distancias volada. */
		private var patternChange:Number;
		
		/** Trigger para utilizar un patron solo una vez. */
		private var patternOnce:Boolean;
		
		/** Fabrica de Comportamientos */
		public var behaviourFactory:BehaviourFactory;
		
		// ------------------------------------------------------------------------------------------------------------
		// ANIMACION
		// ------------------------------------------------------------------------------------------------------------
		
		/** Items a animar. */
		public var itemsToAnimate:Vector.<Item>;
		
		/** Total number of items. */
		private var itemsToAnimateLength:uint = 0;
		
		/** Diablos a animar. */
		private var diablosToAnimate:Vector.<Diablo>;
		
		// ------------------------------------------------------------------------------------------------------------
		// TOUCH INTERACTION
		// ------------------------------------------------------------------------------------------------------------
		
		/** Posicion Touch X del mouse/dedo. */		
		private var touchX:Number;
		
		/** Posicion Touch Y del mouse/dedofinger. */
		private var touchY:Number;
		
		/** Mantiene un record de las interacciones en pantalla. */
		private var touch:Touch;
		
		// ------------------------------------------------------------------------------------------------------------
		// PARTICULAS
		// ------------------------------------------------------------------------------------------------------------
		
		
		/** Particulas para el aura del mana. */
		 public static var particleMana:FFParticleSystem;
		
		/** Particulas para el efecto de una referencia. */
		 public static var particleRef:FFParticleSystem;
		
		// ------------------------------------------------------------------------------------------------------------
		// HUD
		// ------------------------------------------------------------------------------------------------------------
		
		/** HUD Container. */		
		private var hud:HUD;
		
		// ------------------------------------------------------------------------------------------------------------
		// OBJECTOS DE INTERFACE 
		// ------------------------------------------------------------------------------------------------------------
		
		/** GameOver Container. */
		private var gameOverContainer:GameOverContainer;
		
		/** Pause button. */
		private var pauseButton:PauseButton;
		
		/** Kick Off button in the beginning of the game .*/
		private var startButton:Button;
		
		/** Tween object for game over container. */
		private var tween_gameOverContainer:Tween;
		
		// ------------------------------------------------------------------------------------------------------------
		// Contexto del Juego
		// ------------------------------------------------------------------------------------------------------------
		
		/** Contain a Game object, used in the patron state */
		private var contextGame:Game;
		
		// ------------------------------------------------------------------------------------------------------------
		// Comportamiento de los objectos
		// ------------------------------------------------------------------------------------------------------------
		
		/** Contain the object´s behabiour like paper, mana sphere nad others*/
		private var strategy:ItemStrategyBase;
		
		// ------------------------------------------------------------------------------------------------------------
		// METODOS
		// ------------------------------------------------------------------------------------------------------------

		public function InGame(ContextGame:Game)
		{
			super();
			
			// Is hardware rendering?
			isHardwareRendering = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
			
			//this.visible = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//set contextGame
			this.contextGame = ContextGame;
		}
		
		/**
		 * On added to stage.  
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);


			drawGame();
			drawHUD();
			drawGameOverScreen();
		}		
		
		/**
		 *  INICIALIZAR
		 * 
		 * En esta seccion se cubrira TODO los metodos de encargados de inicializar, dibujar
		 * y lanzar las mecanicas del juegos.
		 * 
		 */		
		
		
		/**
		 * Dibuja los elementos de la pantalla. 
		 * 
		 */
		
		private function drawGame():void
		{
			// Dibuja el fondo.
			
			bg = new GameBackground();
			this.addChild(bg);
			
			// Is hardware rendering, draw particles.
			if (isHardwareRendering)
			{
				
				addManaParticles();
				addRefParticles();

			}
			
			
			// Dibuja la bruja.
			bruja = new Bruja();
			this.addChild(bruja);

			// Boton inicio.
			startButton = new Button(Assets.getTexture("PlayBtn"));
			startButton.x = 340;
			startButton.y = 300;
			startButton.addEventListener(Event.TRIGGERED, onStartButtonClick);
			this.addChild(startButton);
			
			// Pause button.
			pauseButton = new PauseButton();
			pauseButton.x = pauseButton.width * 2;
			pauseButton.y = pauseButton.height * 0.5;
			pauseButton.addEventListener(Event.TRIGGERED, onPauseButtonClick);
			this.addChild(pauseButton);
			
			// Crea el pool de enemigos.
		//	createEnemyPool();
			
			itemsToAnimate = new Vector.<Item>();
			itemsToAnimateLength = 0;
		//	createItemsPool();
			
			// Init el vector de diablos a animar.
			diablosToAnimate = new Vector.<Diablo>();

			diabloFactory = DiabloFactory.getDiabloFactory();
			behaviourFactory = BehaviourFactory.getBehaviourFactory();
			
		} //Fin Draw Game
		
		
		/**
		 * 
		 * Inicializa y agrega las particulas para efecto del mana. Utilizando la libreria
		 * FFParticle la cual implementa sola un objectPool y el patron Pool.
		 * 
		 */
		
		
		private function addManaParticles():void{
			
			
			var manaConfig:XML = XML(new ParticleAssets.ParticleManaXML());
			var manaTexture:Texture = Texture.fromBitmap(new ParticleAssets.ParticleTexture());
			var manaOp:SystemOptions = SystemOptions.fromXML(manaConfig, manaTexture);
			// init particle systems once before creating the first instance
			// creates a particle pool of 512
			// creates four vertex buffers which can batch up to 256 particles each
			
			
			FFParticleSystem.init(512, false, 256, 4);
			
			// create particle system
			
			particleMana = new FFParticleSystem(manaOp);
			particleMana.x = - 100;
			particleMana.y = - 100;
			particleMana.scaleX = 1.2;
			particleMana.scaleY = 1.2;
			
			// add it to the stage (juggler will be managed automatically)
			
			this.addChild(particleMana);
			
		}
		
		/**
		 * 
		 * Inicializa y agrega las particulas para efecto de una referencia. Utilizando la libreria
		 * FFParticle la cual implementa sola un objectPool y el patron Pool.
		 * 
		 */
		
		private function addRefParticles():void{
			
			
			var refConfig:XML = XML(new ParticleAssets.ParticleRefXML());
			var refTexture:Texture = Texture.fromBitmap(new ParticleAssets.ParticleTexture());
			var refOp:SystemOptions = SystemOptions.fromXML(refConfig, refTexture);
			// init particle systems once before creating the first instance
			// creates a particle pool of 512
			// creates four vertex buffers which can batch up to 256 particles each
			
			
			FFParticleSystem.init(512, false, 256, 4);
			
			// create particle system
			
			particleRef = new FFParticleSystem(refOp);
			particleRef.x = - 100;
			particleRef.y = - 100;
			particleRef.scaleX = 1.2;
			particleRef.scaleY = 1.2;
			
			// add it to the stage (juggler will be managed automatically)
			
			this.addChild(particleRef);
			
		}
		
		/**
		 * Draw Heads Up Display. 
		 * 
		 */
		private function drawHUD():void
		{
			hud = new HUD();
			this.addChild(hud);
		}
		
		/**
		 * Draw game over screen. 
		 * 
		 */
		
		private function drawGameOverScreen():void
		{
			gameOverContainer = new GameOverContainer(contextGame);
			gameOverContainer.addEventListener(NavigationEvent.CHANGE_SCREEN, playAgain);
			this.addChild(gameOverContainer);
		}
		
		/**
		 * Play again, al presionar jugar de nuevo reinicia el juego. 
		 * 
		 */
		
		private function playAgain(event:NavigationEvent):void
		{
			if (event.params.id == "playAgain") 
			{
				tween_gameOverContainer = new Tween(gameOverContainer, 1);
				tween_gameOverContainer.fadeTo(0);
				tween_gameOverContainer.onComplete = gameOverFadedOut;
				Starling.juggler.add(tween_gameOverContainer);
				
			}
		}
		
		
		/**
		 *  
		 * Inicializa el juego, restaura todas las variables a sus valores por defecto.
		 * 
		 */
		
		override public function initialize():void
		{
			// Dispose screen temporarily.
			disposeTemporarily();
			
			this.visible = true;
			
			// Calculate elapsed time.
			this.addEventListener(Event.ENTER_FRAME, calculateElapsed);
			
			// Play screen background music.
			if (!Sounds.muted) Sounds.sndBgGame.play(0, 999);
			
			// Define game area.
			gameArea = new Rectangle(0, 100, GameConstants.STAGE_WIDTH, GameConstants.STAGE_HEIGHT - 150);			
				
			// Posicion inicial de la bruja
			bruja.x = -GameConstants.STAGE_WIDTH;
			bruja.y = GameConstants.STAGE_HEIGHT * 0.5;		
			
			
			// Resetea el estado del juego a en espera.
			gameState = GameConstants.GAME_STATE_IDLE;
			
			// Resetea hit, camera shake and player speed.
			hitDiablo = 0;
			playerSpeed = 0;
			cameraShake = 0;
			
			// Resetea background's state to idle.
			bg.state = GameConstants.GAME_STATE_IDLE;
			
			// Resetea game paused states.
			gamePaused = false;
			bg.gamePaused = false;

			// Resetea background speed.
			bg.speed = 0;
			
			// Resetea score y distance travelled.
			scoreItems = 0;
			scoreDistance = 0;
			
			// Define las vidas.
			lives = GameConstants.WITCH_LIVES;
			
			// Resetea el estado de la bruja.
			bruja.state = GameConstants.WITCH_STATE_IDLE;
			
			// Resetea la interaccion con pantalla.
			touchX = bruja.x;
			touchY = bruja.y;

			// Resetea score y distance travelled.
			scoreItems = 0;
			scoreDistance = 0;
			
			// Reset hud values and text fields.
			hud.itemScore = 0;
			hud.distance = 0;
			hud.lives = GameConstants.WITCH_LIVES;
			
			// Resetea los patrones
			pattern = 1;
			patternStep = 15;
			patternDirection = 1;
			patternGap = 20;
			patternGapCount = 0;
			patternChange = 100;
			patternOnce = true;
			
			// Resetea el poder de mana y referencia.
			mana = 0;
			referencia = 0;
			partRef = 0;
			
			// Init el vector de diablos a animar.
			diablosToAnimate = new Vector.<Diablo>();

			// Hide the pause button since the game isn't started yet.
			pauseButton.visible = false;
			
			// Show start button.
			startButton.visible = true;
			
			// Crea y agrege el boton de sonido
			soundButton = new SoundButton();
			soundButton.x = int(soundButton.width * 0.5);
			soundButton.y = int(soundButton.height * 0.5);
			soundButton.addEventListener(Event.TRIGGERED, onSoundButtonClick);
			this.addChild(soundButton)

		}
		
		
		/**
		 * On click of pause button. 
		 * @param event
		 * 
		 */
		
		private function onPauseButtonClick(event:Event):void
		{
			event.stopImmediatePropagation();
			
			// Pause or unpause the game.
			if (gamePaused) gamePaused = false;
			else gamePaused = true;
			
			// Pause the background animation too.
			bg.gamePaused = gamePaused;
		}
		
		
		/**
		 * On start button click. 
		 * @param event
		 * 
		 */
		
		private function onStartButtonClick(event:Event):void
		{
			// Play sound for button click.
			if (!Sounds.muted) Sounds.sndTaunt.play();
			
			// Hide start button.
			startButton.visible = false;
			
			// Show pause button since the game is started.
			pauseButton.visible = true;
			
			// Launch bruja.
			launchWitch();
		}
		
		
		/**
		 * Al infinito y mas alla. 
		 * 
		 */
		
		private function launchWitch():void
		{

			// Touch interaction
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			// Game tick
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		/**
		 * La interaccion en el juego - mouse (web) o touch drag (dispositivos tactiles). 
		 * @param event
		 * 
		 */
		
		private function onTouch(event:TouchEvent):void
		{
			
			// Consegimos las propiedades tactiles con respecto al escenario
			// Agregado un try/catch para evitar errores cuando se cambia de ventanas y no hay un mouse presente
			
			touch = event.getTouch(stage);
			
			if (touch != null) //Si touch no es nulo tratar...
			{
				try{
					touch = event.getTouch(stage);
					touchX = touch.globalX;
					touchY = touch.globalY;
					
				}catch(e:Error){
					
					// handle exception
					
					trace(e);
					
				} //Fin Try/Catch block
				
			} //Fin If
			
		} //Fin onTouch
		

		
		
		
		
		/**
		 *  GAMEPLAY
		 * 
		 * En esta seccion se cubrira el metodo onGameTick descrito mas abajo, el cual
		 * se encargara de manejar que sucede en el juego momento a momento
		 * 
		 */		
		
		
		
		/**
		 * Game Tick - que pasa en cada frame del juego.
		 * @param event
		 * 
		 */
		
		private function onGameTick(event:Event):void
		{
			
			// Si no se esta pausado, avanzar tiempo.
			if (!gamePaused)
			{
			
			// Si no hay coordenadas tactiles, resetea touchX y touchY (para dispositivos tactiles).
			if (isNaN(touchX))
			{
				touchX = GameConstants.STAGE_WIDTH * 0.5;
				touchY = GameConstants.STAGE_HEIGHT * 0.5;
			}
			
			// If hardware rendering, set the particle emitter's x and y.
			if (isHardwareRendering)
			{
				particleMana.emitterX = bruja.x + bruja.width * 0.5 * 0.5;
				particleMana.emitterY = bruja.y + 70;
				
				particleRef.emitterX = bruja.x + bruja.width * 0.5 * 0.5 +10;
				particleRef.emitterY = bruja.y + 10;

			}
			
			switch(gameState)
			{
				
				
				case GameConstants.GAME_STATE_IDLE:
					
					/**
					 * 
					 * ESTADO: Reposo
					 * 
					 * Aqui estan todas las acciones que se pueden tomar durante el reposo.
					 * Basicamente es solo iniciar vuelo
					 * 
					 */
					
					//Al infinito y mas alla
					
					if (bruja.x < GameConstants.STAGE_WIDTH * 0.5 * 0.5)
					{
						bruja.x += ((GameConstants.STAGE_WIDTH * 0.5 * 0.5 + 10) - bruja.x) * 0.05;
						bruja.y = GameConstants.STAGE_HEIGHT * 0.5;
						
						playerSpeed += (GameConstants.WITCH_MIN_SPEED - playerSpeed) * 0.05;
						bg.speed = playerSpeed * elapsed;
						
					} else {
						
						
						gameState = GameConstants.GAME_STATE_FLYING;
					}
					
					break;
				
				
				
				
				case GameConstants.GAME_STATE_FLYING:
					
					/**
					 * 
					 * ESTADO: Volando
					 * 
					 * Aqui estan todas la mecanicas que suceden durante el vuelo.
					 * 
					 */
					
					// Si recolecto una esfera de mana, vuela mas rapido por un corto tiempo.
					if (mana > 0){
						
						playerSpeed += (GameConstants.WITCH_MAX_SPEED - playerSpeed) * 0.2;
						

					}
					

					
					// Si no ha chocado vuela normal
					if (hitDiablo <= 0)	{
						
						// Al volar a velocidades muy altas se crea un campo de fuerza!
						
						if (playerSpeed > GameConstants.WITCH_MIN_SPEED + 100) {
							
						//	createWindForce();
							
							// Animate hero faster.
							
							bruja.setBrujaAnimationSpeed(1);
							
						} else {
							
							// Anima a la bruja de forma regular.
							bruja.setBrujaAnimationSpeed(0);
						}
						
						bruja.y -= (bruja.y - touchY) * 0.1;
						
						// Rota la bruja basedo en mouse position.
						if ((-(bruja.y - touchY) * 0.2) < 30 && (-(bruja.y - touchY) * 0.2) > -30) bruja.rotation = deg2rad(-(bruja.y - touchY) * 0.2);
						
						// Limita rotacion a < 30.
						if (rad2deg(bruja.rotation) > 30 ) bruja.rotation = rad2deg(30);
						if (rad2deg(bruja.rotation) < -30 ) bruja.rotation = -rad2deg(30);
						
						// Confina la bruja a los limites definidos por la game area
						
						if (bruja.y > gameArea.bottom - bruja.height * 0.5)    
						{
							bruja.y = gameArea.bottom - bruja.height * 0.5;
							bruja.rotation = deg2rad(0);
						}
						
						if (bruja.y < gameArea.top + bruja.height * 0.5)    
						{
							bruja.y = gameArea.top + bruja.height * 0.5;
							bruja.rotation = deg2rad(0);
						}

					} else {
						
						// Al chocar...
						
						if (mana <= 0)
						{
							// Animacion de choque para la bruja.
							if (bruja.state != GameConstants.WITCH_STATE_HIT)
							{
								bruja.state = GameConstants.WITCH_STATE_HIT;
							}
							
							// Mueve la bruja al centro de la pantalla
							bruja.y -= (bruja.y - (gameArea.top + gameArea.height)/2) * 0.1;
							
							// Efecto de vueltas sin control al chocar.
							if (bruja.y > GameConstants.STAGE_HEIGHT * 0.5) bruja.rotation -= deg2rad(hitDiablo * 2);
							else bruja.rotation += deg2rad(hitDiablo * 2);
						}
						
						// Al chocar con un diablo.
						hitDiablo--;
						
						// Camera shake.
						cameraShake = hitDiablo;
						shakeAnimation(null);
					}
	
					
					// If we have a mushroom, reduce the value of the power.
					if (mana > 0) mana -= elapsed;
					
					// If we have a coffee, reduce the value of the power.
					if (referencia > 0) referencia -= elapsed;
					if (partRef > 0) referencia -= elapsed;
					
					//Crear itemm (paginas,referencias y mana)
					
					setItemsPattern();
					createItemsPattern();
					animateItems();
					
		
					
					// Guarda las posiciones X/Y de la bruja (utilizad en otras animaciones).
					brujaX = bruja.x;
					brujaY = bruja.y;
					
					playerSpeed -= (playerSpeed - GameConstants.WITCH_MIN_SPEED) * 0.01;
					bg.speed = playerSpeed * elapsed;
					
					// Calcula la maxima distancia volada.
					scoreDistance += (playerSpeed * elapsed) * 0.1;
					hud.distance = Math.round(scoreDistance);

					// Create los diablos.
					initEnemigo();
					
					// Animate elements.
					animateEnemy();
					


					
					break;
				
				
				
				
				case GameConstants.GAME_STATE_OVER:
					
					
					for(var i:uint = 0; i < itemsToAnimate.length; i++)
					{
						if (itemsToAnimate[i] != null)
						{
							// Dispose the item temporarily.
							disposeItemTemporarily(i, itemsToAnimate[i]);
						}
					}
					
					for(var j:uint = 0; j < diablosToAnimate.length; j++)
					{
						if (diablosToAnimate[j] != null)
						{
							// Dispose the obstacle temporarily.
							disposeDiabloTemporarily(j, diablosToAnimate[j]);
						}
					}
					
					

					// Spin dat witch.
					bruja.rotation -= deg2rad(30);
					
					// Make dem witch fall.
					
					// Si la bruja sigue en pantalla, la empuja abajo y afuera de la pantalla. Tambien decrementa la velocidad
					// Checkea si +width esta abajo de width > height. Solo pa' tar seguros.
					if (bruja.y < GameConstants.STAGE_HEIGHT + bruja.width)
					{
						playerSpeed -= playerSpeed * elapsed;
						bruja.y += GameConstants.STAGE_HEIGHT * elapsed; 
					}
					else
					{
						// Una vez que se mueva, resetea la velocidad a 0.
						playerSpeed = 0;
						
						// Para el avanze del juego.
						this.removeEventListener(Event.ENTER_FRAME, onGameTick);
						
						// Game over.
						gameOver();
					}
					
					// Set the background's speed based on hero's speed.
					bg.speed = Math.floor(playerSpeed * elapsed);

					
					break;
				
			} //Fin if GameNotPause
				
		  } //Fin switch
			
		} //Fin Method
		
	/**
	 *  ITEMS
	 * 
	 * En esta seccion se cubrira TODO los metodos de creacion y animacion de
	 * los items utilizados en el juego.
	 * 
	 */	
		
		/**
		 * Set items pattern.  
		 * 
		 */
		
		private function setItemsPattern():void
		{
			// Si no se ha viajado lo suficiente, no se cambia el patron.
			if (patternChange > 0)
			{
				patternChange -= playerSpeed * elapsed;
			}
			else
			{
				// Al viajar cierta distancia, ir cambiando los patrones.
				if ( Math.random() < 0.7 )
				{
					// If  < normal item chance (0.7), decide en un patron al azar para los items.
					pattern = Math.ceil(Math.random() * 4); 
				}
				else
				{
					// If random number is > normal item chance (0.3), decide en un patron al azar para los items especiales.
					
					pattern = Math.ceil(Math.random() * 2) + 9;
				}
				
				if (pattern == GameConstants.ITEM_PATTERN_HORIZONTAL)  
				{
					// Horizontal
					patternStep = 15;
					patternChange = Math.random() * 500 + 500;
				}
				else if (pattern == GameConstants.ITEM_PATTERN_VERTICAL)
				{
					
					// Vertical 
					
					patternOnce = true;
					patternStep = 40;
					patternChange = patternGap * Math.random() * 3 + 5;
				}
				else if (pattern == GameConstants.ITEM_PATTERN_ZIGZAG)
				{
					// ZigZag
					patternStep = Math.round(Math.random() * 2 + 2) * 10;
					if ( Math.random() > 0.5 )
					{
						patternDirection *= -1;
					}
					patternChange = Math.random() * 800 + 800;
				}
				else if (pattern == GameConstants.ITEM_PATTERN_RANDOM)
				{
					// Random 
					patternStep = Math.round(Math.random() * 3 + 2) * 50;
					patternChange = Math.random() * 400 + 400;
				}
				else  
				{
					patternChange = 0;
				}
			}
		}
		
		
		/**
		 * Crea patrones de items al  cruzar el oscuro cielo veraniego.
		 * 
		 */
		private function createItemsPattern():void
		{
			// Create a food item after we pass some distance (patternGap).
			if (patternGapCount < patternGap )
			{
				patternGapCount += playerSpeed * elapsed;
			}
			else if (pattern != 0)
			{
				// If there is a pattern already set.
				patternGapCount = 0;
				
				// Reuse and configure food item.
				createItems();
			}
		}

		/**
		 * Crea un item - solicitado por createPattern() 
		 * 
		 */
		
		private function createItems():void
		{
			
			
			var itemToTrack:Item;
			
			switch (pattern)
			{
				case GameConstants.ITEM_PATTERN_HORIZONTAL:
					// Horizontal, una linea de item que puede ser de cualquier altura, y cambia la posicion del patron al azar.
					strategy = behaviourFactory.getBehaviour(this,GameConstants.ITEM_PATTERN_HORIZONTAL);
					strategy.ejecutar();
					break;
				
				case GameConstants.ITEM_PATTERN_VERTICAL:
					// Vertical, una linea de item que puede ser de cualquier altura, y cambia la posicion del patron al azar.
					strategy = behaviourFactory.getBehaviour(this,GameConstants.ITEM_PATTERN_VERTICAL);
					strategy.ejecutar();
					break;
				
				case GameConstants.ITEM_PATTERN_ZIGZAG:
					// ZigZag, crea un solo item en un lugar y luego hacia abajo hasta tocar el borde de la pantalla
					strategy = behaviourFactory.getBehaviour(this,GameConstants.ITEM_PATTERN_ZIGZAG);
					strategy.ejecutar();
					break;
				
				case GameConstants.ITEM_PATTERN_RANDOM:
					// Escoje una posicion al azar dentro de la pantlla.
					strategy = behaviourFactory.getBehaviour(this,GameConstants.ITEM_PATTERN_RANDOM);
					strategy.ejecutar();
					break;
				
				case GameConstants.ITEM_PATTERN_MANA:
					// Mana, convocando los poderes de los ancestros la bruja utiliza esta energia para volar mas rapido 
					// y ser invulnerable por un corto tiempo .
					// Escoje una posicion al azar dentro de la pantlla.
					strategy = behaviourFactory.getBehaviour(this,GameConstants.ITEM_PATTERN_MANA);
					strategy.ejecutar();
					break;
				
				case GameConstants.ITEM_PATTERN_REF:
					// Referencia, al encontrar esta resumida y crucial sabiduria el nivel de abstraccion de la
					// bruja sube mas rapido por un corto tiempo, y las paginas en el aire son atraidas a ella.
					strategy = behaviourFactory.getBehaviour(this,GameConstants.ITEM_PATTERN_REF);
					strategy.ejecutar();
					break;
			
			}//Fin del switch
			
		}//Fin del function create item


		/**
		 * Anima todo item que este en el vector itemsToAnimate. 
		 * 
		 */
		private function animateItems():void
		{

				var itemToTrack:Item;
				
				for(var i:uint = 0;i<itemsToAnimate.length;i++)
				{
					itemToTrack = itemsToAnimate[i];
					
					if (itemToTrack != null)
					{
						// Si aquiere una referencia, mover paginas hacia la bruja.
						if (referencia > 0 && itemToTrack.itemType <= GameConstants.ITEM_TYPE_REFERENCIA)
						{
							// Mueve items hacia la bruja.
							itemToTrack.x -= (itemToTrack.x - brujaX) * 0.2;
							itemToTrack.y -= (itemToTrack.y - brujaY) * 0.2;
							
							
						}
						else
						{
							// Si el poder de una referencia esta activo atrae,
							// items de lo contrario se mueven igual.
							itemToTrack.x -= playerSpeed * elapsed; 
						}
						
						// Si el item pasa el limite de la pantalla, remover (check-in).
						
						if (itemToTrack.x < -80 || gameState == GameConstants.GAME_STATE_OVER)
						{
							disposeItemTemporarily(i, itemToTrack);
						}
						else
						{
							// Detecta colision, la bruja adquirio un item?
							brujaItem_xDist = itemToTrack.x - brujaX;
							brujaItem_yDist = itemToTrack.y - brujaY;
							brujaItem_sqDist = brujaItem_xDist * brujaItem_xDist + brujaItem_yDist * brujaItem_yDist;
							
							if (brujaItem_sqDist < 5000)
							{
								// Agrega items a la score
								if (itemToTrack.itemType == GameConstants.ITEM_TYPE_1)
								{
									scoreItems += itemToTrack.itemType;
									hud.itemScore = scoreItems;
									if (!Sounds.muted) Sounds.sndPag.play();
								}
								
								else if (itemToTrack.itemType == GameConstants.ITEM_TYPE_MANA) 
								{
									// Al adquirir mana, subir score.
									scoreItems += 1;
									
									// Cuando dura el poder del mana? (en segundos)
									mana = 5;
									if (isHardwareRendering) particleMana.start(mana);
									
									if (!Sounds.muted) Sounds.sndMana.play();
									if (!Sounds.muted) Sounds.sndRisa.play();
								}
								
								else if (itemToTrack.itemType == GameConstants.ITEM_TYPE_REFERENCIA) 
								{
									// Si se adquiere una referencia, sube el score.
									scoreItems += 1;
									
									// Cuanto dura el poder de una referencia(Una vida si se aprende bien)? (en segundos)
									referencia = 20;
									partRef = 0.5;
									if (isHardwareRendering) particleRef.start(partRef);
									
									playRandomRef();

								}
								
								if(referencia > 0){referencia--;}
								
								
								// Crea particula de captura en el lugar donde fue adquirida la pagina.
								//	createEatParticle(itemToTrack);
								
								// Se deshace de los items.
								disposeItemTemporarily(i, itemToTrack);
							}
						}
					}
				}
			}
		
		private function playRandomRef():void
		{
			
			
			
			switch(pattern){
				
				case GameConstants.ITEM_PATTERN_HORIZONTAL:
					
					if (!Sounds.muted) Sounds.sndRef1.play();
					
					break;
				
				case GameConstants.ITEM_PATTERN_VERTICAL:
					
					if (!Sounds.muted) Sounds.sndRef2.play();
					
					break;
				
				case GameConstants.ITEM_PATTERN_ZIGZAG:
					
					if (!Sounds.muted) Sounds.sndRef3.play();
					
					break;
				
				default:
					
					if (!Sounds.muted) Sounds.sndRef4.play();
					
					break;
				
			}
		}
		
		
		
		/**
		 * Elimina el item temporalmente. 
		 * @param animateId
		 * @param item
		 * 
		 */
		
		private function disposeItemTemporarily(animateId:uint, item:Item):void
		{
			itemsToAnimate.splice(animateId, 1);
			this.removeChild(item);
		}
		

		
		
		
		
		
		
		/**
		 *  ENEMIGOS
		 * 
		 * En esta seccion se cubrira TODO los metodos de creacion y animacion de
		 * los enemigos utilizados en el juego.
		 * 
		 */		
		
		
		
		
		/**
		 * Crea los diablos despues que la bruja vuele cierta distancia.
		 * 
		 */
		
		private function initEnemigo():void
		{


			// Crea diablos basado en la distancia recorrida de la bruja.
			if (diabloGapCount < GameConstants.DIABLO_GAP)
			{
				diabloGapCount += playerSpeed * elapsed;
				
			}
			else if (diabloGapCount != 0)
			{
				diabloGapCount = 0;
				// Crea alguno de los 4 diablos.
				
				createDiablos(Math.ceil(Math.random() * 4), Math.random() * 1000 + 1000);
				

			}
		}
		
		/**
		 * Crea los enemigos basados en el tipo recibido y la distancia volada. 
		 * @param _type
		 * @param _distance
		 * 
		 */
		
		private function createDiablos(_type:int, _distance:Number):void
		{

			// Nuevo diablo.
			var enemigo:Diablo = diabloFactory.getDiablo(_type, _distance);
			enemigo.x = GameConstants.STAGE_WIDTH;
			this.addChild(enemigo);
			
			
		//	trace("Velocidad"+ enemigo.speed);

			if (_type <= GameConstants.DIABLO_TYPE_3)
			{
				// Tipo3 van mas arriba.
				if (Math.random() > 0.5)
				{
					enemigo.y = gameArea.top;
					enemigo.position = "top";
				}
				else
				{
					// Tipo1 al medio.
					
					enemigo.y = Math.floor(Math.random() * (gameArea.bottom-enemigo.height - gameArea.top + 1)) + gameArea.top;
					enemigo.position = "middle";

				}
			}
			else
			{
				// Dorados van abajito.
				enemigo.y = gameArea.bottom - 90;
				enemigo.position = "bottom";
			}

			// Anima el enemigo.
			
			diablosToAnimate.push(enemigo);
			
			//trace(enemigo.x);

		}
		

		
		/**
		 * Anima los enemigos marcados para animacion. 
		 * 
		 */
		
		private function animateEnemy():void {
			
			//trace("Animando!")
		
			var enemyToTrack:Diablo;
			var brujaRect:Rectangle;
			var obstacleRect:Rectangle;
			
			for(var i:uint = 0; i < diablosToAnimate.length ; i ++){
				
			//	trace("Adentro del FOR!");
				
				enemyToTrack = diablosToAnimate[i];
				
				
				
				if (enemyToTrack.distance > 0)
				{
					enemyToTrack.distance -= playerSpeed * elapsed;
				}
				else
				{
					
					enemyToTrack.x -= (playerSpeed + enemyToTrack.speed) * elapsed;
				}
				
				// Si el enemigo pasa la pantalla se remueve.
				
				if (enemyToTrack.x < -enemyToTrack.width || gameState == GameConstants.GAME_STATE_OVER)
				{
					disposeDiabloTemporarily(i, enemyToTrack);
				}
				
				// Deteccion de colision - Check si la bruja choca contra algun enemigo.
				brujaDiablos_xDist = enemyToTrack.x - brujaX;
				brujaDiablos_yDist = enemyToTrack.y - brujaY;
				brujaDiablos_sqDist = brujaDiablos_xDist * brujaDiablos_xDist + brujaDiablos_yDist *  brujaDiablos_yDist;
				
				if (brujaDiablos_sqDist < 5000 && !enemyToTrack.alreadyHit)
				{
					enemyToTrack.alreadyHit = true;
					
					if (!Sounds.muted) Sounds.sndHit.play();
					
					if (mana > 0) 
					{
						// Si se tenia mana destruye a ese canalla.
						
						if (enemyToTrack.position == "bottom") enemyToTrack.rotation = deg2rad(100);
						else enemyToTrack.rotation = deg2rad(-100);
						
						// Set hit obstacle value.
						hitDiablo = 30;
						
						// Reduce hero's speed
						playerSpeed *= 0.8; 
						
						// mana--;
					}
					else 
					{
						if (enemyToTrack.position == "bottom") enemyToTrack.rotation = deg2rad(70);
						else enemyToTrack.rotation = deg2rad(-70);
						
						// Si no habia mana, recibe daño.
						hitDiablo = 30; 
						
						// Reduce la velocidad de bruja.
						playerSpeed *= 0.5; 
						
						// Sonido de daño .
						if (!Sounds.muted) Sounds.sndGrunt.play();
						
						// Update lives.
						lives--;
						
						if (lives <= 0)
						{
							lives = 0;
							endGame();
						}
						
						hud.lives = lives;
					}
				}
				
				
			} //Fin del FOR
			
			
		} // Fin de animar
			
		
		/**
		 * Elimina temporalmente el enemigo. Hace un check in (limpia) y reduce la capacidad del vector por 1. 
		 * @param animateId
		 * @param enemigo, enemyToTrack
		 * 
		 */
		private function disposeDiabloTemporarily(animateId:uint, enemigo:Diablo):void
		{
			diablosToAnimate.splice(animateId, 1);
			this.removeChild(enemigo);
		}
	
		
		
		
		
		/**
		 *  OTROS
		 * 
		 * En esta seccion se cubrira TODO los metodos de manejo y administracion de mecaninas
		 * como lo son camara, despejar stage etc.
		 * 
		 */		
		
		
		
		/**
		 * Calcula tiempo elapsado. 
		 * @param event
		 * 
		 */
		
		
		private function calculateElapsed(event:Event):void
		{
			// Setea el tiempo previo.
			timePrevious = timeCurrent;
			
			// Nuevo tiempo actual.
			timeCurrent = getTimer(); 
			
			// Calcula el tiempo que pasa por frame en milisegundos.
			elapsed = (timeCurrent - timePrevious) * 0.001; 
		}
		
		
		
		/**
		 * Eliminar un elemento de forma temporal. 
		 * 
		 */
		
		override public function disposeTemporarily():void
		{
			SoundMixer.stopAll();
			
			gameOverContainer.visible = false;
			
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, calculateElapsed);
			
			if (this.hasEventListener(TouchEvent.TOUCH)) this.removeEventListener(TouchEvent.TOUCH, onTouch);
			
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		/**
		 * 
		 * Mueve la camara a los lados para darle un efecto especial a los choques.
		 * 
		 */
		
		
		private function shakeAnimation(event:Event):void
		{
			// Animate quake effect, shaking the camera a little to the sides and up and down.
			if (cameraShake > 0)
			{
				cameraShake -= 0.1;
				// Shake left right randomly.
				this.x = int(Math.random() * cameraShake - cameraShake * 0.5); 
				// Shake up down randomly.
				this.y = int(Math.random() * cameraShake - cameraShake * 0.5); 
			}
			else if (x != 0) 
			{
				// If the shake value is 0, reset the stage back to normal.
				// Reset to initial position.
				this.x = 0;
				this.y = 0;
			}
		}
		
		/**
		 * On game over screen faded out. 
		 * 
		 */
		
		private function gameOverFadedOut():void
		{
			gameOverContainer.visible = false;
			initialize();
		}
		
		/**
		 * End game. 
		 * 
		 */
		private function endGame():void
		{
			this.x = 0;
			this.y = 0;
			
			// Set Game Over state de modo que todos los elementos se removeran solos.
			gameState = GameConstants.GAME_STATE_OVER;
		}
		
		/**
		 * Game Over - llamado cuando la bruja se sale de la pantalla, en cuyo caso la data de Game Over se debera mostrar. 
		 * 
		 */
		
		private function gameOver():void
		{
			this.setChildIndex(gameOverContainer, this.numChildren-1);
			gameOverContainer.initialize(scoreItems, Math.round(scoreDistance));
			
			tween_gameOverContainer = new Tween(gameOverContainer, 1);
			tween_gameOverContainer.fadeTo(1);
			Starling.juggler.add(tween_gameOverContainer);
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
				
				if (this.visible) Sounds.sndBgGame.play(0, 999);
				
				soundButton.showUnmuteState();
			}
			else
			{
				Sounds.muted = true;
				SoundMixer.stopAll();
				
				soundButton.showMuteState();
			}
		}

	} //Fin InGame
	
} //Fin Pack
 
