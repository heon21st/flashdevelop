﻿package mx.controls.treeClasses
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.XMLListAdapter;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.ItemPendingError;
	import mx.core.EventPriority;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.PropertyChangeEvent;
	import mx.utils.IXMLNotifiable;
	import mx.utils.XMLNotifier;

	/**
	 *  @private
	 */
	public class HierarchicalCollectionView extends EventDispatcher implements ICollectionView
	{
		/**
		 *  @private
		 */
		private var dataDescriptor : ITreeDataDescriptor;
		/**
		 *  @private
		 */
		private var treeData : ICollectionView;
		/**
		 *  @private
		 */
		private var cursor : HierarchicalViewCursor;
		/**
		 *  @private
		 */
		private var currentLength : int;
		/**
		 *  @private
		 */
		public var openNodes : Object;
		/**
		 *  @private
		 */
		public var parentMap : Object;
		/**
		 *  @private
		 */
		private var parentNode : XML;
		/**
		 *  @private
		 */
		private var childrenMap : Dictionary;
		/**
		 *  @private
		 */
		private var itemToUID : Function;

		/**
		 *  Not Supported in Tree.
		 */
		public function get filterFunction () : Function;
		/**
		 *  Not Supported in Tree.
		 */
		public function set filterFunction (value:Function) : void;
		/**
		 *  The length of the currently parsed collection.  This
		 */
		public function get length () : int;
		/**
		 *  @private
		 */
		public function get sort () : Sort;
		/**
		 *  @private
		 */
		public function set sort (value:Sort) : void;

		/**
		 *  Constructor.
		 */
		public function HierarchicalCollectionView (model:ICollectionView, treeDataDescriptor:ITreeDataDescriptor, itemToUID:Function, argOpenNodes:Object = null);
		/**
		 *  Returns the parent of a node.  Top level node's parent is null
		 */
		public function getParentItem (node:Object) : *;
		/**
		 *  @private
		 */
		public function calculateLength (node:Object = null, parent:Object = null) : int;
		/**
		 *  @private
		 */
		public function describeData () : Object;
		/**
		 *  Returns a new instance of a view iterator over the items in this view
		 */
		public function createCursor () : IViewCursor;
		/**
		 *  Checks the collection for item using standard equality test.
		 */
		public function contains (item:Object) : Boolean;
		/**
		 *  @private
		 */
		public function disableAutoUpdate () : void;
		/**
		 *  @private
		 */
		public function enableAutoUpdate () : void;
		/**
		 *  @private
		 */
		public function itemUpdated (item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void;
		/**
		 *  @private
		 */
		public function refresh () : Boolean;
		/**
		 * @private
		 */
		private function getChildren (node:Object) : ICollectionView;
		/**
		 * @private
		 */
		private function updateLength (node:Object = null, parent:Object = null) : void;
		/**
		 * @private
		 */
		private function getVisibleNodes (node:Object, parent:Object, nodeArray:Array) : void;
		/**
		 *  @private
		 */
		private function getVisibleLocation (oldLocation:int) : int;
		/**
		 * @private
		 */
		private function getVisibleLocationInSubCollection (parent:Object, oldLocation:int) : int;
		/**
		 *  @private
		 */
		public function collectionChangeHandler (event:CollectionEvent) : void;
		/**
		 *  @private
		 */
		public function nestedCollectionChangeHandler (event:CollectionEvent) : void;
		/**
		 * Called whenever an XML object contained in our list is updated
		 */
		public function xmlNotification (currentTarget:Object, type:String, target:Object, value:Object, detail:Object) : void;
		/**
		 *  This is called by addItemAt and when the source is initially
		 */
		private function startTrackUpdates (item:Object) : void;
		/**
		 *  This is called by removeItemAt, removeAll, and before a new
		 */
		private function stopTrackUpdates (item:Object) : void;
		/**
		 *  @private
		 */
		public function expandEventHandler (event:CollectionEvent) : void;
	}
}