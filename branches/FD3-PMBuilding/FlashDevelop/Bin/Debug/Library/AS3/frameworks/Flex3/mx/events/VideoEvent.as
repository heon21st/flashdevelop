﻿package mx.events
{
	import flash.events.Event;
	import mx.core.mx_internal;

	/**
	 *  The VideoEvent class represents the event object passed to the event listener for 
	 */
	public class VideoEvent extends Event
	{
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public static const BUFFERING : String = "buffering";
		/**
		 *  The <code>VideoEvent.CLOSE</code> constant defines the value of the 
		 */
		public static const CLOSE : String = "close";
		/**
		 *  The <code>VideoEvent.COMPLETE</code> constant defines the value of the 
		 */
		public static const COMPLETE : String = "complete";
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public static const CONNECTION_ERROR : String = "connectionError";
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public static const DISCONNECTED : String = "disconnected";
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public static const EXEC_QUEUED_CMD : String = "execQueuedCmd";
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public static const LOADING : String = "loading";
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public static const PAUSED : String = "paused";
		/**
		 *  The <code>VideoEvent.PLAYHEAD_UPDATE</code> constant defines the value of the 
		 */
		public static const PLAYHEAD_UPDATE : String = "playheadUpdate";
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public static const PLAYING : String = "playing";
		/**
		 *  The <code>VideoEvent.READY</code> constant defines the value of the 
		 */
		public static const READY : String = "ready";
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public static const RESIZING : String = "resizing";
		/**
		 *  The <code>VideoEvent.REWIND</code> constant defines the value of the 
		 */
		public static const REWIND : String = "rewind";
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public static const REWINDING : String = "rewinding";
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public static const SEEKING : String = "seeking";
		/**
		 *  The <code>VideoEvent.STATE_CHANGE</code> constant defines the value of the 
		 */
		public static const STATE_CHANGE : String = "stateChange";
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public static const STOPPED : String = "stopped";
		/**
		 *  The location of the playhead of the VideoDisplay control 
		 */
		public var playheadTime : Number;
		/**
		 *  The value of the <code>VideoDisplay.state</code> property 
		 */
		public var state : String;

		/**
		 *  The value of the <code>VideoDisplay.stateResponsive</code> property 
		 */
		public function get stateResponsive () : Boolean;

		/**
		 *  Constructor.
		 */
		public function VideoEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, state:String = null, playheadTime:Number = NaN);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}