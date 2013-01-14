﻿package fl.data
{
	import flash.events.EventDispatcher;
	import fl.events.DataChangeEvent;
	import fl.events.DataChangeType;
	import RangeError;

	/**
	 * Dispatched before the data is changed.
	 */
	[Event(name="preDataChange", type="fl.events.DataChangeEvent")] 
	/**
	 * Dispatched after the data is changed.
	 */
	[Event(name="dataChange", type="fl.events.DataChangeEvent")] 

	/**
	 * The DataProvider class provides methods and properties that allow you to query and modify
	 */
	public class DataProvider extends EventDispatcher
	{
		/**
		 * @private (protected)
		 */
		protected var data : Array;

		/**
		 * The number of items that the data provider contains.
		 */
		public function get length () : uint;

		/**
		 * Creates a new DataProvider object using a list, XML instance or an array of data objects
		 */
		public function DataProvider (value:Object = null);
		/**
		 * Invalidates the item at the specified index. An item is invalidated after it is
		 */
		public function invalidateItemAt (index:int) : void;
		/**
		 * Invalidates the specified item. An item is invalidated after it is
		 */
		public function invalidateItem (item:Object) : void;
		/**
		 * Invalidates all the data items that the DataProvider contains and dispatches a 
		 */
		public function invalidate () : void;
		/**
		 * Adds a new item to the data provider at the specified index.
		 */
		public function addItemAt (item:Object, index:uint) : void;
		/**
		 * Appends an item to the end of the data provider.
		 */
		public function addItem (item:Object) : void;
		/**
		 * Adds several items to the data provider at the specified index and dispatches
		 */
		public function addItemsAt (items:Object, index:uint) : void;
		/**
		 * Appends multiple items to the end of the DataProvider and dispatches
		 */
		public function addItems (items:Object) : void;
		/**
		 * Concatenates the specified items to the end of the current data provider.
		 */
		public function concat (items:Object) : void;
		/**
		 * Appends the specified data into the data that the data provider
		 */
		public function merge (newData:Object) : void;
		/**
		 * Returns the item at the specified index.
		 */
		public function getItemAt (index:uint) : Object;
		/**
		 * Returns the index of the specified item.
		 */
		public function getItemIndex (item:Object) : int;
		/**
		 * Removes the item at the specified index and dispatches a <code>DataChangeType.REMOVE</code>
		 */
		public function removeItemAt (index:uint) : Object;
		/**
		 * Removes the specified item from the data provider and dispatches a <code>DataChangeType.REMOVE</code>
		 */
		public function removeItem (item:Object) : Object;
		/**
		 * Removes all items from the data provider and dispatches a <code>DataChangeType.REMOVE_ALL</code>
		 */
		public function removeAll () : void;
		/**
		 * Replaces an existing item with a new item and dispatches a <code>DataChangeType.REPLACE</code>
		 */
		public function replaceItem (newItem:Object, oldItem:Object) : Object;
		/**
		 *  Replaces the item at the specified index and dispatches a <code>DataChangeType.REPLACE</code>
		 */
		public function replaceItemAt (newItem:Object, index:uint) : Object;
		/**
		 * Sorts the items that the data provider contains and dispatches a <code>DataChangeType.SORT</code>
		 */
		public function sort (...sortArgs:Array) : *;
		/**
		 * Sorts the items that the data provider contains by the specified 
		 */
		public function sortOn (fieldName:Object, options:Object = null) : *;
		/**
		 * Creates a copy of the current DataProvider object.
		 */
		public function clone () : DataProvider;
		/**
		 * Creates an Array object representation of the data that the data provider contains.
		 */
		public function toArray () : Array;
		/**
		 * Creates a string representation of the data that the data provider contains.
		 */
		public function toString () : String;
		/**
		 * @private (protected)
		 */
		protected function getDataFromObject (obj:Object) : Array;
		/**
		 * @private (protected)
		 */
		protected function checkIndex (index:int, maximum:int) : void;
		/**
		 * @private (protected)
		 */
		protected function dispatchChangeEvent (evtType:String, items:Array, startIndex:int, endIndex:int) : void;
		/**
		 * @private (protected)
		 */
		protected function dispatchPreChangeEvent (evtType:String, items:Array, startIndex:int, endIndex:int) : void;
	}
}