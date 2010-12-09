﻿package mx.logging
{
	import flash.events.IEventDispatcher;

	/**
	 *  All loggers within the logging framework must implement this interface.
	 */
	public interface ILogger extends IEventDispatcher
	{
		/**
		 *  The category value for the logger.
		 */
		public function get category () : String;

		/**
		 *  Logs the specified data at the given level.
		 */
		public function log (level:int, message:String, ...rest) : void;
		/**
		 *  Logs the specified data using the <code>LogEventLevel.DEBUG</code>
		 */
		public function debug (message:String, ...rest) : void;
		/**
		 *  Logs the specified data using the <code>LogEventLevel.ERROR</code>
		 */
		public function error (message:String, ...rest) : void;
		/**
		 *  Logs the specified data using the <code>LogEventLevel.FATAL</code> 
		 */
		public function fatal (message:String, ...rest) : void;
		/**
		 *  Logs the specified data using the <code>LogEvent.INFO</code> level.
		 */
		public function info (message:String, ...rest) : void;
		/**
		 *  Logs the specified data using the <code>LogEventLevel.WARN</code> level.
		 */
		public function warn (message:String, ...rest) : void;
	}
}