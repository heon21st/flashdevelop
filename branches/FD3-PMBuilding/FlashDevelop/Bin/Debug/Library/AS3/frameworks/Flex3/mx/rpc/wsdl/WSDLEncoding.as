﻿package mx.rpc.wsdl
{
	import mx.rpc.soap.SOAPConstants;

	/**
	 * SOAP specific WSDL bindings that describe how to encode messages
	 */
	public class WSDLEncoding
	{
		private var _encodingStyle : String;
		private var _message : QName;
		private var _namespaceURI : String;
		private var _parts : Array;
		private var _soapConstants : SOAPConstants;
		private var _useStyle : String;

		/**
		 * Currently only SOAP 1.1 encoding is supported. The default
		 */
		public function get encodingStyle () : String;
		public function set encodingStyle (value:String) : void;
		/**
		 * The SOAP header and header fault extensions for WSDL bindings define
		 */
		public function get message () : QName;
		public function set message (value:QName) : void;
		/**
		 * The SOAP body extension for WSDL bindings using the rpc style may define
		 */
		public function get namespaceURI () : String;
		public function set namespaceURI (value:String) : void;
		/**
		 * The SOAP body extension for WSDL bindings may define a <code>parts</code>
		 */
		public function get parts () : Array;
		/**
		 * The SOAPConstants associated with this set of encoding rules
		 */
		public function get soapConstants () : SOAPConstants;
		/**
		 * <p>
		 */
		public function get useStyle () : String;
		public function set useStyle (value:String) : void;

		public function WSDLEncoding ();
		/**
		 * Determines whether a part should be included when encoding this message.
		 */
		public function hasPart (name:String) : Boolean;
		/**
		 * Establishes a subset of parts that should be included in the message.
		 */
		public function setParts (value:String) : void;
	}
}