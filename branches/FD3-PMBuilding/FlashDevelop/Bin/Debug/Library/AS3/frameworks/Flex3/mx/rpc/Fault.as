﻿package mx.rpc
{
	/**
	 * The Fault class represents a fault in a remote procedure call (RPC) service
	 */
	public class Fault extends Error
	{
		/**
		 * The raw content of the fault (if available), such as an HTTP response
		 */
		public var content : Object;
		/**
		 * The cause of the fault. The value will be null if the cause is
		 */
		public var rootCause : Object;
		/**
		 * @private
		 */
		protected var _faultCode : String;
		/**
		 * @private
		 */
		protected var _faultString : String;
		/**
		 * @private
		 */
		protected var _faultDetail : String;

		/**
		 * A simple code describing the fault.
		 */
		public function get faultCode () : String;
		/**
		 * Any extra details of the fault.
		 */
		public function get faultDetail () : String;
		/**
		 * Text description of the fault.
		 */
		public function get faultString () : String;

		/**
		 * Creates a new Fault object.
		 */
		public function Fault (faultCode:String, faultString:String, faultDetail:String = null);
		/**
		 * Returns the string representation of a Fault object.
		 */
		public function toString () : String;
	}
}