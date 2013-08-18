﻿package fl.video
{
	/**
	 * The VideoState class provides constant values for the read-only <code>FLVPlayback.state</code> and
	 */
	public class VideoState
	{
		/**
		 * The video player is in the disconnected state.
		 */
		public static const DISCONNECTED : String = "disconnected";
		/**
		 * The video player is in the stopped state.
		 */
		public static const STOPPED : String = "stopped";
		/**
		 * The video player is in the playing state.
		 */
		public static const PLAYING : String = "playing";
		/**
		 * The video player is in the paused state.
		 */
		public static const PAUSED : String = "paused";
		/**
		 * The video player is in the buffering state. 
		 */
		public static const BUFFERING : String = "buffering";
		/**
		 * The video player is in the loading state. 
		 */
		public static const LOADING : String = "loading";
		/**
		 * The video player is in the connection error state.
		 */
		public static const CONNECTION_ERROR : String = "connectionError";
		/**
		 * The video player is in the rewinding state.
		 */
		public static const REWINDING : String = "rewinding";
		/**
		 * The video player is in the seeking state.
		 */
		public static const SEEKING : String = "seeking";
		/**
		 * The video player is in the resizing state.
		 */
		public static const RESIZING : String = "resizing";
		/**
		 * The video player is in the execQueuedCmd state.  
		 */
		static var EXEC_QUEUED_CMD : String;

	}
}