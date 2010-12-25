﻿package mx.events
{
	import flash.events.Event;
	import mx.core.mx_internal;

	/**
	 *  The MetadataEvent class defines the event type for metadata and cue point events.
	 */
	public class MetadataEvent extends Event
	{
		/**
		 * The MetadataEvent.METADATA_RECEIVED constant defines the value of the 
		 */
		public static const METADATA_RECEIVED : String = "metadataReceived";
		/**
		 *  The MetadataEvent.CUE_POINT constant defines the value of the 
		 */
		public static const CUE_POINT : String = "cuePoint";
		/**
		 *  @private
		 */
		static const NAVIGATION : String = "navigation";
		/**
		 *  @private
		 */
		static const EVENT : String = "event";
		/**
		 *  The MetadataEvent.ACTION_SCRIPT constant defines the value of the 
		 */
		public static const ACTION_SCRIPT : String = "actionscript";
		/**
		 *  For events off type <code>ACTION_SCRIPT</code> and <code>CUE_POINT</code>, 
		 */
		public var info : Object;

		/**
		 *  Constructor. 
		 */
		public function MetadataEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, info:Object = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}