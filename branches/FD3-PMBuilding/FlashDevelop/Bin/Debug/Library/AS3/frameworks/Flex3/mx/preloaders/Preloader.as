﻿package mx.preloaders
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.core.ResourceModuleRSLItem;
	import mx.core.RSLItem;
	import mx.core.RSLListLoader;
	import mx.events.FlexEvent;
	import mx.events.RSLEvent;

	/**
	 *  The Preloader class is used by the SystemManager to monitor
	 */
	public class Preloader extends Sprite
	{
		/**
		 *  @private
		 */
		private var displayClass : IPreloaderDisplay;
		/**
		 *  @private
		 */
		private var timer : Timer;
		/**
		 *  @private
		 */
		private var showDisplay : Boolean;
		/**
		 *  @private
		 */
		private var rslListLoader : RSLListLoader;
		/**
		 *  @private
		 */
		private var rslDone : Boolean;
		/**
		 *  @private
		 */
		private var app : IEventDispatcher;

		/**
		 *	Constructor.
		 */
		public function Preloader ();
		/**
		 *  Called by the SystemManager to initialize a Preloader object.
		 */
		public function initialize (showDisplay:Boolean, displayClassName:Class, backgroundColor:uint, backgroundAlpha:Number, backgroundImage:Object, backgroundSize:String, displayWidth:Number, displayHeight:Number, libs:Array = null, sizes:Array = null, rslList:Array = null, resourceModuleURLs:Array = null) : void;
		/**
		 *  Called by the SystemManager after it has finished instantiating
		 */
		public function registerApplication (app:IEventDispatcher) : void;
		/**
		 *  @private
		 */
		private function getByteValues () : Object;
		/**
		 *  @private
		 */
		private function dispatchAppEndEvent (event:Object = null) : void;
		/**
		 *  @private
		 */
		function rslProgressHandler (event:ProgressEvent) : void;
		/**
		 *  @private
		 */
		function rslCompleteHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function rslErrorHandler (event:ErrorEvent) : void;
		/**
		 *  @private
		 */
		private function timerHandler (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		private function ioErrorHandler (event:IOErrorEvent) : void;
		/**
		 *  @private
		 */
		private function displayClassCompleteHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function appCreationCompleteHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function appProgressHandler (event:Event) : void;
	}
}