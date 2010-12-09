﻿package fl.video
{
	import flash.events.Event;
	import flash.media.SoundTransform;

	/**
	 * Flash<sup>&#xAE;</sup> Player dispatches a SoundEvent object when the user changes 
	 */
	public class SoundEvent extends Event
	{
		/**
		 * Defines the value of the <code>type</code> 
		 */
		public static const SOUND_UPDATE : String = "soundUpdate";
		private var _soundTransform : SoundTransform;

		/**
		 * Indicates new values for volume and panning.
		 */
		public function get soundTransform () : SoundTransform;

		/**
		 * Creates an Event object that contains information about sound events. 
		 */
		public function SoundEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, soundTransform:SoundTransform = null);
		/**
		 * @private
		 */
		public function clone () : Event;
	}
}