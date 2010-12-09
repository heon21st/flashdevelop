﻿package mx.collections
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import mx.core.mx_internal;

	/**
	 *  The ArrayCollection class is a wrapper class that exposes an Array as
	 */
	public class ArrayCollection extends ListCollectionView implements IExternalizable
	{
		/**
		 *  The source of data in the ArrayCollection.
		 */
		public function get source () : Array;
		/**
		 *  @private
		 */
		public function set source (s:Array) : void;

		/**
		 *  Constructor.
		 */
		public function ArrayCollection (source:Array = null);
		/**
		 *  @private
		 */
		public function readExternal (input:IDataInput) : void;
		/**
		 *  @private
		 */
		public function writeExternal (output:IDataOutput) : void;
	}
}