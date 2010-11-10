﻿package mx.formatters
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The DateBase class contains the localized string information
	 */
	public class DateBase
	{
		/**
		 *  @private
		 */
		private static var initialized : Boolean;
		/**
		 *  @private
		 */
		private static var _resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private static var _dayNamesLong : Array;
		/**
		 *  @private
		 */
		private static var dayNamesLongOverride : Array;
		/**
		 *  @private
		 */
		private static var _dayNamesShort : Array;
		/**
		 *  @private
		 */
		private static var dayNamesShortOverride : Array;
		/**
		 *  @private
		 */
		private static var _monthNamesLong : Array;
		/**
		 *  @private
		 */
		private static var monthNamesLongOverride : Array;
		/**
		 *  @private
		 */
		private static var _monthNamesShort : Array;
		/**
		 *  @private
		 */
		private static var monthNamesShortOverride : Array;
		/**
		 *  @private
		 */
		private static var _timeOfDay : Array;
		/**
		 *  @private
		 */
		private static var timeOfDayOverride : Array;

		/**
		 *  @private
		 */
		private static function get resourceManager () : IResourceManager;
		/**
		 *  Long format of day names.
		 */
		public static function get dayNamesLong () : Array;
		/**
		 *  @private
		 */
		public static function set dayNamesLong (value:Array) : void;
		/**
		 *  Short format of day names.
		 */
		public static function get dayNamesShort () : Array;
		/**
		 *  @private
		 */
		public static function set dayNamesShort (value:Array) : void;
		/**
		 *  @private
		 */
		static function get defaultStringKey () : Array;
		/**
		 *  Long format of month names.
		 */
		public static function get monthNamesLong () : Array;
		/**
		 *  @private
		 */
		public static function set monthNamesLong (value:Array) : void;
		/**
		 *  Short format of month names.
		 */
		public static function get monthNamesShort () : Array;
		/**
		 *  @private
		 */
		public static function set monthNamesShort (value:Array) : void;
		/**
		 *  Time of day names.
		 */
		public static function get timeOfDay () : Array;
		/**
		 *  @private
		 */
		public static function set timeOfDay (value:Array) : void;

		/**
		 *  @private
		 */
		private static function initialize () : void;
		/**
		 *  @private
		 */
		private static function static_resourcesChanged () : void;
		/**
		 *  @private
		 */
		static function extractTokenDate (date:Date, tokenInfo:Object) : String;
		/**
		 *  @private
		 */
		private static function setValue (value:Object, key:int) : String;
		/**
		 *  @private
		 */
		private static function static_resourceManager_changeHandler (event:Event) : void;
	}
}