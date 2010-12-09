﻿package mx.messaging
{
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	import mx.messaging.channels.NetConnectionChannel;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.errors.NoChannelAvailableError;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.AbstractEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.Base64Encoder;
	import mx.core.mx_internal;
	import mx.messaging.ChannelSet;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.logging.Log;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.rpc.AsyncToken;

	/**
	 *  Dispatched after a Channel in the ChannelSet has connected to its endpoint.
	 */
	[Event(name="channelConnect", type="mx.messaging.events.ChannelEvent")] 
	/**
	 *  Dispatched after a Channel in the ChannelSet has disconnected from its 
	 */
	[Event(name="channelDisconnect", type="mx.messaging.events.ChannelEvent")] 
	/**
	 *  Dispatched after a Channel in the ChannelSet has faulted.
	 */
	[Event(name="channelFault", type="mx.messaging.events.ChannelFaultEvent")] 
	/**
	 * The result event is dispatched when a login or logout call successfully returns.
	 */
	[Event(name="result", type="mx.rpc.events.ResultEvent")] 
	/**
	 * The fault event is dispatched when a login or logout call fails.
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")] 
	/**
	 *  Dispatched when a property of the ChannelSet changes.
	 */
	[Event(name="propertyChange", type="mx.events.PropertyChangeEvent")] 

	/**
	 *  The ChannelSet is a set of Channels that are used to send messages to a
	 */
	public class ChannelSet extends EventDispatcher
	{
		/**
		 *  @private
		 */
		private var _authAgent : AuthenticationAgent;
		/**
		 *  @private
		 */
		private var _connecting : Boolean;
		/**
		 *  @private
		 */
		private var _credentials : String;
		/**
		 *  @private
		 */
		private var _credentialsCharset : String;
		/**
		 *  @private
		 */
		private var _currentChannelIndex : int;
		/**
		 *  @private
		 */
		private var _hasRequestedClusterEndpoints : Boolean;
		/**
		 *  @private
		 */
		private var _hunting : Boolean;
		/**
		 *  @private
		 */
		private var _pendingMessages : Dictionary;
		/**
		 *  @private
		 */
		private var _pendingSends : Array;
		/**
		 *  @private
		 */
		private var _reconnectTimer : Timer;
		/**
		 *  @private
		 */
		private var _shouldBeConnected : Boolean;
		/**
		 *  @private
		 */
		private var _shouldHunt : Boolean;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _authenticated : Boolean;
		/**
		 *  @private
		 */
		private var _channels : Array;
		/**
		 *  @private
		 */
		private var _channelIds : Array;
		/**
		 *  @private
		 */
		private var _currentChannel : Channel;
		/**
		 *  @private
		 */
		private var _channelFailoverURIs : Object;
		/**
		 *  @private
		 */
		private var _configured : Boolean;
		/**
		 *  @private
		 */
		private var _connected : Boolean;
		/**
		 *  @private
		 */
		private var _clustered : Boolean;
		/**
		 *  @private
		 */
		private var _initialDestinationId : String;
		/**
		 *  @private
		 */
		private var _messageAgents : Array;

		/**
		 *  Indicates whether the ChannelSet has an underlying Channel that successfully
		 */
		public function get authenticated () : Boolean;
		/**
		 *  Provides access to the Channels in the ChannelSet.
		 */
		public function get channels () : Array;
		/**
		 *  @private
		 */
		public function set channels (values:Array) : void;
		/**
		 *  The ids of the Channels used by the ChannelSet.
		 */
		public function get channelIds () : Array;
		/**
		 *  Returns the current Channel for the ChannelSet.
		 */
		public function get currentChannel () : Channel;
		/**
		 *  @private
		 */
		function get channelFailoverURIs () : Object;
		/**
		 *  @private
		 */
		function set channelFailoverURIs (value:Object) : void;
		/**
		 *  Indicates whether the ChannelSet is using automatically configured 
		 */
		function get configured () : Boolean;
		/**
		 *  Indicates whether the ChannelSet is connected.
		 */
		public function get connected () : Boolean;
		/**
		 *  Indicates whether the ChannelSet targets a clustered destination. 
		 */
		public function get clustered () : Boolean;
		/**
		 *  @private
		 */
		public function set clustered (value:Boolean) : void;
		/**
		 *  Provides access to the initial destination this ChannelSet is used to access.
		 */
		public function get initialDestinationId () : String;
		/**
		 *  @private
		 */
		public function set initialDestinationId (value:String) : void;
		/**
		 *  Provides access to the set of MessageAgents that use this ChannelSet.
		 */
		public function get messageAgents () : Array;

		/**
		 *  Constructs a ChannelSet. 
		 */
		public function ChannelSet (channelIds:Array = null, clusteredWithURLLoadBalancing:Boolean = false);
		/**
		 *  @private
		 */
		function setAuthenticated (value:Boolean, creds:String, notifyAgents:Boolean = true) : void;
		/**
		 *  @private
		 */
		protected function setConnected (value:Boolean) : void;
		/**
		 *  Returns a String containing the ids of the Channels in the ChannelSet.
		 */
		public function toString () : String;
		/**
		 *  Adds a Channel to the ChannelSet. A Channel with a null id cannot be added 
		 */
		public function addChannel (channel:Channel) : void;
		/**
		 *  Removes a Channel from the ChannelSet. If the Channel to remove is 
		 */
		public function removeChannel (channel:Channel) : void;
		/**
		 *  Connects a MessageAgent to the ChannelSet. Once connected, the agent
		 */
		public function connect (agent:MessageAgent) : void;
		/**
		 *  Disconnects a specific MessageAgent from the ChannelSet. If this is the
		 */
		public function disconnect (agent:MessageAgent) : void;
		/**
		 *  Disconnects all associated MessageAgents and disconnects any underlying Channel that
		 */
		public function disconnectAll () : void;
		/**
		 *  Handles a CONNECT ChannelEvent and redispatches the event.
		 */
		public function channelConnectHandler (event:ChannelEvent) : void;
		/**
		 *  Handles a DISCONNECT ChannelEvent and redispatches the event.
		 */
		public function channelDisconnectHandler (event:ChannelEvent) : void;
		/**
		 *  Handles a ChannelFaultEvent and redispatches the event.
		 */
		public function channelFaultHandler (event:ChannelFaultEvent) : void;
		/**
		 *  Authenticates the ChannelSet with the server using the provided credentials.
		 */
		public function login (username:String, password:String, charset:String = null) : AsyncToken;
		/**
		 *  Logs the ChannelSet out from the server. Unlike other operations on Channels
		 */
		public function logout (agent:MessageAgent = null) : AsyncToken;
		/**
		 *  Sends a message from a MessageAgent over the currently connected Channel.
		 */
		public function send (agent:MessageAgent, message:IMessage) : void;
		/**
		 *  Stores the credentials and passes them through to every connected channel.
		 */
		public function setCredentials (credentials:String, agent:MessageAgent, charset:String = null) : void;
		/**
		 *  @private
		 */
		function authenticationSuccess (agent:AuthenticationAgent, token:AsyncToken, ackMessage:AcknowledgeMessage) : void;
		/**
		 *  @private
		 */
		function authenticationFailure (agent:AuthenticationAgent, token:AsyncToken, faultMessage:ErrorMessage) : void;
		/**
		 *  @private
		 */
		private function connectChannel () : void;
		/**
		 *  @private
		 */
		private function disconnectChannel () : void;
		/**
		 *  @private
		 */
		private function dispatchRPCEvent (event:AbstractEvent) : void;
		/**
		 *  @private
		 */
		private function messageHandler (event:MessageEvent) : void;
		/**
		 *  @private
		 */
		private function hunt () : Boolean;
		/**
		 *  @private
		 */
		private function reconnectChannel (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		private function faultPendingSends (event:ChannelEvent) : void;
	}
	/**
	 *  @private
	 */
	internal class ClusterMessageResponder extends MessageResponder
	{
		/**
		 *  @private
		 */
		private var _channelSet : ChannelSet;

		/**
		 *  Constructor.
		 */
		public function ClusterMessageResponder (message:IMessage, channelSet:ChannelSet);
		/**
		 *  Handles a cluster message response.
		 */
		protected function resultHandler (message:IMessage) : void;
	}
	/**
	 *  @private
	 */
	internal class PendingSend
	{
		/**
		 *  @private
		 */
		public var agent : MessageAgent;
		/**
		 *  @private
		 */
		public var message : IMessage;

		/**
		 *  @private
		 */
		public function PendingSend (agent:MessageAgent, message:IMessage);
	}
	/**
	 *  @private
	 */
	internal class AuthenticationAgent extends MessageAgent
	{
		public static const LOGGED_OUT_STATE : int = 0;
		public static const LOGGING_IN_STATE : int = 1;
		public static const LOGGED_IN_STATE : int = 2;
		public static const LOGGING_OUT_STATE : int = 3;
		public static const SHUTDOWN_STATE : int = 4;
		/**
		 * Map of login/logout message Ids to associated tokens.
		 */
		private var tokens : Object;
		private var _state : int;

		/**
		 * Returns the current state for the agent.
		 */
		public function get state () : int;
		public function set state (value:int) : void;

		/**
		 *  Constructor.
		 */
		public function AuthenticationAgent (channelSet:ChannelSet);
		/**
		 * Registers an outbound login/logout message and its associated token for response/fault handling.
		 */
		public function registerToken (token:AsyncToken) : void;
		/**
		 * Acknowledge message callback.
		 */
		public function acknowledge (ackMsg:AcknowledgeMessage, msg:IMessage) : void;
		/**
		 * Fault callback.
		 */
		public function fault (errMsg:ErrorMessage, msg:IMessage) : void;
	}
}