﻿package mx.events
{
	import flash.events.Event;
	import mx.effects.IEffectInstance;

	/**
	 *  Represents event objects that are specific to Flex effects. 
	 */
	public class EffectEvent extends Event
	{
		/**
		 *  The <code>EffectEvent.EFFECT_END</code> constant defines the value of the 
		 */
		public static const EFFECT_END : String = "effectEnd";
		/**
		 *  The <code>EffectEvent.EFFECT_START</code> constant defines the value of the 
		 */
		public static const EFFECT_START : String = "effectStart";
		/**
		 *  The effect instance object for the event.
		 */
		public var effectInstance : IEffectInstance;

		/**
		 *  Constructor.
		 */
		public function EffectEvent (eventType:String, bubbles:Boolean = false, cancelable:Boolean = false, effectInstance:IEffectInstance = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}