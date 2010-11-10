﻿package mx.rpc.xml
{
	/**
	 * Encodes an ActionScript object graph to XML based on an XML schema.
	 */
	public interface IXMLEncoder
	{
		/**
		 * The function to be used to escape XML special characters before encoding
		 */
		public function get xmlSpecialCharsFilter () : Function;
		public function set xmlSpecialCharsFilter (func:Function) : void;
		/**
		 * When <code>true</code>, null values
		 */
		public function get strictNillability () : Boolean;
		public function set strictNillability (value:Boolean) : void;

		/**
		 * Encodes an ActionScript value as XML.
		 */
		public function encode (value:*, name:QName = null, type:QName = null, definition:XML = null) : XMLList;
		/**
		 * Resets the encoder to its initial state, including resetting any 
		 */
		public function reset () : void;
	}
}