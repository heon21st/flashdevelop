﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  Represents events that are dispatched by the ScrollBar class.
	 */
	public class ScrollEvent extends Event
	{
		/**
		 *  The <code>ScrollEvent.SCROLL</code> constant defines the value of the 
		 */
		public static const SCROLL : String = "scroll";
		/**
		 *  The change in the scroll position value that resulted from 
		 */
		public var delta : Number;
		/**
		 *  Provides the details of the scroll activity.
		 */
		public var detail : String;
		/**
		 *  The direction of motion.
		 */
		public var direction : String;
		/**
		 *  The new scroll position.
		 */
		public var position : Number;

		/**
		 *  Constructor.
		 */
		public function ScrollEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, detail:String = null, position:Number = NaN, direction:String = null, delta:Number = NaN);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}