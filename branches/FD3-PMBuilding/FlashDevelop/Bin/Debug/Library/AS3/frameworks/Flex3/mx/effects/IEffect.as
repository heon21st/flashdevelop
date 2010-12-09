﻿package mx.effects
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 *  The IEffect interface defines the base 
	 */
	public interface IEffect extends IAbstractEffect
	{
		/**
		 *  The name of the effect class, such as <code>"Fade"</code>.
		 */
		public function get className () : String;
		/**
		 *  Specifies a custom filter object, of type EffectTargetFilter,
		 */
		public function get customFilter () : EffectTargetFilter;
		/**
		 *  @private
		 */
		public function set customFilter (value:EffectTargetFilter) : void;
		/**
		 *  Duration of the effect in milliseconds. 
		 */
		public function get duration () : Number;
		/**
		 *  @private
		 */
		public function set duration (value:Number) : void;
		/**
		 *  A property that lets you access the target list-based control
		 */
		public function get effectTargetHost () : IEffectTargetHost;
		/**
		 *  @private
		 */
		public function set effectTargetHost (value:IEffectTargetHost) : void;
		/**
		 *  Specifies an algorithm for filtering targets for an effect. 
		 */
		public function get filter () : String;
		/**
		 *  @private
		 */
		public function set filter (value:String) : void;
		/**
		 *  Determines whether the effect should hide the focus ring
		 */
		public function get hideFocusRing () : Boolean;
		/**
		 *  @private
		 */
		public function set hideFocusRing (value:Boolean) : void;
		/**
		 *  A read-only flag which is true if any instances of the effect
		 */
		public function get isPlaying () : Boolean;
		/**
		 *  Additional delay, in milliseconds, for effect targets
		 */
		public function get perElementOffset () : Number;
		/**
		 *  @private
		 */
		public function set perElementOffset (value:Number) : void;
		/**
		 *  An Array of property names to use when performing filtering. 
		 */
		public function get relevantProperties () : Array;
		/**
		 *  @private
		 */
		public function set relevantProperties (values:Array) : void;
		/**
		 *  An Array of style names to use when performing filtering. 
		 */
		public function get relevantStyles () : Array;
		/**
		 *  @private
		 */
		public function set relevantStyles (values:Array) : void;
		/**
		 *  The UIComponent object to which this effect is applied.
		 */
		public function get target () : Object;
		/**
		 *  @private
		 */
		public function set target (value:Object) : void;
		/**
		 *  An Array of UIComponent objects that are targets for the effect.
		 */
		public function get targets () : Array;
		/**
		 *  @private
		 */
		public function set targets (value:Array) : void;
		/**
		 *  The Event object passed to this Effect 
		 */
		public function get triggerEvent () : Event;
		/**
		 *  @private
		 */
		public function set triggerEvent (value:Event) : void;

		/**
		 *  Returns an Array of Strings, where each String is the name
		 */
		public function getAffectedProperties () : Array;
		/**
		 *  Takes an Array of target objects and invokes the 
		 */
		public function createInstances (targets:Array = null) : Array;
		/**
		 *  Creates a single effect instance and initializes it.
		 */
		public function createInstance (target:Object = null) : IEffectInstance;
		/**
		 *  Removes event listeners from an instance
		 */
		public function deleteInstance (instance:IEffectInstance) : void;
		/**
		 *  Begins playing the effect.
		 */
		public function play (targets:Array = null, playReversedFromEnd:Boolean = false) : Array;
		/**
		 *  Pauses the effect until you call the <code>resume()</code> method.
		 */
		public function pause () : void;
		/**
		 *  Stops the effect, leaving the effect targets in their current state.
		 */
		public function stop () : void;
		/**
		 *  Resumes the effect after it has been paused 
		 */
		public function resume () : void;
		/**
		 *  Plays the effect in reverse, if the effect is currently playing,
		 */
		public function reverse () : void;
		/**
		 *  Interrupts an effect that is currently playing,
		 */
		public function end (effectInstance:IEffectInstance = null) : void;
		/**
		 *  Captures the current values of the relevant properties
		 */
		public function captureStartValues () : void;
		/**
		 *  Captures the current values of the relevant properties
		 */
		public function captureMoreStartValues (targets:Array) : void;
		/**
		 *  Captures the current values of the relevant properties
		 */
		public function captureEndValues () : void;
	}
}