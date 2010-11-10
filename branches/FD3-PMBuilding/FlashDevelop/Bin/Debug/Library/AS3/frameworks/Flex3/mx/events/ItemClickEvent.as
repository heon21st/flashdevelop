﻿package mx.events
{
	import flash.display.InteractiveObject;
	import flash.events.Event;

	/**
	 *  Represents events that are dispatched when a navigation item on a navigator bar,
	 */
	public class ItemClickEvent extends Event
	{
		/**
		 *  The <code>ItemClickEvent.ITEM_CLICK</code> constant defines the value of the 
		 */
		public static const ITEM_CLICK : String = "itemClick";
		/**
		 *  The index of the associated navigation item.
		 */
		public var index : int;
		/**
		 *  The item in the data provider of the associated navigation item.
		 */
		public var item : Object;
		/**
		 *  The label of the associated navigation item.
		 */
		public var label : String;
		/**
		 *  The child object that generated the event; for example,
		 */
		public var relatedObject : InteractiveObject;

		/**
		 *  Constructor.
		 */
		public function ItemClickEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, label:String = null, index:int = -1, relatedObject:InteractiveObject = null, item:Object = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}