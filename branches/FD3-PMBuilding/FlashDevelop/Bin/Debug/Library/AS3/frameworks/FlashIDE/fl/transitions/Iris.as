﻿package fl.transitions
{
	import flash.display.MovieClip;
	import flash.geom.*;

	/**
	 * The Iris class reveals the movie clip object by using an animated mask of a square shape or a 
	 */
	public class Iris extends Transition
	{
		/**
		 * Used to specify a square mask shape for the transition effect.
		 */
		public static const SQUARE : String = "SQUARE";
		/**
		 * Used to specify a circle mask shape for the transition effect.
		 */
		public static const CIRCLE : String = "CIRCLE";
		/**
		 * @private
		 */
		protected var _mask : MovieClip;
		/**
		 * @private
		 */
		protected var _startPoint : uint;
		/**
		 * @private
		 */
		protected var _cornerMode : Boolean;
		/**
		 * @private
		 */
		protected var _shape : String;
		/**
		 * @private
		 */
		protected var _maxDimension : Number;
		/**
		 * @private
		 */
		protected var _minDimension : Number;
		/**
		 * @private
		 */
		protected var _renderFunction : Function;

		/**
		 * @private
		 */
		public function get type () : Class;

		/**
		 * @private
		 */
		function Iris (content:MovieClip, transParams:Object, manager:TransitionManager);
		/**
		 * @private
		 */
		public function start () : void;
		/**
		 * @private
		 */
		public function cleanUp () : void;
		/**
		 * @private
		 */
		protected function _initMask () : void;
		/**
		 * @private stub--dynamically overwritten by one of the other render methods
		 */
		protected function _render (p:Number) : void;
		/**
		 * @private
		 */
		protected function _renderCircle (p:Number) : void;
		/**
		 * @private
		 */
		protected function _drawQuarterCircle (mc:MovieClip, r:Number) : void;
		/**
		 * @private
		 */
		protected function _drawHalfCircle (mc:MovieClip, r:Number) : void;
		/**
		 * @private
		 */
		protected function _renderSquareEdge (p:Number) : void;
		/**
		 * @private
		 */
		protected function _renderSquareCorner (p:Number) : void;
	}
}