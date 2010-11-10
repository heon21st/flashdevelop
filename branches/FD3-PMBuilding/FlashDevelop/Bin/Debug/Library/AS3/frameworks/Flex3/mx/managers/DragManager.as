﻿package mx.managers
{
	import flash.events.MouseEvent;
	import mx.automation.Automation;
	import mx.core.DragSource;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.Singleton;
	import mx.core.mx_internal;
	import mx.managers.dragClasses.DragProxy;

	/**
	 *  Cursor displayed during a copy operation.
	 */
	[Style(name="copyCursor", type="Class", inherit="no")] 
	/**
	 *  Skin used to draw the default drag image, 
	 */
	[Style(name="defaultDragImageSkin", type="Class", inherit="no")] 
	/**
	 *  Cursor displayed during a link operation.
	 */
	[Style(name="linkCursor", type="Class", inherit="no")] 
	/**
	 *  Cursor displayed during a move operation.
	 */
	[Style(name="moveCursor", type="Class", inherit="no")] 
	/**
	 *  Cursor displayed for a reject operation.
	 */
	[Style(name="rejectCursor", type="Class", inherit="no")] 

	/**
	 *  The DragManager class manages drag and drop operations, which let you 
	 */
	public class DragManager
	{
		/**
		 *  Constant that specifies that the type of drag action is "none".
		 */
		public static const NONE : String = "none";
		/**
		 *  Constant that specifies that the type of drag action is "copy".
		 */
		public static const COPY : String = "copy";
		/**
		 *  Constant that specifies that the type of drag action is "move".
		 */
		public static const MOVE : String = "move";
		/**
		 *  Constant that specifies that the type of drag action is "link".
		 */
		public static const LINK : String = "link";
		/**
		 *  @private
		 */
		private static var implClassDependency : DragManagerImpl;
		/**
		 *  @private
		 */
		private static var _impl : IDragManager;

		/**
		 *  @private
		 */
		private static function get impl () : IDragManager;
		/**
		 *  @private
		 */
		static function get dragProxy () : DragProxy;
		/**
		 *  Read-only property that returns <code>true</code>
		 */
		public static function get isDragging () : Boolean;

		/**
		 *  Initiates a drag and drop operation.
		 */
		public static function doDrag (dragInitiator:IUIComponent, dragSource:DragSource, mouseEvent:MouseEvent, dragImage:IFlexDisplayObject = null, xOffset:Number = 0, yOffset:Number = 0, imageAlpha:Number = 0.5, allowMove:Boolean = true) : void;
		/**
		 *  Call this method from your <code>dragEnter</code> event handler if you accept
		 */
		public static function acceptDragDrop (target:IUIComponent) : void;
		/**
		 *  Sets the feedback indicator for the drag and drop operation.
		 */
		public static function showFeedback (feedback:String) : void;
		/**
		 *  Returns the current drag and drop feedback.
		 */
		public static function getFeedback () : String;
		/**
		 *  @private
		 */
		static function endDrag () : void;
	}
}