﻿package mx.controls.menuClasses
{
	import mx.controls.MenuBar;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IDataRenderer;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  The IMenuBarItemRenderer interface defines the interface
	 */
	public interface IMenuBarItemRenderer extends IDataRenderer
	{
		/**
		 *  Contains a reference to the item renderer's MenuBar control.
		 */
		public function get menuBar () : MenuBar;
		/**
		 *  @private
		 */
		public function set menuBar (value:MenuBar) : void;
		/**
		 *  Contains the index of this item renderer relative to
		 */
		public function get menuBarItemIndex () : int;
		/**
		 *  @private
		 */
		public function set menuBarItemIndex (value:int) : void;
		/**
		 *  Contains the current state of this item renderer. 
		 */
		public function get menuBarItemState () : String;
		/**
		 *  @private
		 */
		public function set menuBarItemState (value:String) : void;

	}
}