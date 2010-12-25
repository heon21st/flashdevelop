﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The CuePointEvent class represents the event object passed to the event listener for 
	 */
	public class CuePointEvent extends Event
	{
		/**
		 *  The <code>CuePointEvent.CUE_POINT</code> constant defines the value of the 
		 */
		public static const CUE_POINT : String = "cuePoint";
		/**
		 *  The name of the cue point that caused the event.
		 */
		public var cuePointName : String;
		/**
		 *  The time of the cue point that caused the event, in seconds.
		 */
		public var cuePointTime : Number;
		/**
		 *  The string <code>"actionscript"</code>.
		 */
		public var cuePointType : String;

		/**
		 *  Constructor.
		 */
		public function CuePointEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, cuePointName:String = null, cuePointTime:Number = NaN, cuePointType:String = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}