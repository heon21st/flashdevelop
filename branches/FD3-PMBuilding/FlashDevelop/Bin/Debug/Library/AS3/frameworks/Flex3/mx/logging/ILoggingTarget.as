﻿package mx.logging
{
	/**
	 *  All logger target implementations within the logging framework
	 */
	public interface ILoggingTarget
	{
		/**
		 *  In addition to the <code>level</code> setting, filters are used to
		 */
		public function get filters () : Array;
		/**
		 *  @private
		 */
		public function set filters (value:Array) : void;
		/**
		 *  Provides access to the level this target is currently set at.
		 */
		public function get level () : int;
		/**
		 *  @private
		 */
		public function set level (value:int) : void;

		/**
		 *  Sets up this target with the specified logger.
		 */
		public function addLogger (logger:ILogger) : void;
		/**
		 *  Stops this target from receiving events from the specified logger.
		 */
		public function removeLogger (logger:ILogger) : void;
	}
}