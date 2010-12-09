﻿package mx.rpc
{
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.events.AbstractEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.InvokeEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	import mx.utils.StringUtil;

	/**
	 * An invoker is an object that actually executes a remote procedure call (RPC).
	 */
	public class AbstractInvoker extends EventDispatcher
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  Event dispatched for binding when the <code>result</code> property
		 */
		static const BINDING_RESULT : String = "resultForBinding";
		/**
		 * @private
		 */
		local var activeCalls : ActiveCalls;
		/**
		 * @private
		 */
		local var _responseHeaders : Array;
		/**
		 * @private
		 */
		local var _result : Object;
		/**
		 * @private
		 */
		local var _makeObjectsBindable : Boolean;
		/**
		 * @private
		 */
		private var _asyncRequest : AsyncRequest;
		/**
		 * @private
		 */
		private var _log : ILogger;

		/**
		 *  The result of the last invocation.
		 */
		public function get lastResult () : Object;
		/**
		 * When this value is true, anonymous objects returned are forced to bindable objects.
		 */
		public function get makeObjectsBindable () : Boolean;
		public function set makeObjectsBindable (b:Boolean) : void;
		/**
		 * @private
		 */
		function get asyncRequest () : AsyncRequest;
		/**
		 * @private
		 */
		function set asyncRequest (req:AsyncRequest) : void;

		/**
		 *  @private
		 */
		public function AbstractInvoker ();
		/**
		 *  Cancels the last service invocation or an invokation with the specified ID.
		 */
		public function cancel (id:String = null) : AsyncToken;
		/**
		 *  Sets the <code>result</code> property of the invoker to <code>null</code>.
		 */
		public function clearResult (fireBindingEvent:Boolean = true) : void;
		/**
		 *  This method is overridden in subclasses to redirect the event to another
		 */
		function dispatchRpcEvent (event:AbstractEvent) : void;
		/**
		 *  Take the MessageAckEvent and take the result, store it, and broadcast out
		 */
		function resultHandler (event:MessageEvent) : void;
		/**
		 *  Take the fault and convert it into a rpc.events.FaultEvent.
		 */
		function faultHandler (event:MessageFaultEvent) : void;
		/**
		 * Return the id for the NetworkMonitor.
		 */
		function getNetmonId () : String;
		/**
		 * @private
		 */
		function invoke (message:IMessage, token:AsyncToken = null) : AsyncToken;
		/**
		 * Find the matching call object and pass it back.
		 */
		function preHandle (event:MessageEvent) : AsyncToken;
		/**
		 * @private
		 */
		function processFault (message:IMessage, token:AsyncToken) : Boolean;
		/**
		 * @private
		 */
		function processResult (message:IMessage, token:AsyncToken) : Boolean;
	}
}