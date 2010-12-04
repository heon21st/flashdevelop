﻿package mx.controls.videoClasses
{
	import flash.net.NetConnection;

	/**
	 *  @private
	 */
	public interface INCManager
	{
		/**
		 *  The bandwidth to be used to switch between multiple streams,
		 */
		public function get bitrate () : Number;
		/**
		 *  @private
		 */
		public function set bitrate (b:Number) : void;
		/**
		 *  Read-only <code>NetConnection</code>.
		 */
		public function get netConnection () : NetConnection;
		/**
		 *  Read-only height of stream.
		 */
		public function get streamHeight () : Number;
		/**
		 *  Read-only length of stream.
		 */
		public function get streamLength () : Number;
		/**
		 *  Read-only stream name to be passed into <code>NetStream.play</code>.
		 */
		public function get streamName () : String;
		/**
		 *  Read-only width of stream.
		 */
		public function get streamWidth () : Number;
		/**
		 *  Timeout after which we give up on connection, in milliseconds.
		 */
		public function get timeout () : uint;
		/**
		 *  @private
		 */
		public function set timeout (t:uint) : void;
		/**
		 *  The <code>VideoPlayer</code> object which owns this object.
		 */
		public function get videoPlayer () : VideoPlayer;
		/**
		 *  @private
		 */
		public function set videoPlayer (v:VideoPlayer) : void;

		/**
		 *  Called by <code>VideoPlayer</code> to ask for connection to URL.
		 */
		public function connectToURL (url:String) : Boolean;
		/**
		 *  Called by <code>VideoPlayer</code> if connection successfully
		 */
		public function connectAgain () : Boolean;
		/**
		 *  Called by <code>VideoPlayer</code> to ask for reconnection
		 */
		public function reconnect () : void;
		/**
		 *  Close the NetConnection
		 */
		public function close () : void;
		/**
		 *  Whether URL is for RTMP streaming from Flash Communication
		 */
		public function isRTMP () : Boolean;
	}
}