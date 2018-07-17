
package gameObjects
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.deg2rad;
	
	/**
	 * Esta clase representa los enemigos (diablos chingos) del juego.
	 *  
	 * @author
	 * 
	 */
	public class Diablo extends Sprite
	{
		/** Tipo de diablo. */
		private var _type:int;
		
		/** Velocidad del enemigo. */
		private var _speed:int;
		
		/** Distancia entre "spawn" de enemigos. */
		private var _distance:int;
		
		/** La bruja ha sido atacada? */
		private var _alreadyHit:Boolean;
		
		/** Posicion vertical de enemigo. */
		private var _position:String;
		
		/** Area de daño de enemigo. */
		private var _hitArea:Image;
		
		/** Arte de enemigos (static). */
		private var diabloImage:Image;
		
		/** Arte de enemigos (animados). */
		private var diabloAnimation:MovieClip;
		
		/** Arte de enemigo lastimado. */
		private var diabloCrashImage:Image;
		
		
		public function Diablo(_ptype:int, _pdistance:int)
		{
			super();
			
			this._type = _ptype;
			this._distance = _pdistance;
			this._speed = GameConstants.DIABLO_SPEED;
			
			_alreadyHit = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			createDiabloArt();
			createDiabloCrashArt();

			
		}
		
		/**
		 * Crea el grafico de enemigo basado en - animacion/imagen y  objectos nuevos/reusados. 
		 * 
		 */
		
		private function createDiabloArt():void
		{
			
			switch(_type)
			{
				case GameConstants.DIABLO_TYPE_1:
					
					//Si es la primera vez que se crea.
					if (diabloAnimation == null)
					{
						diabloAnimation = new MovieClip(Assets.getAtlas().getTextures("Diablo_chingo1" + "_"), 10);
						this.addChild(diabloAnimation);
						Starling.juggler.add(diabloAnimation);
						
						//	trace("Diablo creado" + _type);
						
					} else {
						
						// If this object is being reused. (Last time also this object was an animation).
						diabloAnimation.visible = true;
						Starling.juggler.add(diabloAnimation);
					}
					
					
					break;
				
				case GameConstants.DIABLO_TYPE_2:
					
					//Si es la primera vez que se crea.
					if (diabloAnimation == null)
					{
						diabloAnimation = new MovieClip(Assets.getAtlas().getTextures("Diablo_chingo2" + "_"), 10);
						this.addChild(diabloAnimation);
						Starling.juggler.add(diabloAnimation);
						
						//		trace("Diablo creado" + _type);
						
					} else {
						
						// If this object is being reused. (Last time also this object was an animation).
						diabloAnimation.visible = true;
						Starling.juggler.add(diabloAnimation);
					}
					
					
					break;
				
				case GameConstants.DIABLO_TYPE_3:
					
					//Si es la primera vez que se crea.
					if (diabloAnimation == null)
					{
						diabloAnimation = new MovieClip(Assets.getAtlas().getTextures("Diablo_chingo3" + "_"), 10);
						this.addChild(diabloAnimation);
						Starling.juggler.add(diabloAnimation);
						//		trace("Diablo creado" + _type);
						
					} else {
						
						// If this object is being reused. (Last time also this object was an animation).
						diabloAnimation.visible = true;
						Starling.juggler.add(diabloAnimation);
					}
					
					
					
					break;
				
				case GameConstants.DIABLO_TYPE_4:
					
					//Si es la primera vez que se crea.
					if (diabloAnimation == null)
					{
						diabloAnimation = new MovieClip(Assets.getAtlas().getTextures("Diablo_chingo4" + "_"), 10);
						this.addChild(diabloAnimation);
						Starling.juggler.add(diabloAnimation);
						
					} else {
						
						// If this object is being reused. (Last time also this object was an animation).
						diabloAnimation.visible = true;
						Starling.juggler.add(diabloAnimation);
					}
					
					
					
					break;
				
				diabloAnimation.x = 0;
				diabloAnimation.y = 0;
			}
			
		}
		
		/**
		 * Crea el grafico de diablo chingo lastimado basad en tipo - animacion/imagen y objeto new/reused. 
		 * 
		 */
		
		private function createDiabloCrashArt():void
		{
			
			// trace("diablo_chingo" + _type + "KO");
			
			if (diabloCrashImage == null)
			{
			
				//Si es la primera vez que se crea.
				diabloCrashImage = new Image(Assets.getTexture("Diablo1"));
				this.addChild(diabloCrashImage);
			}
			else
			{
				// Reutilizar grafico
				diabloCrashImage.texture = Assets.getTexture("Diablo1");
					
					//Assets.getAtlas().getTexture("diablo_chingo" + _type + "KO");
			}
			
			// Esconde enemigo lastimado.
			diabloCrashImage.visible = false;
		}
		
		
		
		/**
		 * Si estamos reusando esconde la animacion/grafico anterior, basado en que se ocupa en el momento. 
		 * 
		 */
		private function hidePreviousInstance():void
		{
			// Si reutilizamos grafico y era una animacion, remuevala del juggler.
			// Solo no removueve si esta vez es una animacion.
			if (diabloAnimation != null && _type <= GameConstants.DIABLO_TYPE_4)
			{
				diabloAnimation.visible = false;
				Starling.juggler.remove(diabloAnimation);
			}
			
			// Si reutilizamos grafico y era una imagen, escondala.
			if (diabloImage != null) diabloImage.visible = false;
		}
		
		/**
		 * Set de los graficos, area de daño y animacion de cuidado basado en el tipo de enemigo. 
		 * @param value
		 * 
		 */
		
		public function get type():int { return _type; }
		
		public function set type(value:int):void {
			_type = value;
			
			resetForReuse();
			
			// Si reutilisamos, esconde la previa animacion/grafico, basado en que se ocupe en ese instante.
			hidePreviousInstance();
			
			// Crea grafico de enemigo.
			createDiabloArt();
	
			
		}
		
		
		/**
		 * La bruja ha sido lastimada por un enemigo? 
		 * 
		 */
		public function get alreadyHit():Boolean { return _alreadyHit; }
		
		public function set alreadyHit(value:Boolean):void
		{
			_alreadyHit = value;
			
			if (value)
			{
				
				diabloCrashImage.visible = true;
				
				if (_type >= GameConstants.DIABLO_TYPE_1 || _type <= GameConstants.DIABLO_TYPE_4)
				{
					diabloAnimation.visible = false;
				}
				else
				{
					diabloImage.visible = false;
					Starling.juggler.remove(diabloAnimation);
				}
			}
		}
		
		/**
		 * Velocidad del enemigo. 
		 * 
		 */
		
		public function get speed():int { return _speed; }
		public function set speed(value:int):void { _speed = value; }
		
		/**
		 * Distancia de la dependera la aparicion del enemigo. 
		 * 
		 */
		public function get distance():int { return _distance; }
		public function set distance(value:int):void { _distance = value; }
		
		/**
		 * Posicion vertical del enemigo. 
		 * 
		 */
		
		public function get position():String { return _position; }
		public function set position(value:String):void { _position = value; }
		
		public function get hitArea():Image { return _hitArea; }
		
		/**
		 * Anchura de la textura que define el grafico del Sprite. 
		 */
		override public function get width():Number {
			if (diabloImage) return diabloImage.texture.width;
			else return 0;
		}
		
		/**
		 * Altura de la textura que define el grafico del Sprite. 
		 */
		
		override public function get height():Number
		{
			if (diabloImage) return diabloImage.texture.height;
			else return 0;
		}
		
		/**
		 * Resetea objetos de enemigos para reutilizar. 
		 * 
		 */
		
		public function resetForReuse():void
		{
			this.alreadyHit = false;
			this.rotation = deg2rad(0);
		}
	}
}
