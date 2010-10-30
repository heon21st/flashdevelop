﻿package mx.effects.effectClasses
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import mx.controls.SWFLoader;
	import mx.core.Container;
	import mx.core.FlexShape;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;
	import mx.effects.EffectManager;
	import mx.effects.Tween;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	import mx.events.TweenEvent;

	/**
	 *  The MaskEffectInstance class is an abstract base class 
	 */
	public class MaskEffectInstance extends EffectInstance
	{
		/**
		 *  Contains the effect mask, either the default mask created 
		 */
		protected var effectMask : Shape;
		/**
		 *  The actual size of the effect target, including any drop shadows. 
		 */
		protected var targetVisualBounds : Rectangle;
		/**
		 *  @private
		 */
		private var effectMaskRefCount : Number;
		/**
		 *  @private
		 */
		private var invalidateBorder : Boolean;
		/**
		 *  @private
		 */
		private var moveTween : Tween;
		/**
		 *  @private
		 */
		private var origMask : DisplayObject;
		/**
		 *  @private
		 */
		private var origScrollRect : Rectangle;
		/**
		 *  @private
		 */
		private var scaleTween : Tween;
		/**
		 *  @private
		 */
		private var tweenCount : int;
		/**
		 *  @private
		 */
		private var currentMoveTweenValue : Object;
		/**
		 *  @private
		 */
		private var currentScaleTweenValue : Object;
		/**
		 *  @private
		 */
		private var MASK_NAME : String;
		/**
		 *  @private
		 */
		private var dispatchedStartEvent : Boolean;
		/**
		 *  @private
		 */
		private var useSnapshotBounds : Boolean;
		/**
		 *  @private
		 */
		private var stoppedEarly : Boolean;
		/**
		 *  @private
		 */
		local var persistAfterEnd : Boolean;
		/**
		 *  @private
		 */
		private var _createMaskFunction : Function;
		/**
		 *  Easing function to use for moving the mask.
		 */
		public var moveEasingFunction : Function;
		/**
		 *  Easing function to use for scaling the mask.
		 */
		public var scaleEasingFunction : Function;
		/**
		 *  Initial scaleX for mask.
		 */
		public var scaleXFrom : Number;
		/**
		 *  Ending scaleX for mask.
		 */
		public var scaleXTo : Number;
		/**
		 *  Initial scaleY for mask.
		 */
		public var scaleYFrom : Number;
		/**
		 *  Ending scaleY for mask.
		 */
		public var scaleYTo : Number;
		/**
		 *  @private
		 */
		private var _showTarget : Boolean;
		/**
		 *  @private
		 */
		private var _showExplicitlySet : Boolean;
		/**
		 *  The area where the mask is applied on the target.
		 */
		public var targetArea : Rectangle;
		/**
		 *  Initial position's x coordinate for mask.
		 */
		public var xFrom : Number;
		/**
		 *  Destination position's x coordinate for mask.
		 */
		public var xTo : Number;
		/**
		 *  Initial position's y coordinate for mask.
		 */
		public var yFrom : Number;
		/**
		 *  Destination position's y coordinate for mask.
		 */
		public var yTo : Number;

		/**
		 *  Function called when the effect creates the mask.
		 */
		public function get createMaskFunction () : Function;
		/**
		 *  @private
		 */
		public function set createMaskFunction (value:Function) : void;
		/**
		 *  @private
		 */
		public function get playheadTime () : Number;
		/**
		 *  @private
		 */
		function set playReversed (value:Boolean) : void;
		/**
		 *  Specifies that the target component is becoming visible, 
		 */
		public function get showTarget () : Boolean;
		/**
		 *  @private
		 */
		public function set showTarget (value:Boolean) : void;

		/**
		 *  Constructor. 
		 */
		public function MaskEffectInstance (target:Object);
		/**
		 *  @private
		 */
		public function initEffect (event:Event) : void;
		/**
		 *  @private
		 */
		public function startEffect () : void;
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  Pauses the effect until you call the <code>resume()</code> method.
		 */
		public function pause () : void;
		/**
		 *  @private
		 */
		public function stop () : void;
		/**
		 *  Resumes the effect after it has been paused 
		 */
		public function resume () : void;
		/**
		 *  Plays the effect in reverse,
		 */
		public function reverse () : void;
		/**
		 *  @private
		 */
		public function end () : void;
		/**
		 *  @private
		 */
		public function finishEffect () : void;
		/**
		 *  @private
		 */
		private function initMask () : void;
		/**
		 *  Creates the default mask for the effect.
		 */
		protected function defaultCreateMask (targ:Object, bounds:Rectangle) : Shape;
		/**
		 *  Initializes the <code>move</code> and <code>scale</code>
		 */
		protected function initMaskEffect () : void;
		/**
		 *  @private
		 */
		private function getVisibleBounds (targ:DisplayObject) : Rectangle;
		/**
		 *  Callback method that is called when the x and y position 
		 */
		protected function onMoveTweenUpdate (value:Object) : void;
		/**
		 *  Callback method that is called when the x and y position 
		 */
		protected function onMoveTweenEnd (value:Object) : void;
		/**
		 *  Callback method that is called when the 
		 */
		protected function onScaleTweenUpdate (value:Object) : void;
		/**
		 *  Callback method that is called when the 
		 */
		protected function onScaleTweenEnd (value:Object) : void;
		/**
		 *  @private
		 */
		private function finishTween () : void;
		/**
		 *  @private
		 */
		private function removeMask () : void;
		/**
		 *  @private
		 */
		private function saveTweenValue (moveValue:Object, scaleValue:Object) : void;
		/**
		 *  @private
		 */
		function eventHandler (event:Event) : void;
	}
}