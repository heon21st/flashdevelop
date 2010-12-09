﻿package mx.resources
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	import flash.utils.Timer;
	import mx.core.IFlexModuleFactory;
	import mx.core.mx_internal;
	import mx.core.Singleton;
	import mx.events.ModuleEvent;
	import mx.events.ResourceEvent;
	import mx.modules.IModuleInfo;
	import mx.modules.ModuleManager;
	import mx.utils.StringUtil;

	/**
	 *  This class is used to get a single instance of the IResourceManager
	 */
	public class ResourceManager
	{
		/**
		 *  @private
		 */
		private static var implClassDependency : ResourceManagerImpl;
		/**
		 *  @private
		 */
		private static var instance : IResourceManager;

		/**
		 *  Gets the single instance of the ResourceManager class.
		 */
		public static function getInstance () : IResourceManager;
		/**
		 *  Constructor.
		 */
		public function ResourceManager ();
	}
}