﻿package mx.containers
{
	import flash.display.DisplayObject;
	import mx.containers.gridClasses.GridColumnInfo;
	import mx.containers.gridClasses.GridRowInfo;
	import mx.containers.utilityClasses.Flex;
	import mx.core.EdgeMetrics;
	import mx.core.ScrollPolicy;
	import mx.core.mx_internal;

	/**
	 *  Horizontal alignment of children in the container.
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 
	/**
	 *  Vertical alignment of children in the container.
	 */
	[Style(name="verticalAlign", type="String", enumeration="bottom,middle,top", inherit="no")] 

	/**
	 *  The GridRow container defines a row in a Grid container, and contains
	 */
	public class GridRow extends HBox
	{
		/**
		 *  @private
		 */
		local var columnWidths : Array;
		/**
		 *  @private
		 */
		local var rowHeights : Array;
		/**
		 *  @private
		 */
		local var rowIndex : int;
		/**
		 *  @private
		 */
		local var numGridItems : int;

		/**
		 *  @private
		 */
		public function get clipContent () : Boolean;
		/**
		 *  @private
		 */
		public function set clipContent (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 *  @private
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function GridRow ();
		/**
		 *  @private
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @private
		 */
		public function invalidateSize () : void;
		/**
		 *  @private
		 */
		public function invalidateDisplayList () : void;
		/**
		 *  Sets the size and position of each child of the GridRow container.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function getStyle (styleProp:String) : *;
		/**
		 *  @private
		 */
		function updateRowMeasurements () : void;
		/**
		 *  @private
		 */
		function doRowLayout (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		private function calculateColumnWidths () : void;
	}
}