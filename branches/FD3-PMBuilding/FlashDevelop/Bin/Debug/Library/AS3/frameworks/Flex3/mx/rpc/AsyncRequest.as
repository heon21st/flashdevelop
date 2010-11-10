﻿package mx.rpc
{
	import mx.core.mx_internal;
	import mx.messaging.Producer;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;

	/**
	 *  The AsyncRequest class provides an abstraction of messaging for RPC call invocation.
	 */
	public class AsyncRequest extends mx.messaging.Producer
	{
		/**
		 *  manages a list of all pending requests.  each request must implement
		 */
		private var _pendingRequests : Object;

		/**
		 *  Constructs a new asynchronous request.
		 */
		public function AsyncRequest ();
		/**
		 *  Delegates to the results to responder
		 */
		public function acknowledge (ack:AcknowledgeMessage, msg:IMessage) : void;
		/**
		 *  Delegates to the fault to responder
		 */
		public function fault (errMsg:ErrorMessage, msg:IMessage) : void;
		/**
		 * Returns <code>true</code> if there are any pending requests for the passed in message.
		 */
		public function hasPendingRequestForMessage (msg:IMessage) : Boolean;
		/**
		 *  Dispatches the asynchronous request and stores the responder to call
		 */
		public function invoke (msg:IMessage, responder:IResponder) : void;
	}
}