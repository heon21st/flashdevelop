﻿package mx.utils
{
	import flash.xml.XMLDocument;

	/**
	 *  The XMLUtil class is an all-static class
	 */
	public class XMLUtil
	{
		/**
		 *  Creates XML out of the specified string, ignoring whitespace.
		 */
		public static function createXMLDocument (str:String) : XMLDocument;
		/**
		 *  Returns <code>true</code> if the two QName parameters have identical
		 */
		public static function qnamesEqual (qname1:QName, qname2:QName) : Boolean;
		/**
		 *  Returns the concatenation of a Qname object's
		 */
		public static function qnameToString (qname:QName) : String;
		/**
		 * Returns the XML value of an attribute matching the given QName
		 */
		public static function getAttributeByQName (xml:XML, attrQName:QName) : XMLList;
	}
}