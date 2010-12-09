﻿package mx.rpc
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.describeType;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import mx.core.mx_internal;
	import mx.messaging.ChannelSet;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.events.AbstractEvent;
	import mx.utils.ObjectUtil;

	/**
	 * The invoke event is dispatched when a service Operation is invoked so long as
	 */
	[Event(name="invoke", type="mx.rpc.events.InvokeEvent")] 
	/**
	 * The result event is dispatched when a service call successfully returns and
	 */
	[Event(name="result", type="mx.rpc.events.ResultEvent")] 
	/**
	 * The fault event is dispatched when a service call fails and isn't handled by
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")] 

	/**
	 * The AbstractService class is the base class for the WebService and
	 */
	flash_proxy dynamic class AbstractService extends Proxy implements IEventDispatcher
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 * @private
		 */
		local var _operations : Object;
		private var nextNameArray : Array;
		local var _availableChannelIds : Array;
		local var asyncRequest : AsyncRequest;
		private var eventDispatcher : EventDispatcher;

		/**
		 *  Provides access to the ChannelSet used by the service. The
		 */
		public function get channelSet () : ChannelSet;
		/**
		 *  @private
		 */
		public function set channelSet (value:ChannelSet) : void;
		/**
		 * The destination of the service. This value should match a destination
		 */
		public function get destination () : String;
		public function set destination (name:String) : void;
		/**
		 * @private
		 */
		public function get operations () : Object;
		/**
		 * The Operations array is usually only set by the MXML compiler if you
		 */
		public function set operations (ops:Object) : void;
		/**
		 *  Provides access to the request timeout in seconds for sent messages. 
		 */
		public function get requestTimeout () : int;
		/**
		 *  @private
		 */
		public function set requestTimeout (value:int) : void;

		/**
		 *  Constructor.
		 */
		public function AbstractService (destination:String = null);
		/**
		 * @private
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;
		/**
		 * @private
		 */
		public function dispatchEvent (event:Event) : Boolean;
		/**
		 * @private
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;
		/**
		 * @private
		 */
		public function hasEventListener (type:String) : Boolean;
		/**
		 * @private
		 */
		public function willTrigger (type:String) : Boolean;
		/**
		 * @private
		 */
		flash_proxy function getProperty (name:*) : *;
		/**
		 * @private
		 */
		flash_proxy function setProperty (name:*, value:*) : void;
		/**
		 * @private
		 */
		flash_proxy function callProperty (name:*, ...args:Array) : *;
		/**
		 * @private
		 */
		flash_proxy function nextNameIndex (index:int) : int;
		/**
		 * @private
		 */
		flash_proxy function nextName (index:int) : String;
		/**
		 * @private
		 */
		flash_proxy function nextValue (index:int) : *;
		function getLocalName (name:Object) : String;
		/**
		 * Returns an Operation of the given name. If the Operation wasn't
		 */
		public function getOperation (name:String) : AbstractOperation;
		/**
		 *  Disconnects the service's network connection and removes any pending
		 */
		public function disconnect () : void;
		/**
		 * Sets the credentials for the destination accessed by the service when using Data Services on the server side.
		 */
		public function setCredentials (username:String, password:String, charset:String = null) : void;
		/**
		 * Logs the user out of the destination. 
		 */
		public function logout () : void;
		/**
		 * The username and password to be used to authenticate a user when
		 */
		public function setRemoteCredentials (remoteUsername:String, remotePassword:String, charset:String = null) : void;
		/**
		 * Returns this service.
		 */
		public function valueOf () : Object;
		/**
		 * @private
		 */
		function hasTokenResponders (event:Event) : Boolean;
	}
}