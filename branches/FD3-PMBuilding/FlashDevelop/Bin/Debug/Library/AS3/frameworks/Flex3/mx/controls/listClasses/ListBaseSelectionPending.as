﻿package mx.controls.listClasses
{
	import mx.collections.CursorBookmark;

	/**
	 *  @private
	 */
	public class ListBaseSelectionPending
	{
		/**
		 *  The bookmark we have to seek to
		 */
		public var bookmark : CursorBookmark;
		/**
		 *  True if we moveNext(), false if we movePrevious()
		 */
		public var incrementing : Boolean;
		/**
		 *  The index into the iterator when we hit the page fault
		 */
		public var index : int;
		/**
		 *  The offset from the bookmark we have to seek to
		 */
		public var offset : int;
		/**
		 *  The bookmark we have to restore after we're done
		 */
		public var placeHolder : CursorBookmark;
		/**
		 *  The data of the current item, which is the thing we are looking for.
		 */
		public var stopData : Object;
		/**
		 *  Whether to tween in the visuals
		 */
		public var transition : Boolean;

		/**
		 *  Constructor.
		 */
		public function ListBaseSelectionPending (incrementing:Boolean, index:int, stopData:Object, transition:Boolean, placeHolder:CursorBookmark, bookmark:CursorBookmark, offset:int);
	}
}