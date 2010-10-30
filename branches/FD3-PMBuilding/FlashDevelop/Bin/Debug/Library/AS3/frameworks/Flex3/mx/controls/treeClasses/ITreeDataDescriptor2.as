﻿package mx.controls.treeClasses
{
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;

	/**
	 *  The ITreeDataDescriptor2 Interface defines methods for parsing and adding nodes
	 */
	public interface ITreeDataDescriptor2 extends ITreeDataDescriptor
	{
		/**
		 *  Returns an ICollectionView instance that makes the hierarchical data appear
		 */
		public function getHierarchicalCollectionAdaptor (hierarchicalData:ICollectionView, uidFunction:Function, openItems:Object, model:Object = null) : ICollectionView;
		/**
		 *  Returns the depth of the node, meaning the number of ancestors it has.
		 */
		public function getNodeDepth (node:Object, iterator:IViewCursor, model:Object = null) : int;
		/**
		 *  Returns the parent of the node
		 */
		public function getParent (node:Object, collection:ICollectionView, model:Object = null) : Object;
	}
}