﻿package mx.binding
{
	import mx.collections.errors.ItemPendingError;
	import mx.core.mx_internal;

	/**
	 *  @private
	 */
	public class Watcher
	{
		/**
		 *  @private
		 */
		protected var listeners : Array;
		/**
		 *  @private
		 */
		protected var children : Array;
		/**
		 *  @private
		 */
		public var value : Object;
		/**
		 *  @private
		 */
		protected var cloneIndex : int;

		/**
		 *  Constructor.
		 */
		public function Watcher (listeners:Array = null);
		/**
		 *  @private
		 */
		public function updateParent (parent:Object) : void;
		/**
		 *  @private
		 */
		public function addChild (child:Watcher) : void;
		/**
		 *  @private
		 */
		public function removeChildren (startingIndex:int) : void;
		/**
		 *  We have probably changed, so go through
		 */
		public function updateChildren () : void;
		/**
		 *  @private
		 */
		private function valueChanged (oldval:Object) : Boolean;
		/**
		 *  @private
		 */
		protected function wrapUpdate (wrappedFunction:Function) : void;
		/**
		 *  @private
		 */
		protected function deepClone (index:int) : Watcher;
		/**
		 *  @private
		 */
		protected function shallowClone () : Watcher;
		/**
		 *  @private
		 */
		public function notifyListeners (commitEvent:Boolean) : void;
	}
}