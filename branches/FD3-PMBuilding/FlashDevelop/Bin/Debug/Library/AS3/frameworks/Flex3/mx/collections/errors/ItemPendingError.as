﻿package mx.collections.errors
{
	import mx.rpc.IResponder;

	/**
	 *  This error is thrown when retrieving an item from a collection view
	 */
	public class ItemPendingError extends Error
	{
		/**
		 *  @private
		 */
		private var _responders : Array;

		/**
		 *  An array of IResponder handlers that will be called when
		 */
		public function get responders () : Array;

		/**
		 *  Constructor.
		 */
		public function ItemPendingError (message:String);
		/**
		 *  <code>addResponder</code> adds a responder to an Array of responders. 
		 */
		public function addResponder (responder:IResponder) : void;
	}
}