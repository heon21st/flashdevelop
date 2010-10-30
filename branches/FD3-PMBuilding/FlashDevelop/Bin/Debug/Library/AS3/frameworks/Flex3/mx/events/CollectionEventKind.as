﻿package mx.events
{
	/**
	 *  The CollectionEventKind class contains constants for the valid values 
	 */
	public class CollectionEventKind
	{
		/**
		 *  Indicates that the collection added an item or items.
		 */
		public static const ADD : String = "add";
		/**
		 *  Indicates that the item has moved from the position identified
		 */
		public static const MOVE : String = "move";
		/**
		 *  Indicates that the collection applied a sort, a filter, or both.
		 */
		public static const REFRESH : String = "refresh";
		/**
		 *  Indicates that the collection removed an item or items.
		 */
		public static const REMOVE : String = "remove";
		/**
		 *  Indicates that the item at the position identified by the 
		 */
		public static const REPLACE : String = "replace";
		/**
		 *  Indicates that the collection has internally expanded. 
		 */
		static const EXPAND : String = "expand";
		/**
		 *  Indicates that the collection has changed so drastically that
		 */
		public static const RESET : String = "reset";
		/**
		 *  Indicates that one or more items were updated within the collection.
		 */
		public static const UPDATE : String = "update";

	}
}