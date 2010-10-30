﻿package fl.events
{
	import flash.events.Event;

	/**
	 * The ComponentEvent class defines events that are associated with the UIComponent class.
	 */
	public class ComponentEvent extends Event
	{
		/**
		 * Defines the value of the <code>type</code> property of a <code>buttonDown</code>
		 */
		public static const BUTTON_DOWN : String = "buttonDown";
		/**
		 * Defines the value of the <code>type</code> property of a <code>labelChange</code>
		 */
		public static const LABEL_CHANGE : String = "labelChange";
		/**
		 * Defines the value of the <code>type</code> property of a <code>hide</code>
		 */
		public static const HIDE : String = "hide";
		/**
		 * Defines the value of the <code>type</code> property of a <code>show</code> event
		 */
		public static const SHOW : String = "show";
		/**
		 * Defines the value of the <code>type</code> property of a <code>resize</code> 
		 */
		public static const RESIZE : String = "resize";
		/**
		 * Defines the value of the <code>type</code> property of a <code>move</code>
		 */
		public static const MOVE : String = "move";
		/**
		 * Defines the value of the <code>type</code> property of an <code>enter</code>
		 */
		public static const ENTER : String = "enter";

		/**
		 * Creates a new ComponentEvent object that contains information about a component 
		 */
		public function ComponentEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		/**
		 * Returns a string that contains all the properties of the ComponentEvent object. The 
		 */
		public function toString () : String;
		/**
		 * Creates a copy of the ComponentEvent object and sets the value of each parameter to
		 */
		public function clone () : Event;
	}
}