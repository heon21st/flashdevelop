﻿package mx.events
{
	import flash.events.Event;
	import mx.controls.Menu;
	import mx.controls.MenuBar;
	import mx.controls.listClasses.IListItemRenderer;

	/**
	 *  The MenuEvent class represents events that are associated with menu 
	 */
	public class MenuEvent extends ListEvent
	{
		/**
		 *  The MenuEvent.CHANGE event type constant indicates that selection
		 */
		public static const CHANGE : String = "change";
		/**
		 *  The MenuEvent.ITEM_CLICK event type constant indicates that the
		 */
		public static const ITEM_CLICK : String = "itemClick";
		/**
		 *  The MenuEvent.MENU_HIDE event type constant indicates that
		 */
		public static const MENU_HIDE : String = "menuHide";
		/**
		 *  The MenuEvent.ITEM_ROLL_OUT type constant indicates that
		 */
		public static const ITEM_ROLL_OUT : String = "itemRollOut";
		/**
		 *  The MenuEvent.ITEM_ROLL_OVER type constant indicates that
		 */
		public static const ITEM_ROLL_OVER : String = "itemRollOver";
		/**
		 *  The MenuEvent.MENU_SHOW type constant indicates that
		 */
		public static const MENU_SHOW : String = "menuShow";
		/**
		 *  The index of the associated menu item within its parent menu or submenu. 
		 */
		public var index : int;
		/**
		 *  The specific item in the dataProvider. 
		 */
		public var item : Object;
		/**
		 *  The label text of the associated menu item.
		 */
		public var label : String;
		/**
		 *  The specific Menu instance associated with the event,
		 */
		public var menu : Menu;
		/**
		 *  The MenuBar instance that is the parent of the selected Menu control,
		 */
		public var menuBar : MenuBar;

		/**
		 *  Constructor.
		 */
		public function MenuEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = true, menuBar:MenuBar = null, menu:Menu = null, item:Object = null, itemRenderer:IListItemRenderer = null, label:String = null, index:int = -1);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}