﻿package mx.events
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import mx.core.DragSource;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;

	/**
	 *  An event sent between DragManagers that are 
	 */
	public class InterDragManagerEvent extends DragEvent
	{
		/**
		 *	Dispatch a DragEvent event to a target in another ApplicationDomain.
		 */
		public static const DISPATCH_DRAG_EVENT : String = "dispatchDragEvent";
		/**
		 *  The potential drop target in the other ApplicationDomain
		 */
		public var dropTarget : DisplayObject;
		/**
		 *  The event type for the DragEvent to be used
		 */
		public var dragEventType : String;

		/**
		 *  Constructor.
		 */
		public function InterDragManagerEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, localX:Number = NaN, localY:Number = NaN, relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, delta:int = 0, dropTarget:DisplayObject = null, dragEventType:String = null, dragInitiator:IUIComponent = null, dragSource:DragSource = null, action:String = null, draggedItem:Object = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}