﻿package mx.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import mx.core.IRawChildrenContainer;

	/**
	 *  The DisplayUtil utility class is an all-static class with utility methods
	 */
	public class DisplayUtil
	{
		/**
		 *  Recursively calls the specified function on each node in the specified DisplayObject's tree,
		 */
		public static function walkDisplayObjects (displayObject:DisplayObject, callbackFunction:Function) : void;
	}
}