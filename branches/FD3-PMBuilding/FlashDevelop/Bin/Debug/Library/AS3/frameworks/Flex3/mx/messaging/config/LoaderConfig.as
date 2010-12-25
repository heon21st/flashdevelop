﻿package mx.messaging.config
{
	import mx.core.mx_internal;

	/**
	 *  This class acts as a context for the messaging framework so that it
	 */
	public class LoaderConfig
	{
		/**
		 *  @private
		 */
		static var _parameters : Object;
		/**
		 *  @private
		 */
		static var _url : String;

		/**
		 *  If the LoaderConfig has been initialized, this
		 */
		public static function get parameters () : Object;
		/**
		 *  If the LoaderConfig has been initialized, this
		 */
		public static function get url () : String;

		/**
		 *  Constructor.
		 */
		public function LoaderConfig ();
	}
}