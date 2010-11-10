﻿package fl.events
{
	import flash.events.Event;

	/**
	 * The ColorPickerEvent class defines events that are associated with the ColorPicker component.
	 */
	public class ColorPickerEvent extends Event
	{
		/**
		 * Defines the value of the <code>type</code> property for an <code>itemRollOut</code> 
		 */
		public static const ITEM_ROLL_OUT : String = "itemRollOut";
		/**
		 * Defines the value of the <code>type</code> property for an <code>itemRollOver</code>
		 */
		public static const ITEM_ROLL_OVER : String = "itemRollOver";
		/**
		 * Defines the value of the <code>type</code> property of an <code>enter</code>
		 */
		public static const ENTER : String = "enter";
		/**
		 * Defines the value of the <code>type</code> property of the <code>change</code>
		 */
		public static const CHANGE : String = "change";
		/**
		 * @private (protected)
		 */
		protected var _color : uint;

		/**
		 * Gets the color value that is associated with the event.
		 */
		public function get color () : uint;

		/**
		 * Creates a new ColorPickerEvent object.
		 */
		public function ColorPickerEvent (type:String, color:uint);
		/**
		 * Returns a string that contains all the properties of the ColorPickerEvent object.
		 */
		public function toString () : String;
		/**
		 * Creates a copy of the ColorPickerEvent object and sets the value of each parameter to match
		 */
		public function clone () : Event;
	}
}