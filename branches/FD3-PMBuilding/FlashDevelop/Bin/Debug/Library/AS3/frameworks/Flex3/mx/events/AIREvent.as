﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The AIREvent class represents the event object passed to
	 */
	public class AIREvent extends Event
	{
		/**
		 *  The AIREvent.APPLICATION_ACTIVATE constant defines the value of the
		 */
		public static const APPLICATION_ACTIVATE : String = "applicationActivate";
		/**
		 *  The AIREvent.APPLICATION_DEACTIVATE constant defines the value of the
		 */
		public static const APPLICATION_DEACTIVATE : String = "applicationDeactivate";
		/**
		 *  The AIREvent.WINDOW_ACTIVATE constant defines the value of the
		 */
		public static const WINDOW_ACTIVATE : String = "windowActivate";
		/**
		 *  The AIREvent.WINDOW_DEACTIVATE constant defines the value of the
		 */
		public static const WINDOW_DEACTIVATE : String = "windowDeactivate";
		/**
		 *  The AIREvent.WINDOW_COMPLETE constant defines the value of the
		 */
		public static const WINDOW_COMPLETE : String = "windowComplete";

		/**
		 *  Constructor.
		 */
		public function AIREvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}