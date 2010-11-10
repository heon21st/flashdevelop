﻿package mx.messaging
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;

	/**
	 *  Dispatched when a message is received by the Consumer.
	 */
	[Event(name="message", type="mx.messaging.events.MessageEvent")] 

	/**
	 *  A Consumer subscribes to a destination to receive messages.
	 */
	public class Consumer extends AbstractConsumer
	{
		/**
		 *  @private
		 */
		private var _selector : String;
		/**
		 *  @private
		 */
		private var _subtopic : String;

		/**
		 *  The selector for the Consumer. 
		 */
		public function get selector () : String;
		/**
		 *  @private
		 */
		public function set selector (value:String) : void;
		/**
		 *  Provides access to the subtopic for the remote destination that the MessageAgent uses.
		 */
		public function get subtopic () : String;
		/**
		 *  Setting the subtopic when the Consumer is connected and
		 */
		public function set subtopic (value:String) : void;

		/**
		 *  Constructs a Consumer.
		 */
		public function Consumer (messageType:String = "flex.messaging.messages.AsyncMessage");
		/**
		 * @private
		 */
		protected function internalSend (message:IMessage, waitForClientId:Boolean = true) : void;
	}
}