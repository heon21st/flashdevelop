﻿package mx.effects
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.effects.effectClasses.AddRemoveEffectTargetFilter;
	import mx.effects.effectClasses.HideShowEffectTargetFilter;
	import mx.effects.effectClasses.PropertyChanges;
	import mx.events.EffectEvent;
	import mx.managers.LayoutManager;

	/**
	 *  Dispatched when the effect finishes playing,
	 */
	[Event(name="effectEnd", type="mx.events.EffectEvent")] 
	/**
	 *  Dispatched when the effect starts playing.
	 */
	[Event(name="effectStart", type="mx.events.EffectEvent")] 

	/**
	 *  The Effect class is an abstract base class that defines the basic 
	 */
	public class Effect extends EventDispatcher implements IEffect
	{
		/**
		 *  @private
		 */
		private var _instances : Array;
		/**
		 *  @private
		 */
		private var _callValidateNow : Boolean;
		/**
		 *  @private
		 */
		private var isPaused : Boolean;
		/**
		 *  @private
		 */
		local var filterObject : EffectTargetFilter;
		/**
		 *  @private
		 */
		local var applyActualDimensions : Boolean;
		/**
		 *  @private
		 */
		local var propertyChangesArray : Array;
		/**
		 *  @private
		 */
		private var _customFilter : EffectTargetFilter;
		/**
		 *  @private
		 */
		private var _duration : Number;
		/**
		 *  @private
		 */
		local var durationExplicitlySet : Boolean;
		/**
		 *  @private
		 */
		private var _effectTargetHost : IEffectTargetHost;
		/**
		 *  A flag containing <code>true</code> if the end values
		 */
		protected var endValuesCaptured : Boolean;
		/**
		 *  @private
		 */
		private var _filter : String;
		/**
		 *  @private
		 */
		private var _hideFocusRing : Boolean;
		/**
		 *  An object of type Class that specifies the effect
		 */
		public var instanceClass : Class;
		/**
		 *  @private
		 */
		private var _perElementOffset : Number;
		/**
		 *  @private
		 */
		private var _relevantProperties : Array;
		/**
		 *  @private
		 */
		private var _relevantStyles : Array;
		/**
		 *  Number of times to repeat the effect.
		 */
		public var repeatCount : int;
		/**
		 *  Amount of time, in milliseconds, to wait before repeating the effect.
		 */
		public var repeatDelay : int;
		/**
		 *  Amount of time, in milliseconds, to wait before starting the effect.
		 */
		public var startDelay : int;
		/**
		 *  If <code>true</code>, blocks all background processing
		 */
		public var suspendBackgroundProcessing : Boolean;
		/**
		 *  @private
		 */
		private var _targets : Array;
		/**
		 *  @private
		 */
		private var _triggerEvent : Event;

		/**
		 *  @copy mx.effects.IEffect#className
		 */
		public function get className () : String;
		/**
		 *  @copy mx.effects.IEffect#customFilter
		 */
		public function get customFilter () : EffectTargetFilter;
		/**
		 *  @private
		 */
		public function set customFilter (value:EffectTargetFilter) : void;
		/**
		 *  @copy mx.effects.IEffect#duration
		 */
		public function get duration () : Number;
		/**
		 *  @private
		 */
		public function set duration (value:Number) : void;
		/**
		 *  @copy mx.effects.IEffect#effectTargetHost
		 */
		public function get effectTargetHost () : IEffectTargetHost;
		/**
		 *  @private
		 */
		public function set effectTargetHost (value:IEffectTargetHost) : void;
		/**
		 *  @copy mx.effects.IEffect#filter
		 */
		public function get filter () : String;
		/**
		 *  @private
		 */
		public function set filter (value:String) : void;
		/**
		 *  @copy mx.effects.IEffect#hideFocusRing
		 */
		public function get hideFocusRing () : Boolean;
		/**
		 *  @private
		 */
		public function set hideFocusRing (value:Boolean) : void;
		/**
		 *  @copy mx.effects.IEffect#isPlaying
		 */
		public function get isPlaying () : Boolean;
		/**
		 *  @copy mx.effects.IEffect#perElementOffset
		 */
		public function get perElementOffset () : Number;
		/**
		 *  @private
		 */
		public function set perElementOffset (value:Number) : void;
		/**
		 *  @copy mx.effects.IEffect#relevantProperties
		 */
		public function get relevantProperties () : Array;
		/**
		 *  @private
		 */
		public function set relevantProperties (value:Array) : void;
		/**
		 *  @copy mx.effects.IEffect#relevantStyles
		 */
		public function get relevantStyles () : Array;
		/**
		 *  @private
		 */
		public function set relevantStyles (value:Array) : void;
		/**
		 *  @copy mx.effects.IEffect#target
		 */
		public function get target () : Object;
		/**
		 *  @private
		 */
		public function set target (value:Object) : void;
		/**
		 *  @copy mx.effects.IEffect#targets
		 */
		public function get targets () : Array;
		/**
		 *  @private
		 */
		public function set targets (value:Array) : void;
		/**
		 *  @copy mx.effects.IEffect#triggerEvent
		 */
		public function get triggerEvent () : Event;
		/**
		 *  @private
		 */
		public function set triggerEvent (value:Event) : void;

		/**
		 *  @private
		 */
		private static function mergeArrays (a1:Array, a2:Array) : Array;
		/**
		 *  @private
		 */
		private static function stripUnchangedValues (propChanges:Array) : Array;
		/**
		 *  Constructor.
		 */
		public function Effect (target:Object = null);
		/**
		 *  @copy mx.effects.IEffect#getAffectedProperties()
		 */
		public function getAffectedProperties () : Array;
		/**
		 *  @copy mx.effects.IEffect#createInstances()
		 */
		public function createInstances (targets:Array = null) : Array;
		/**
		 *  @copy mx.effects.IEffect#createInstance()
		 */
		public function createInstance (target:Object = null) : IEffectInstance;
		/**
		 *  Copies properties of the effect to the effect instance. 
		 */
		protected function initInstance (instance:IEffectInstance) : void;
		/**
		 *  @copy mx.effects.IEffect#deleteInstance()
		 */
		public function deleteInstance (instance:IEffectInstance) : void;
		/**
		 *  @copy mx.effects.IEffect#play()
		 */
		public function play (targets:Array = null, playReversedFromEnd:Boolean = false) : Array;
		/**
		 *  @copy mx.effects.IEffect#pause()
		 */
		public function pause () : void;
		/**
		 *  @copy mx.effects.IEffect#stop()
		 */
		public function stop () : void;
		/**
		 *  @copy mx.effects.IEffect#resume()
		 */
		public function resume () : void;
		/**
		 *  @copy mx.effects.IEffect#reverse()
		 */
		public function reverse () : void;
		/**
		 *  @copy mx.effects.IEffect#end()
		 */
		public function end (effectInstance:IEffectInstance = null) : void;
		/**
		 *  Determines the logic for filtering out an effect instance.
		 */
		protected function filterInstance (propChanges:Array, target:Object) : Boolean;
		/**
		 *  @copy mx.effects.IEffect#captureStartValues()
		 */
		public function captureStartValues () : void;
		/**
		 *  @copy mx.effects.IEffect#captureMoreStartValues()
		 */
		public function captureMoreStartValues (targets:Array) : void;
		/**
		 *  @copy mx.effects.IEffect#captureEndValues()
		 */
		public function captureEndValues () : void;
		/**
		 *  @private
		 */
		function captureValues (propChanges:Array, setStartValues:Boolean) : Array;
		/**
		 *  Called by the <code>captureStartValues()</code> method to get the value
		 */
		protected function getValueFromTarget (target:Object, property:String) : *;
		/**
		 *  @private
		 */
		function applyStartValues (propChanges:Array, targets:Array) : void;
		/**
		 *  Used internally by the Effect infrastructure.
		 */
		protected function applyValueToTarget (target:Object, property:String, value:*, props:Object) : void;
		/**
		 *  This method is called when the effect instance starts playing. 
		 */
		protected function effectStartHandler (event:EffectEvent) : void;
		/**
		 *  Called when an effect instance has finished playing. 
		 */
		protected function effectEndHandler (event:EffectEvent) : void;
	}
}