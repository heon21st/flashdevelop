﻿package mx.styles
{
	/**
	 *  This interface describes the properties and methods that an object 
	 */
	public interface ISimpleStyleClient
	{
		/**
		 *  The source of this object's style values.
		 */
		public function get styleName () : Object;
		/**
		 *  @private
		 */
		public function set styleName (value:Object) : void;

		/**
		 *  Called when the value of a style property is changed. 
		 */
		public function styleChanged (styleProp:String) : void;
	}
}