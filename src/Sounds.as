

package 
{
	import flash.media.Sound;

	/**
	 * Libreria de todos los sonidos y efectos usados en el juego. 
	 * 
	 */
	
	public class Sounds
	{
		/**
		 * Embedded de sonidos. 
		 */		
		

		[Embed(source="../Witchmedia/sounds/pag.mp3")]
		public static const SND_PAG:Class;
		
		
		/**
		 * Originales de Witch
		 */
		[Embed(source="../Witchmedia/sounds/bgGame.mp3")]
		public static const SND_BG_GAME:Class;
		
		[Embed(source="../Witchmedia/sounds/IntroScarlet.mp3")]
		public static const SND_BG_MAIN:Class;
		
		[Embed(source="../Witchmedia/sounds/diabloChingo.mp3")]
		public static const SND_DB_CHNG:Class;
		
		[Embed(source="../Witchmedia/sounds/credits.mp3")]
		public static const SND_CREDIT:Class;
		
		[Embed(source="../Witchmedia/sounds/ready.mp3")]
		public static const SND_READY:Class;
		
		[Embed(source="../Witchmedia/sounds/easterEgg.mp3")]
		public static const SND_EASTER:Class;
		
		[Embed(source="../Witchmedia/sounds/DiabloTaunt.mp3")]
		public static const SND_TAUNT:Class;
		
		[Embed(source="../Witchmedia/sounds/DiabloHit.mp3")]
		public static const SND_HIT:Class;
		
		[Embed(source="../Witchmedia/sounds/Smash.mp3")]
		public static const SND_GRUNT:Class;

		[Embed(source="../Witchmedia/sounds/RisaBruja.mp3")]
		public static const SND_RISA:Class;
		
		[Embed(source="../Witchmedia/sounds/mana.mp3")]
		public static const SND_MANA:Class;
		
		[Embed(source="../Witchmedia/sounds/Ref1.mp3")]
		public static const SND_REF1:Class;
		
		[Embed(source="../Witchmedia/sounds/Ref2.mp3")]
		public static const SND_REF2:Class;
		
		[Embed(source="../Witchmedia/sounds/Ref3.mp3")]
		public static const SND_REF3:Class;
		
		[Embed(source="../Witchmedia/sounds/Ref4.mp3")]
		public static const SND_REF4:Class;
		
		[Embed(source="../Witchmedia/sounds/GameOver.mp3")]
		public static const SND_GAME_OVER:Class;
		
		/**
		 * Init. Sounidos . 
		 */		
		
		public static var sndTaunt:Sound = new Sounds.SND_TAUNT() as Sound;
		public static var sndDiabloChingo:Sound = new Sounds.SND_DB_CHNG() as Sound;
		
		public static var sndEaster:Sound = new Sounds.SND_EASTER() as Sound;
		public static var sndCreditos:Sound = new Sounds.SND_CREDIT() as Sound;
		public static var sndVolver:Sound = new Sounds.SND_READY() as Sound;
		public static var sndBgMain:Sound = new Sounds.SND_BG_MAIN() as Sound;
		public static var sndBgGame:Sound = new Sounds.SND_BG_GAME() as Sound;
		public static var sndOver:Sound = new Sounds.SND_GAME_OVER() as Sound;
		
		
		public static var sndMana:Sound = new Sounds.SND_MANA() as Sound;
		public static var sndRisa:Sound = new Sounds.SND_RISA() as Sound;
		
		public static var sndRef1:Sound = new Sounds.SND_REF1() as Sound;
		public static var sndRef2:Sound = new Sounds.SND_REF2() as Sound;
		public static var sndRef3:Sound = new Sounds.SND_REF3() as Sound;
		public static var sndRef4:Sound = new Sounds.SND_REF4() as Sound;
		
		public static var sndPag:Sound = new Sounds.SND_PAG() as Sound;
		public static var sndHit:Sound = new Sounds.SND_HIT() as Sound;
		public static var sndGrunt:Sound = new Sounds.SND_GRUNT() as Sound;
		
		/**
		 * Sound mute status. 
		 */
		public static var muted:Boolean = false;
	}
}