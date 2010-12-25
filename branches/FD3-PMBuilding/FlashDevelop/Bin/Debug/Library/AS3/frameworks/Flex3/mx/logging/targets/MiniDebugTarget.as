﻿package mx.logging.targets
{
	import flash.net.LocalConnection;
	import flash.events.StatusEvent;
	import flash.events.SecurityErrorEvent;
	import mx.core.mx_internal;

	/**
	 *  Provides a logger target that outputs to a <code>LocalConnection</code>,
	 */
	public class MiniDebugTarget extends LineFormattedTarget
	{
		/**
		 *  @private
		 */
		private var _lc : LocalConnection;
		/**
		 *  @private
		 */
		private var _method : String;
		/**
		 *  @private
		 */
		private var _connection : String;

		/**
		 *  Constructor.
		 */
		public function MiniDebugTarget (connection:String = "_mdbtrace", method:String = "trace");
		/**
		 *  @private
		 */
		function internalLog (message:String) : void;
		private function onStatus (e:StatusEvent) : void;
		private function onSecurityError (e:SecurityErrorEvent) : void;
	}
}