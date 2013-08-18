﻿package fl.controls.dataGridClasses
{
	import fl.controls.LabelButton;
	import fl.controls.listClasses.ListData;
	import fl.controls.listClasses.ICellRenderer;
	import fl.controls.TextInput;
	import fl.core.UIComponent;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 *  @copy fl.core.UIComponent#style:textFormat
	 */
	[Style(name="textFormat", type="flash.text.TextFormat")] 
	/**
	 *	Name of the class to use as the skin for the background and border
	 */
	[Style(name="upSkin", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:textPadding
	 */
	[Style(name="textPadding", type="Number", format="Length")] 

	/**
	 * The DataGridCellEditor class defines the default item editor for a 
	 */
	public class DataGridCellEditor extends TextInput implements ICellRenderer
	{
		/**
		 * @private (protected)
		 */
		protected var _listData : ListData;
		/**
		 * @private (protected)
		 */
		protected var _data : Object;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;

		/**
		 * @copy fl.controls.listClasses.ICellRenderer#listData
		 */
		public function get listData () : ListData;
		/**
		 * @private (setter)
		 */
		public function set listData (value:ListData) : void;
		/**
		 * @copy fl.controls.listClasses.ICellRenderer#data
		 */
		public function get data () : Object;
		/**
		 * @private (setter)
		 */
		public function set data (value:Object) : void;
		/**
		 * Indicates whether the cell is included in the
		 */
		public function get selected () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set selected (value:Boolean) : void;

		/**
		 * Creates a new DataGridCellEditor instance.
		 */
		public function DataGridCellEditor ();
		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * @copy fl.controls.listClasses.ICellRenderer#setMouseState()
		 */
		public function setMouseState (state:String) : void;
	}
}