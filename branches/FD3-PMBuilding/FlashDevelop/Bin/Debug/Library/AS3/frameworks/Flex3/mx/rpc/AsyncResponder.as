﻿package mx.rpc
{
	/**
	 * This class provides an RPC specific implementation of <code>mx.rpc.IResponder</code>.
	 */
	public class AsyncResponder implements IResponder
	{
		private var _resultHandler : Function;
		private var _faultHandler : Function;
		private var _token : Object;

		/**
		 *  Constructs an instance of the responder with the specified data and 
		 */
		public function AsyncResponder (result:Function, fault:Function, token:Object = null);
		/**
		 *  This method is called by a service when the return value has been 
		 */
		public function result (data:Object) : void;
		/**
		 *  This method is called by a service when an error has been received.
		 */
		public function fault (info:Object) : void;
	}
}