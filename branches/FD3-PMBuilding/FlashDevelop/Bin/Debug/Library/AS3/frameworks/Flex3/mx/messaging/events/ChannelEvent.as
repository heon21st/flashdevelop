﻿package mx.messaging.events
{
	import flash.events.Event;
	import mx.messaging.Channel;

	/**
	 *  The ChannelEvent is used to propagate channel events within the messaging system.
	 */
	public class ChannelEvent extends Event
	{
		/**
		 *  The CONNECT event type; indicates that the Channel connected to its
		 */
		public static const CONNECT : String = "channelConnect";
		/**
		 *  The DISCONNECT event type; indicates that the Channel disconnected from its
		 */
		public static const DISCONNECT : String = "channelDisconnect";
		/**
		 *  The Channel that generated this event.
		 */
		public var channel : Channel;
		/**
		 * Indicates whether the Channel that generated this event is already connected.
		 */
		public var connected : Boolean;
		/**
		 *  Indicates whether the Channel that generated this event is reconnecting.
		 */
		public var reconnecting : Boolean;
		/**
		 *  Indicates whether the Channel that generated this event was rejected. 
		 */
		public var rejected : Boolean;

		/**
		 * @private
		 */
		public function get channelId () : String;

		/**
		 *  Utility method to create a new ChannelEvent that doesn't bubble and
		 */
		public static function createEvent (type:String, channel:Channel = null, reconnecting:Boolean = false, rejected:Boolean = false, connected:Boolean = false) : ChannelEvent;
		/**
		 *  Constructs an instance of this event with the specified type and Channel
		 */
		public function ChannelEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, channel:Channel = null, reconnecting:Boolean = false, rejected:Boolean = false, connected:Boolean = false);
		/**
		 *  Clones the ChannelEvent.
		 */
		public function clone () : Event;
		/**
		 *  Returns a string representation of the ChannelEvent.
		 */
		public function toString () : String;
	}
}