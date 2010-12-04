﻿package mx.messaging.channels
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.utils.ByteArray;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.messaging.FlexClient;
	import mx.messaging.config.ConfigMap;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import flash.net.ObjectEncoding;
	import flash.utils.ByteArray;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.Channel;
	import mx.messaging.channels.StreamingConnectionHandler;
	import mx.messaging.channels.amfx.AMFXDecoder;
	import mx.messaging.channels.amfx.AMFXContext;
	import mx.messaging.messages.IMessage;

	/**
	 *  The StreamingHTTPChannel class provides support for messaging and
	 */
	public class StreamingHTTPChannel extends HTTPChannel
	{
		/**
		 * Helper class used by the channel to establish a streaming HTTP connection
		 */
		private var streamingConnectionHandler : StreamingConnectionHandler;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  @private
		 */
		public function set pollingEnabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set pollingInterval (value:Number) : void;
		/**
		 *  @private
		 */
		function get realtime () : Boolean;

		/**
		 *  Creates an new StreamingHTTPChannel instance.
		 */
		public function StreamingHTTPChannel (id:String = null, uri:String = null);
		/**
		 *  Polling is not supported by this channel.
		 */
		public function poll () : void;
		/**
		 *  @private
		 */
		protected function connectFailed (event:ChannelFaultEvent) : void;
		/**
		 *  @private
		 */
		protected function internalDisconnect (rejected:Boolean = false) : void;
		/**
		 *  @private
		 */
		protected function internalPingComplete (msg:AsyncMessage) : void;
		/**
		 *  If the streaming connection receives an open event the channel is setup
		 */
		private function streamOpenHandler (event:Event) : void;
		/**
		 *  A complete event indicates that the streaming connection has been closed by the server.
		 */
		private function streamCompleteHandler (event:Event) : void;
		/**
		 *  Handles HTTP status events dispatched by the streaming connection.
		 */
		private function streamHttpStatusHandler (event:HTTPStatusEvent) : void;
		/**
		 *  Handles IO error events dispatched by the streaming connection.
		 */
		private function streamIoErrorHandler (event:IOErrorEvent) : void;
		/**
		 *  Handles security error events dispatched by the streaming connection.
		 */
		private function streamSecurityErrorHandler (event:SecurityErrorEvent) : void;
		/**
		 *  Handle status events dispatched by the streaming connection.
		 */
		private function streamStatusHandler (event:StatusEvent) : void;
	}
	/**
	 *  A helper class that is used by the streaming channels to open an internal
	 */
	internal class StreamingHTTPConnectionHandler extends StreamingConnectionHandler
	{
		/**
		 *  Creates an new StreamingHTTPConnectionHandler instance.
		 */
		public function StreamingHTTPConnectionHandler (channel:Channel, log:ILogger);
		/**
		 *  Used by the streamProgressHandler to read an AMFX encoded message.
		 */
		protected function readMessage () : IMessage;
	}
}