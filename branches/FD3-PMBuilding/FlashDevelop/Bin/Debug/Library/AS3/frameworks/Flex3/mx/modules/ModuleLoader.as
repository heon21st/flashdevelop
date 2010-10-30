﻿package mx.modules
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import mx.containers.VBox;
	import mx.core.IDeferredInstantiationUIComponent;
	import mx.events.FlexEvent;
	import mx.events.ModuleEvent;

	/**
	 *  Dispatched when the ModuleLoader starts to load a URL.
	 */
	[Event(name="loading", type="flash.events.Event")] 
	/**
	 *  Dispatched when the ModuleLoader is given a new URL.
	 */
	[Event(name="urlChanged", type="flash.events.Event")] 
	/**
	 *  Dispatched when information about the module is 
	 */
	[Event(name="setup", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched when the module is finished loading.
	 */
	[Event(name="ready", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched when the module throws an error.
	 */
	[Event(name="error", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched at regular intervals as the module loads.
	 */
	[Event(name="progress", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched when the module data is unloaded.
	 */
	[Event(name="unload", type="mx.events.ModuleEvent")] 

	/**
	 *  ModuleLoader is a component that behaves much like a SWFLoader except
	 */
	public class ModuleLoader extends VBox implements IDeferredInstantiationUIComponent
	{
		/**
		 *  @private
		 */
		private var module : IModuleInfo;
		/**
		 *  @private
		 */
		private var loadRequested : Boolean;
		/**
		 *  The application domain to load your module into.
		 */
		public var applicationDomain : ApplicationDomain;
		/**
		 *  The DisplayObject created from the module factory.
		 */
		public var child : DisplayObject;
		/**
		 *  @private
		 */
		private var _url : String;

		/**
		 *  The location of the module, expressed as a URL.
		 */
		public function get url () : String;
		/**
		 *  @private
		 */
		public function set url (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function ModuleLoader ();
		/**
		 *  @private
		 */
		public function createComponentsFromDescriptors (recurse:Boolean = true) : void;
		/**
		 *  Loads the module. When the module is finished loading, the ModuleLoader adds
		 */
		public function loadModule (url:String = null, bytes:ByteArray = null) : void;
		/**
		 *  Unloads the module and sets it to <code>null</code>.
		 */
		public function unloadModule () : void;
		/**
		 *  @private
		 */
		private function moduleProgressHandler (event:ModuleEvent) : void;
		/**
		 *  @private
		 */
		private function moduleSetupHandler (event:ModuleEvent) : void;
		/**
		 *  @private
		 */
		private function moduleReadyHandler (event:ModuleEvent) : void;
		/**
		 *  @private
		 */
		private function moduleErrorHandler (event:ModuleEvent) : void;
		/**
		 *  @private
		 */
		private function moduleUnloadHandler (event:ModuleEvent) : void;
	}
}