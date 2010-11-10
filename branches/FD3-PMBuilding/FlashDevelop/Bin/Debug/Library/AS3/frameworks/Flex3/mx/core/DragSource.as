﻿package mx.core
{
	/**
	 *  The DragSource class contains the data being dragged. The data can be in
	 */
	public class DragSource
	{
		/**
		 *  @private
		 */
		private var dataHolder : Object;
		/**
		 *  @private
		 */
		private var formatHandlers : Object;
		/**
		 *  @private
		 */
		private var _formats : Array;

		/**
		 *  Contains the formats of the drag data, as an Array of Strings.
		 */
		public function get formats () : Array;

		/**
		 *  Constructor.
		 */
		public function DragSource ();
		/**
		 *  Adds data and a corresponding format String to the drag source.
		 */
		public function addData (data:Object, format:String) : void;
		/**
		 *  Adds a handler that is called when data
		 */
		public function addHandler (handler:Function, format:String) : void;
		/**
		 *  Retrieves the data for the specified format.
		 */
		public function dataForFormat (format:String) : Object;
		/**
		 *  Returns <code>true</code> if the data source contains
		 */
		public function hasFormat (format:String) : Boolean;
	}
}