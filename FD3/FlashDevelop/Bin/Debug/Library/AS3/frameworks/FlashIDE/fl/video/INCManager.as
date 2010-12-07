﻿package fl.video
{
	import flash.net.NetConnection;

	/**
	 * The INCManager is the interface for classes that create the <code>flash.net.NetConnection</code> 
	 */
	public interface INCManager
	{
		/**
		 * The VideoPlayer object that owns this object.
		 */
		public function get videoPlayer () : VideoPlayer;
		/**
		 * @private (setter)
		 */
		public function set videoPlayer (v:VideoPlayer) : void;
		/**
		 * The time in milliseconds after which attempts to make a connection stop.
		 */
		public function get timeout () : uint;
		/**
		 * @private (setter)
		 */
		public function set timeout (t:uint) : void;
		/**
		 * Reference to the NetConnection object.
		 */
		public function get netConnection () : NetConnection;
		/**
		 * The bandwidth, in bits per second, used to switch between multiple
		 */
		public function get bitrate () : Number;
		/**
		 * @private (setter)
		 */
		public function set bitrate (b:Number) : void;
		/**
		 * The stream name passed into the
		 */
		public function get streamName () : String;
		/**
		 * Whether the URL is for RTMP streaming from a Flash Media Server (FMS)
		 */
		public function get isRTMP () : Boolean;
		/**
		 * Length of the stream, in seconds. After the <code>VideoPlayer.ncConnected()</code> method
		 */
		public function get streamLength () : Number;
		/**
		 * Width of the stream, in pixels.  After the
		 */
		public function get streamWidth () : int;
		/**
		 * Height of the stream, in pixels.  After the
		 */
		public function get streamHeight () : int;

		/**
		 * Called by the VideoPlayer object to ask for a connection to the
		 */
		public function connectToURL (url:String) : Boolean;
		/**
		 * Called by the VideoPlayer object if the connection is
		 */
		public function connectAgain () : Boolean;
		/**
		 * Called by the VideoPlayer object to ask for reconnection
		 */
		public function reconnect () : void;
		/**
		 * Called by any helper object doing a task for the
		 */
		public function helperDone (helper:Object, success:Boolean) : void;
		/**
		 * Closes the NetConnection.
		 */
		public function close () : void;
		/**
		 * Gets values of arbitrary properties supported
		 */
		public function getProperty (propertyName:String) : *;
		/**
		 * Sets values of arbitrary properties supported
		 */
		public function setProperty (propertyName:String, value:*) : void;
	}
}