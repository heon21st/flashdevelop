﻿package mx.core
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import mx.events.RSLEvent;
	import mx.utils.SHA256;
	import mx.utils.LoaderUtil;

	/**
	 *  @private
	 */
	public class CrossDomainRSLItem extends RSLItem
	{
		private var rslUrls : Array;
		private var policyFileUrls : Array;
		private var digests : Array;
		private var isSigned : Array;
		private var hashTypes : Array;
		private var urlIndex : int;

		/**
		 *  Create a cross-domain RSL item to load.
		 */
		public function CrossDomainRSLItem (rslUrls:Array, policyFileUrls:Array, digests:Array, hashTypes:Array, isSigned:Array, rootURL:String = null);
		/**
		 * 
		 */
		public function load (progressHandler:Function, completeHandler:Function, ioErrorHandler:Function, securityErrorHandler:Function, rslErrorHandler:Function) : void;
		/**
		 *  @private
		 */
		private function completeCdRslLoad (urlLoader:URLLoader) : Boolean;
		/**
		 *  Does the current url being processed have a failover?
		 */
		public function hasFailover () : Boolean;
		/**
		 *  Load the next url from the list of failover urls.
		 */
		public function loadFailover () : void;
		/**
		 *  @private
		 */
		public function itemCompleteHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function itemErrorHandler (event:ErrorEvent) : void;
		/**
		 * loader.loadBytes() has a complete event.
		 */
		private function loadBytesCompleteHandler (event:Event) : void;
	}
}