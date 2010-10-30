﻿package mx.core
{
	/**
	 *  @private
	 */
	public class Singleton
	{
		/**
		 *  @private
		 */
		private static var classMap : Object;

		/**
		 *  @private
		 */
		public static function registerClass (interfaceName:String, clazz:Class) : void;
		/**
		 *  @private
		 */
		public static function getClass (interfaceName:String) : Class;
		/**
		 *  @private
		 */
		public static function getInstance (interfaceName:String) : Object;
	}
}