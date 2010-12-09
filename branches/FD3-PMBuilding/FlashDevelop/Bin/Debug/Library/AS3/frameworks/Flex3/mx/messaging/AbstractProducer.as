﻿package mx.messaging
{
	import flash.errors.IllegalOperationError;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	import mx.logging.Log;
	import mx.messaging.config.ConfigMap;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.errors.InvalidDestinationError;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageAckEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The AbstractProducer is the base class for the Producer and
	 */
	public class AbstractProducer extends MessageAgent
	{
		/**
		 *  @private
		 */
		private var _connectMsg : CommandMessage;
		/**
		 *  @private
		 */
		private var _currentAttempt : int;
		/**
		 *  @private
		 */
		private var _reconnectTimer : Timer;
		/**
		 *  @private
		 */
		protected var _shouldBeConnected : Boolean;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _autoConnect : Boolean;
		/**
		 *  @private
		 */
		private var _defaultHeaders : Object;
		/**
		 *  @private
		 */
		private var _reconnectAttempts : int;
		/**
		 *  @private
		 */
		private var _reconnectInterval : int;

		/**
		 *  If <code>true</code> the Producer automatically connects to its destination the
		 */
		public function get autoConnect () : Boolean;
		/**
		 *  @private
		 */
		public function set autoConnect (value:Boolean) : void;
		/**
		 *  The default headers to apply to messages sent by the Producer.
		 */
		public function get defaultHeaders () : Object;
		/**
		 *  @private
		 */
		public function set defaultHeaders (value:Object) : void;
		/**
		 *  The number of reconnect attempts that the Producer makes in the event
		 */
		public function get reconnectAttempts () : int;
		/**
		 *  @private
		 */
		public function set reconnectAttempts (value:int) : void;
		/**
		 *  The number of milliseconds between reconnect attempts.
		 */
		public function get reconnectInterval () : int;
		/**
		 *  @private
		 */
		public function set reconnectInterval (value:int) : void;

		/**
		 * @private
		 */
		public function AbstractProducer ();
		/**
		 *  @private
		 */
		public function acknowledge (ackMsg:AcknowledgeMessage, msg:IMessage) : void;
		/**
		 *  @private
		 */
		public function fault (errMsg:ErrorMessage, msg:IMessage) : void;
		/**
		 *  @private
		 */
		public function channelDisconnectHandler (event:ChannelEvent) : void;
		/**
		 *  @private
		 */
		public function channelFaultHandler (event:ChannelFaultEvent) : void;
		/**
		 *  Disconnects the Producer from its remote destination.
		 */
		public function disconnect () : void;
		/**
		 *  Connects the Producer to its target destination.
		 */
		public function connect () : void;
		/**
		 *  Sends the specified message to its destination.
		 */
		public function send (message:IMessage) : void;
		/**
		 *  @private
		 */
		function internalFault (errMsg:ErrorMessage, msg:IMessage, routeToStore:Boolean = true, ignoreDisconnectBarrier:Boolean = false) : void;
		/**
		 *  @private
		 */
		protected function reconnect (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		protected function startReconnectTimer () : void;
		/**
		 * @private 
		 */
		protected function stopReconnectTimer () : void;
		/**
		 *  @private
		 */
		private function buildConnectErrorMessage () : ErrorMessage;
		/**
		 *  @private
		 */
		private function buildConnectMessage () : CommandMessage;
	}
}