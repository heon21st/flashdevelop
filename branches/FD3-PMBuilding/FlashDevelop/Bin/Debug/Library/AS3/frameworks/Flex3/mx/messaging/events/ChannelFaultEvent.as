﻿package mx.messaging.events
{
	import flash.events.Event;
	import mx.messaging.Channel;
	import mx.messaging.messages.ErrorMessage;

	/**
	 *  The ChannelFaultEvent class is used to propagate channel fault events within the messaging system.
	 */
	public class ChannelFaultEvent extends ChannelEvent
	{
		/**
		 *  The FAULT event type; indicates that the Channel faulted.
		 */
		public static const FAULT : String = "channelFault";
		/**
		 *  Provides access to the destination-specific failure code. For more 
		 */
		public var faultCode : String;
		/**
		 *  Provides destination-specific details of the failure.
		 */
		public var faultDetail : String;
		/**
		 *  Provides access to the destination-specific reason for the failure.
		 */
		public var faultString : String;
		/**
		 * Provides access to the underlying reason for the failure if the channel did
		 */
		public var rootCause : Object;

		/**
		 *  Utility method to create a new ChannelFaultEvent that doesn't bubble and
		 */
		public static function createEvent (channel:Channel, reconnecting:Boolean = false, code:String = null, level:String = null, description:String = null, rejected:Boolean = false, connected:Boolean = false) : ChannelFaultEvent;
		/**
		 *  Constructs an instance of this event with the specified type.
		 */
		public function ChannelFaultEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, channel:Channel = null, reconnecting:Boolean = false, code:String = null, level:String = null, description:String = null, rejected:Boolean = false, connected:Boolean = false);
		/**
		 *  Clones the ChannelFaultEvent.
		 */
		public function clone () : Event;
		/**
		 *  Returns a string representation of the ChannelFaultEvent.
		 */
		public function toString () : String;
		/**
		 *  Creates an ErrorMessage based on the ChannelFaultEvent by copying over
		 */
		public function createErrorMessage () : ErrorMessage;
	}
}