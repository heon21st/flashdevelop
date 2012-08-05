﻿package fl.video
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;

	/**
	 * XML examples from above without xml entitiy substitution:
	 */
	public class SMILManager
	{
		private var _owner : INCManager;
		local var xml : XML;
		local var xmlLoader : URLLoader;
		local var baseURLAttr : Array;
		local var width : int;
		local var height : int;
		local var videoTags : Array;
		private var _url : String;

		/**
		 * constructor
		 */
		public function SMILManager (owner:INCManager);
		/**
		 * <p>Starts download of XML file.  Will be parsed and based
		 */
		function connectXML (url:String) : Boolean;
		/**
		 * <p>Append version parameter to URL.</p>
		 */
		function fixURL (origURL:String) : String;
		/**
		 * <p>Handles load of XML.
		 */
		function xmlLoadEventHandler (e:Event) : void;
		/**
		 * parse head node of smil
		 */
		function parseHead (parentNode:XML) : void;
		/**
		 * parse layout node of smil
		 */
		function parseLayout (parentNode:XML) : void;
		/**
		 * parse body node of smil
		 */
		function parseBody (parentNode:XML) : void;
		/**
		 * parse switch node of smil
		 */
		function parseSwitch (parentNode:XML) : void;
		/**
		 * parse video or ref node of smil.  Returns object with
		 */
		function parseVideo (node:XML) : Object;
		/**
		 * parse time in hh:mm:ss.s or mm:ss.s format.
		 */
		function parseTime (timeStr:String) : Number;
		/**
		 * checks for extra, unrecognized elements of the given kind
		 */
		function checkForIllegalNodes (parentNode:XML, kind:String, legalNodes:Array) : void;
	}
}