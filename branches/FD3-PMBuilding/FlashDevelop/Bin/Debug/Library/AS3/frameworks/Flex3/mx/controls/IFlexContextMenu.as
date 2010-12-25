﻿package mx.controls
{
	import flash.display.InteractiveObject;

	/**
	 *  The IFlexContextMenu interface defines the interface for a 
	 */
	public interface IFlexContextMenu
	{
		/**
		 *  Sets the context menu of an InteractiveObject.  This will do 
		 */
		public function setContextMenu (component:InteractiveObject) : void;
		/**
		 *  Unsets the context menu of a InteractiveObject.  This will do 
		 */
		public function unsetContextMenu (component:InteractiveObject) : void;
	}
}