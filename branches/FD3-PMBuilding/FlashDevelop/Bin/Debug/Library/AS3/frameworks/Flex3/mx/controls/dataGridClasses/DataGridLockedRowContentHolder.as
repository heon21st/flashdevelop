﻿package mx.controls.dataGridClasses
{
	import mx.controls.listClasses.ListBase;
	import mx.controls.listClasses.ListBaseContentHolder;

	/**
	 *  The DataGridLockedRowContentHolder class defines a container in a DataGrid control
	 */
	public class DataGridLockedRowContentHolder extends ListBaseContentHolder
	{
		/**
		 * The measured height of the DataGrid control.
		 */
		public function get measuredHeight () : Number;

		/**
		 *  Constructor.
		 */
		public function DataGridLockedRowContentHolder (parentList:ListBase);
	}
}