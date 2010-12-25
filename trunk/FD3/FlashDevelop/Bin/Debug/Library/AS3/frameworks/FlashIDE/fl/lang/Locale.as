﻿package fl.lang
{
	import flash.system.Capabilities;
	import flash.xml.*;
	import flash.net.*;
	import flash.events.*;

	/**
	 * The fl.lang.Locale class allows you to control how multilanguage text is displayed in a SWF file. 
	 */
	public class Locale extends flash.events.EventDispatcher
	{
		private static var flaName : String;
		private static var defaultLang : String;
		private static var xmlLang : String;
		private static var xmlMap : Object;
		private static var xmlDoc : XMLDocument;
		private static var stringMap : Object;
		private static var delayedInstanceArray : Array;
		private static var currentXMLMapIndex : Number;
		private static var callback : Function;
		private static var autoReplacement : Boolean;
		private static var currentLang : String;
		private static var stringMapList : Object;
		private static var _xmlLoaded : Boolean;

		/**
		 * Determines whether strings are replaced automatically after loading the XML file. If set to <code>true</code>, the text 
		 */
		public static function get autoReplace () : Boolean;
		public static function set autoReplace (auto:Boolean) : void;
		/**
		 * An array containing language codes for the languages that have been specified or loaded into the FLA file. The language codes are not sorted alphabetically.
		 */
		public static function get languageCodeArray () : Array;
		/**
		 * An array containing all the string IDs in the FLA file. The string IDs are not sorted alphabetically.
		 */
		public static function get stringIDArray () : Array;

		/**
		 * @private No need to document this, users won't need it. This is old code that isn't used by Flash Player 8, 
		 */
		public static function setFlaName (name:String) : void;
		/**
		 * The default language code as set in the Strings panel dialog box or by calling the <code>setDefaultLang()</code> method.
		 */
		public static function getDefaultLang () : String;
		/**
		 * Sets the default language code.
		 */
		public static function setDefaultLang (langCode:String) : void;
		/**
		 * Adds the {languageCode and languagePath} pair into the internal array for later use.
		 */
		public static function addXMLPath (langCode:String, path:String) : void;
		/**
		 * Adds the {instance, string ID} pair into the internal array for later use.
		 */
		public static function addDelayedInstance (instance:Object, stringID:String);
		/**
		 * Returns <code>true</code> if the XML file is loaded; <code>false</code> otherwise. 
		 */
		public static function checkXMLStatus () : Boolean;
		/**
		 * Sets the callback function that is called after the XML file is loaded.
		 */
		public static function setLoadCallback (loadCallback:Function);
		/**
		 * Returns the string value associated with the given string ID in the current language.
		 */
		public static function loadString (id:String) : String;
		/**
		 * Returns the string value associated with the given string ID and language code.
		 */
		public static function loadStringEx (stringID:String, languageCode:String) : String;
		/**
		 * Sets the new string value of a given string ID and language code.
		 */
		public static function setString (stringID:String, languageCode:String, stringValue:String) : void;
		/**
		 * Automatically determines the language to use and loads the XML language file.
		 */
		public static function initialize () : void;
		/**
		 * Loads the specified XML language file.
		 */
		public static function loadLanguageXML (xmlLanguageCode:String, customXmlCompleteCallback:Function = null) : void;
		private static function loadXML (langCode:String);
		private static function onXMLLoad (eventObj:Event);
		private static function parseStringsXML (doc:XMLDocument) : void;
		private static function parseXLiff (node:XMLNode) : void;
		private static function parseFile (node:XMLNode) : void;
		private static function parseBody (node:XMLNode) : void;
		private static function parseTransUnit (node:XMLNode) : void;
		private static function parseSource (node:XMLNode) : String;
		private static function assignDelayedInstances () : void;
	}
}