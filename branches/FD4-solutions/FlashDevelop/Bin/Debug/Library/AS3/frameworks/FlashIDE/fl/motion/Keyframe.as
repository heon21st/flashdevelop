﻿package fl.motion
{
	import flash.display.BlendMode;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.*;

	/**
	 * The Keyframe class defines the visual state at a specific time in a motion tween.
	 */
	public class Keyframe extends KeyframeBase
	{
		/**
		 * An array that contains each tween object to be applied to the target object at a particular keyframe.
		 */
		public var tweens : Array;
		/**
		 * A flag that controls whether scale will be interpolated during a tween.
		 */
		public var tweenScale : Boolean;
		/**
		 * Stores the value of the Snap checkbox for motion tweens, which snaps the object to a motion guide. 
		 */
		public var tweenSnap : Boolean;
		/**
		 * Stores the value of the Sync checkbox for motion tweens, which affects graphic symbols only. 
		 */
		public var tweenSync : Boolean;

		public function get tweensLength () : int;

		/**
		 * Constructor for keyframe instances.
		 */
		function Keyframe (xml:XML = null);
		/**
		 * @private
		 */
		private function parseXML (xml:XML = null) : KeyframeBase;
		/**
		 * @private
		 */
		private static function splitNumber (valuesString:String) : Array;
		/**
		 * @private
		 */
		private static function splitUint (valuesString:String) : Array;
		/**
		 * @private
		 */
		private static function splitInt (valuesString:String) : Array;
		/**
		 * Retrieves an ITween object for a specific animation property.
		 */
		public function getTween (target:String = '') : ITween;
		/**
		 * @private
		 */
		protected function hasTween () : Boolean;
	}
}