﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The SliderEvent class represents the event object passed to 
	 */
	public class SliderEvent extends Event
	{
		/**
		 *  The <code>SliderEvent.CHANGE</code> constant defines the value of the 
		 */
		public static const CHANGE : String = "change";
		/**
		 *  The <code>SliderEvent.THUMB_DRAG</code> constant defines the value of the 
		 */
		public static const THUMB_DRAG : String = "thumbDrag";
		/**
		 *  The <code>SliderEvent.THUMB_PRESS</code> constant defines the value of the 
		 */
		public static const THUMB_PRESS : String = "thumbPress";
		/**
		 *  The <code>SliderEvent.THUMB_RELEASE</code> constant defines the value of the 
		 */
		public static const THUMB_RELEASE : String = "thumbRelease";
		/**
		 *  Specifies whether the slider track or a slider thumb was pressed. 
		 */
		public var clickTarget : String;
		/**
		 *  If the event was triggered by a key press, the keycode for the key.
		 */
		public var keyCode : int;
		/**
		 *  The zero-based index of the thumb whose position has changed.
		 */
		public var thumbIndex : int;
		/**
		 *  Indicates the type of input action. 
		 */
		public var triggerEvent : Event;
		/**
		 *  The new value of the slider.
		 */
		public var value : Number;

		/**
		 *  Constructor.
		 */
		public function SliderEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, thumbIndex:int = -1, value:Number = NaN, triggerEvent:Event = null, clickTarget:String = null, keyCode:int = -1);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}