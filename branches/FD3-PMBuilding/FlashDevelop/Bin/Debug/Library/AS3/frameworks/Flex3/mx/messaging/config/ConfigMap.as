﻿package mx.messaging.config
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import mx.utils.object_proxy;
	import mx.utils.ObjectUtil;

	/**
	 *  The ConfigMap class provides a mechanism to store the properties returned 
	 */
	flash_proxy dynamic class ConfigMap extends Proxy
	{
		/**
		 *  Contains a list of all of the property names for the proxied object.
		 */
		local var propertyList : Array;
		/**
		 *  Storage for the object property.
		 */
		private var _item : Object;

		/**
		 * Constructor.
		 */
		public function ConfigMap (item:Object = null);
		/**
		 *  Returns the specified property value of the proxied object.
		 */
		flash_proxy function getProperty (name:*) : *;
		/**
		 *  Returns the value of the proxied object's method with the specified name.
		 */
		flash_proxy function callProperty (name:*, ...rest) : *;
		/**
		 *  Deletes the specified property on the proxied object and
		 */
		flash_proxy function deleteProperty (name:*) : Boolean;
		/**
		 *  This is an internal function that must be implemented by 
		 */
		flash_proxy function hasProperty (name:*) : Boolean;
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
		/**
		 *  Updates the specified property on the proxied object
		 */
		flash_proxy function setProperty (name:*, value:*) : void;
	}
}