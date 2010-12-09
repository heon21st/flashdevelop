﻿package mx.rpc.remoting
{
	import mx.core.mx_internal;
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.utils.ObjectUtil;

	/**
	 * An Operation used specifically by RemoteObjects. An Operation is an individual method on a service.
	 */
	public class Operation extends AbstractOperation
	{
		/**
		 * An ordered list of the names of the arguments to pass to a method invocation.  Since the arguments object is
		 */
		public var argumentNames : Array;
		private var _makeObjectsBindableSet : Boolean;

		/**
		 * When this value is true, anonymous objects returned are forced to bindable objects.
		 */
		public function get makeObjectsBindable () : Boolean;
		public function set makeObjectsBindable (b:Boolean) : void;

		/**
		 * Creates a new Operation. This is usually done directly automatically by the RemoteObject
		 */
		public function Operation (remoteObject:AbstractService = null, name:String = null);
		/**
		 * @inheritDoc
		 */
		public function send (...args:Array) : AsyncToken;
	}
}