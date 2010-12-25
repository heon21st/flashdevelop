﻿package mx.managers
{
	import mx.core.IUIComponent;
	import mx.core.Singleton;
	import mx.core.mx_internal;

	/**
	 *  The skin for the busy cursor
	 */
	[Style(name="busyCursor", type="Class", inherit="no")] 

	/**
	 *  The CursorManager class controls a prioritized list of cursors,
	 */
	public class CursorManager
	{
		/**
		 *  Constant that is the value of <code>currentCursorID</code> property
		 */
		public static const NO_CURSOR : int = 0;
		/**
		 *  @private
		 */
		private static var implClassDependency : CursorManagerImpl;
		/**
		 *  @private
		 */
		private static var _impl : ICursorManager;

		/**
		 *  @private
		 */
		private static function get impl () : ICursorManager;
		/**
		 *  ID of the current custom cursor,
		 */
		public static function get currentCursorID () : int;
		/**
		 *  @private
		 */
		public static function set currentCursorID (value:int) : void;
		/**
		 *  The x offset of the custom cursor, in pixels,
		 */
		public static function get currentCursorXOffset () : Number;
		/**
		 *  @private
		 */
		public static function set currentCursorXOffset (value:Number) : void;
		/**
		 *  The y offset of the custom cursor, in pixels,
		 */
		public static function get currentCursorYOffset () : Number;
		/**
		 *  @private
		 */
		public static function set currentCursorYOffset (value:Number) : void;

		/**
		 *  Each mx.core.Window instance in an AIR application has its own CursorManager instance. 
		 */
		public static function getInstance () : ICursorManager;
		/**
		 *  Makes the cursor visible.
		 */
		public static function showCursor () : void;
		/**
		 *  Makes the cursor invisible.
		 */
		public static function hideCursor () : void;
		/**
		 *  Creates a new cursor and sets an optional priority for the cursor.
		 */
		public static function setCursor (cursorClass:Class, priority:int = 2, xOffset:Number = 0, yOffset:Number = 0) : int;
		/**
		 *  Removes a cursor from the cursor list.
		 */
		public static function removeCursor (cursorID:int) : void;
		/**
		 *  Removes all of the cursors from the cursor list
		 */
		public static function removeAllCursors () : void;
		/**
		 *  Displays the busy cursor.
		 */
		public static function setBusyCursor () : void;
		/**
		 *  Removes the busy cursor from the cursor list.
		 */
		public static function removeBusyCursor () : void;
		/**
		 *  @private
		 */
		static function registerToUseBusyCursor (source:Object) : void;
		/**
		 *  @private
		 */
		static function unRegisterToUseBusyCursor (source:Object) : void;
	}
}