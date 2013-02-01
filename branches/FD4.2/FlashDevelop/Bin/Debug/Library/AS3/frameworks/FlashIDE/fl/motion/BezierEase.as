﻿package fl.motion
{
	import flash.geom.Point;

	/**
	 * The BezierEase class provides precise easing control for a motion tween between two keyframes. 
	 */
	public class BezierEase implements ITween
	{
		/**
		 * An ordered collection of points in the custom easing curve.
		 */
		public var points : Array;
		/**
		 * @private
		 */
		private var firstNode : Point;
		/**
		 * @private
		 */
		private var lastNode : Point;
		/**
		 * @private
		 */
		private var _target : String;

		/**
		 * The name of the animation property to target.
		 */
		public function get target () : String;
		/**
		 * @private (setter)
		 */
		public function set target (value:String) : void;

		/**
		 * Constructor for BezierEase instances.
		 */
		function BezierEase (xml:XML = null);
		/**
		 * @private
		 */
		private function parseXML (xml:XML = null) : BezierEase;
		/**
		 * Calculates an interpolated value for a numerical property of animation,
		 */
		public function getValue (time:Number, begin:Number, change:Number, duration:Number) : Number;
	}
}