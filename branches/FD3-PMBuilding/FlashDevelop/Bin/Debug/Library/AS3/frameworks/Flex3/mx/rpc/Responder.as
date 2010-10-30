﻿package mx.rpc
{
	/**
	 *  This class provides a default implementation <code>mx.rpc.IResponder</code>
	 */
	public class Responder implements IResponder
	{
		/**
		 *  @private
		 */
		private var _resultHandler : Function;
		/**
		 *  @private
		 */
		private var _faultHandler : Function;

		/**
		 *  Constructs an instance of the responder with the specified handlers.
		 */
		public function Responder (result:Function, fault:Function);
		/**
		 *  This method is called by a remote service when the return value has been 
		 */
		public function result (data:Object) : void;
		/**
		 *  This method is called by a service when an error has been received.
		 */
		public function fault (info:Object) : void;
	}
}