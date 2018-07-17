package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		
			/**
			 * Atlas de texturas. 
			 */
			
			[Embed(source="../Witchmedia/graphics/Spritesheet/ScarletWitch.png")]
			public static const AtlasTextureGame:Class;
			
			[Embed(source="../Witchmedia/graphics/Spritesheet/ScarletWitch.xml", mimeType="application/octet-stream")]
			public static const AtlasXmlGame:Class;
			
			/**
			 *  Assets de Fondo y botones.
			 */
			
			[Embed(source="../Witchmedia/graphics/bgLayer3.jpg")]
			public static const BgLayer1:Class;
			
			[Embed(source="../Witchmedia/graphics/bgWelcome.jpg")]
			public static const BgWelcome:Class;
			
			[Embed(source="../Witchmedia/graphics/FlaviaScarlet.png")]
			public static const BgScarlet:Class;
			
			[Embed(source="../Witchmedia/graphics/play.png")]
			public static const PlayBtn:Class;
			
			[Embed(source="../Witchmedia/graphics/pause.png")]
			public static const PauseBtn:Class;
			
			[Embed(source="../Witchmedia/graphics/sound.png")]
			public static const SoundBtn:Class;
			
			[Embed(source="../Witchmedia/graphics/soundMute.png")]
			public static const SoundMute:Class;
			
			[Embed(source="../Witchmedia/graphics/about.png")]
			public static const AboutBtn:Class;
			
			[Embed(source="../Witchmedia/graphics/home.png")]
			public static const Home:Class;
			
			[Embed(source="../Witchmedia/graphics/Replay.png")]
			public static const RePlay:Class;
			
			[Embed(source="../Witchmedia/graphics/logo.png")]
			public static const Logo:Class;
			
			[Embed(source="../Witchmedia/graphics/btnBack.png")]
			public static const BackBtn:Class;
			
			[Embed(source="../Witchmedia/graphics/laugh.png")]
			public static const LaughBtn:Class;
			
			[Embed(source="../Witchmedia/graphics/Diablo1.png")]
			public static const Diablo1:Class;
			
			/**
			 * Cache de Texturas 
			 */
			
			private static var gameTextures:Dictionary = new Dictionary();
			private static var gameTextureAtlas:TextureAtlas;
			
			/**
			 * Returna una instancia del atlas de texturas.
			 * @return the TextureAtlas instance (Singleton)
			 */
			
			public static function getAtlas():TextureAtlas
			{
				if (gameTextureAtlas == null)
				{
					var texture:Texture = getTexture("AtlasTextureGame");
					var xml:XML = XML(new AtlasXmlGame());
					gameTextureAtlas=new TextureAtlas(texture, xml);
				}
				
				return gameTextureAtlas;
			}
			
			/**
			 * Returns a texture from this class based on a string key.
			 * 
			 * @param name A key that matches a static constant of Bitmap type.
			 * @return a starling texture.
			 */
			
			public static function getTexture(name:String):Texture
			{
				
				if (gameTextures[name] == undefined)
				{
					
					var bitmap:Bitmap = new Assets[name]();
					gameTextures[name]=Texture.fromBitmap(bitmap);
				}
				
				//trace("Tomando textura!");
				return gameTextures[name];
			}
		}
	}