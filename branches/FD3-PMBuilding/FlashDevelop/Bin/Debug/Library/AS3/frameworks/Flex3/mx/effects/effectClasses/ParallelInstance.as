﻿package mx.effects.effectClasses
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.IEffectInstance;
	import mx.effects.EffectInstance;

	/**
	 *  The ParallelInstance class implements the instance class
	 */
	public class ParallelInstance extends CompositeEffectInstance
	{
		/**
		 *  @private
		 */
		private var doneEffectQueue : Array;
		/**
		 *  @private
		 */
		private var replayEffectQueue : Array;
		/**
		 *  @private
		 */
		private var isReversed : Boolean;
		/**
		 *  @private
		 */
		private var timer : Timer;

		/**
		 *  @private
		 */
		function get durationWithoutRepeat () : Number;

		/**
		 *  Constructor.
		 */
		public function ParallelInstance (target:Object);
		/**
		 *  @private
		 */
		public function addChildSet (childSet:Array) : void;
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		public function pause () : void;
		/**
		 *  @private
		 */
		public function stop () : void;
		/**
		 *  @private
		 */
		public function resume () : void;
		/**
		 *  @private
		 */
		public function reverse () : void;
		/**
		 *  Interrupts any effects that are currently playing, skips over
		 */
		public function end () : void;
		/**
		 *  Each time a child effect of SequenceInstance or ParallelInstance
		 */
		protected function onEffectEnd (childEffect:IEffectInstance) : void;
		/**
		 *  @private
		 */
		private function startTimer () : void;
		/**
		 *  @private
		 */
		private function stopTimer () : void;
		/**
		 *  @private
		 */
		private function timerHandler (event:TimerEvent) : void;
	}
}