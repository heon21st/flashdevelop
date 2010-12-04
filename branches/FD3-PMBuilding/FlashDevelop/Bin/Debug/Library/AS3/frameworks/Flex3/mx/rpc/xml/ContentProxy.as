﻿package mx.rpc.xml
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import mx.utils.object_proxy;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;

	/**
	 * Wraps the value of an element's or child type's content so that it can be
	 */
	public dynamic class ContentProxy extends Proxy
	{
		private var _content : *;
		private var _isSimple : Boolean;
		private var _makeObjectsBindable : Boolean;
		private var _propertyList : Array;

		function get makeObjectsBindable () : Boolean;
		function set makeObjectsBindable (value:Boolean) : void;
		function get isSimple () : Boolean;
		function set isSimple (value:Boolean) : void;
		function get content () : *;
		function set content (value:*) : void;

		public function ContentProxy (content:* = undefined, makeObjectsBindable:Boolean = false, isSimple:Boolean = true);
		/**
		 *  Returns the specified property value of the proxied object.
		 */
		flash_proxy function getProperty (name:*) : *;
		/**
		 *  Returns the value of the proxied object's method with the specified name.
		 */
		flash_proxy function callProperty (name:*, ...rest) : *;
		/**
		 *  Deletes the specified property on the proxied object.
		 */
		flash_proxy function deleteProperty (name:*) : Boolean;
		/**
		 *  This is an internal function that must be implemented by 
		 */
		flash_proxy function hasProperty (name:*) : Boolean;
		/**
		 *  Updates the specified property on the proxied object.
		 */
		flash_proxy function setProperty (name:*, value:*) : void;
		/**
		 *  This is an internal function that must be implemented by 
		 */
		flash_proxy function nextName (index:int) : String;
		/**
		 *  This is an internal function that must be implemented by 
		 */
		flash_proxy function nextNameIndex (index:int) : int;
		/**
		 *  This is an internal function that must be implemented by 
		 */
		flash_proxy function nextValue (index:int) : *;
		function setupPropertyList () : void;
		function createObject () : *;
	}
}