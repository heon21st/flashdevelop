﻿package mx.events
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 *  Represents events that are dispatched when a the child of a control
	 */
	public class ChildExistenceChangedEvent extends Event
	{
		/**
		 *  The <code>ChildExistenceChangedEvent.CHILD_ADD</code> constant 
		 */
		public static const CHILD_ADD : String = "childAdd";
		/**
		 *  The <code>ChildExistenceChangedEvent.CHILD_REMOVE</code> constant 
		 */
		public static const CHILD_REMOVE : String = "childRemove";
		/**
		 *  The <code>ChildExistenceChangedEvent.OVERLAY_CREATED</code> constant 
		 */
		public static const OVERLAY_CREATED : String = "overlayCreated";
		/**
		 *  Reference to the child object that was created or destroyed.
		 */
		public var relatedObject : DisplayObject;

		/**
		 *  Constructor.
		 */
		public function ChildExistenceChangedEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, relatedObject:DisplayObject = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}