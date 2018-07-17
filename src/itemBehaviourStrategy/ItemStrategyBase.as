package itemBehaviourStrategy
{
/**
 * Intefaz, Patron Estrategia
 */
	public interface ItemStrategyBase
	{
		function ejecutar():void;
		function getPattern():int;
		function getPatternPosY():int;
		function getPatternStep():int;
		function getPatternDirection():int;
		function getPatternGap():Number;
		function getPatternGapCount():Number;
		function getPatternChange():Number;
		function getPatternLength():Number;
		function getPatternOnce():Boolean;
		function getPatternPosYstart():Number;
	}
}