﻿package mx.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.xml.XMLNode;
	import mx.collections.IList;

	/**
	 *  The ObjectUtil class is an all-static class with methods for
	 */
	public class ObjectUtil
	{
		/**
		 *  Array of properties to exclude from debugging output.
		 */
		private static var defaultToStringExcludes : Array;
		/**
		 * @private
		 */
		private static var refCount : int;
		/**
		 * @private
		 */
		private static var CLASS_INFO_CACHE : Object;

		/**
		 *  Compares the Objects and returns an integer value 
		 */
		public static function compare (a:Object, b:Object, depth:int = -1) : int;
		/**
		 *  Copies the specified Object and returns a reference to the copy.
		 */
		public static function copy (value:Object) : Object;
		/**
		 *  Returns <code>true</code> if the object reference specified
		 */
		public static function isSimple (value:Object) : Boolean;
		/**
		 *  Compares two numeric values.
		 */
		public static function numericCompare (a:Number, b:Number) : int;
		/**
		 *  Compares two String values.
		 */
		public static function stringCompare (a:String, b:String, caseInsensitive:Boolean = false) : int;
		/**
		 *  Compares the two Date objects and returns an integer value 
		 */
		public static function dateCompare (a:Date, b:Date) : int;
		/**
		 *  Pretty-prints the specified Object into a String.
		 */
		public static function toString (value:Object, namespaceURIs:Array = null, exclude:Array = null) : String;
		/**
		 *  This method cleans up all of the additional parameters that show up in AsDoc
		 */
		private static function internalToString (value:Object, indent:int = 0, refs:Dictionary = null, namespaceURIs:Array = null, exclude:Array = null) : String;
		/**
		 *  @private
		 */
		private static function newline (str:String, n:int = 0) : String;
		private static function internalCompare (a:Object, b:Object, currentDepth:int, desiredDepth:int, refs:Dictionary) : int;
		/**
		 *  Returns information about the class, and properties of the class, for
		 */
		public static function getClassInfo (obj:Object, excludes:Array = null, options:Object = null) : Object;
		/**
		 * Uses <code>getClassInfo</code> and examines the metadata information to
		 */
		public static function hasMetadata (obj:Object, propName:String, metadataName:String, excludes:Array = null, options:Object = null) : Boolean;
		/**
		 *  @private
		 */
		private static function internalHasMetadata (metadataInfo:Object, propName:String, metadataName:String) : Boolean;
		/**
		 *  @private
		 */
		private static function recordMetadata (properties:XMLList) : Object;
		/**
		 *  @private
		 */
		private static function getCacheKey (o:Object, excludes:Array = null, options:Object = null) : String;
		/**
		 *  @private
		 */
		private static function arrayCompare (a:Array, b:Array, currentDepth:int, desiredDepth:int, refs:Dictionary) : int;
		/**
		 * @private
		 */
		private static function byteArrayCompare (a:ByteArray, b:ByteArray) : int;
		/**
		 *  @private
		 */
		private static function listCompare (a:IList, b:IList, currentDepth:int, desiredDepth:int, refs:Dictionary) : int;
	}
}