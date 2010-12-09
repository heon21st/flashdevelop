﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  This is an event sent between applications in different security sandboxes to notify listeners
	 */
	public class SandboxMouseEvent extends Event
	{
		/**
		 *  Mouse was clicked somewhere outside your sandbox.
		 */
		public static const CLICK_SOMEWHERE : String = "clickSomewhere";
		/**
		 *  Mouse was double-clicked somewhere outside your sandbox.
		 */
		public static const DOUBLE_CLICK_SOMEWHERE : String = "coubleClickSomewhere";
		/**
		 *  Mouse button was pressed down somewhere outside your sandbox.
		 */
		public static const MOUSE_DOWN_SOMEWHERE : String = "mouseDownSomewhere";
		/**
		 *  Mouse was moved somewhere outside your sandbox.
		 */
		public static const MOUSE_MOVE_SOMEWHERE : String = "mouseMoveSomewhere";
		/**
		 *  Mouse button was released somewhere outside your sandbox.
		 */
		public static const MOUSE_UP_SOMEWHERE : String = "mouseUpSomewhere";
		/**
		 *  Mouse wheel was spun somewhere outside your sandbox.
		 */
		public static const MOUSE_WHEEL_SOMEWHERE : String = "mouseWheelSomewhere";
		/**
		 *  Indicates whether the <code>Alt</code> key was pressed.
		 */
		public var altKey : Boolean;
		/**
		 *  Indicates whether the primary mouse button is pressed (true) or not (false).
		 */
		public var buttonDown : Boolean;
		/**
		 *  Indicates whether the <code>Ctrl</code> key was pressed.
		 */
		public var ctrlKey : Boolean;
		/**
		 *  Indicates whether the <code>Shift</code> key was pressed.
		 */
		public var shiftKey : Boolean;

		/**
		 *  Marshal a SWFBridgeRequest from a remote ApplicationDomain into the current
		 */
		public static function marshal (event:Event) : SandboxMouseEvent;
		/**
		 *  Constructor.
		 */
		public function SandboxMouseEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}