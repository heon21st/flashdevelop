﻿package fl.events
{
	import flash.events.Event;
	import fl.events.ListEvent;

	/**
	 * The DataGridEvent class defines events that are associated with the DataGrid component. 
	 */
	public class DataGridEvent extends ListEvent
	{
		/**
		 * The <code>DataGridEvent.COLUMN_STRETCH</code> constant defines the value of the <code>type</code> property
		 */
		public static const COLUMN_STRETCH : String = "columnStretch";
		/**
		 * The <code>DataGridEvent.HEADER_RELEASE</code> constant defines the value of the <code>type</code> property
		 */
		public static const HEADER_RELEASE : String = "headerRelease";
		/**
		 * The <code>DataGridEvent.ITEM__EDIT_BEGINNING</code> constant defines the value of the 
		 */
		public static const ITEM_EDIT_BEGINNING : String = "itemEditBeginning";
		/**
		 * The <code>DataGridEvent.ITEM_EDIT_BEGIN</code> constant defines the value of
		 */
		public static const ITEM_EDIT_BEGIN : String = "itemEditBegin";
		/**
		 * The <code>DataGridEvent.ITEM_EDIT_END</code> constant defines the value of the <code>type</code> 
		 */
		public static const ITEM_EDIT_END : String = "itemEditEnd";
		/**
		 * The <code>DataGridEvent.ITEM_FOCUS_IN</code> constant defines the value of the <code>type</code> 
		 */
		public static const ITEM_FOCUS_IN : String = "itemFocusIn";
		/**
		 * The <code>DataGridEvent.ITEM_FOCUS_OUT</code> constant defines the value of the <code>type</code>
		 */
		public static const ITEM_FOCUS_OUT : String = "itemFocusOut";
		/**
		 * @private (protected)
		 */
		protected var _dataField : String;
		/**
		 * @private (protected)
		 */
		protected var _itemRenderer : Object;
		/**
		 * @private (protected)
		 */
		protected var _reason : String;

		/**
		 * Gets the item renderer for the item that is being edited or the 
		 */
		public function get itemRenderer () : Object;
		/**
		 * Gets or sets the name of the field or property in the data associated with the column.
		 */
		public function get dataField () : String;
		/**
		 * @private (setter)
		 */
		public function set dataField (value:String) : void;
		/**
		 *  Gets the reason the <code>itemEditEnd</code> event was dispatched. 
		 */
		public function get reason () : String;

		/**
		 * Creates a new DataGridEvent object with the specified parameters. 
		 */
		public function DataGridEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, columnIndex:int = -1, rowIndex:int = -1, itemRenderer:Object = null, dataField:String = null, reason:String = null);
		/**
		 * Returns a string that contains all the properties of the DataGridEvent object. The
		 */
		public function toString () : String;
		/**
		 * Creates a copy of the DataGridEvent object and sets the value of each 
		 */
		public function clone () : Event;
	}
}