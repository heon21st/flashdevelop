﻿package mx.logging.errors
{
	/**
	 *  This error is thrown when a filter specified for a target
	 */
	public class InvalidFilterError extends Error
	{
		/**
		 *  Constructor.
		 */
		public function InvalidFilterError (message:String);
		/**
		 *  Returns the messge as a String.
		 */
		public function toString () : String;
	}
}