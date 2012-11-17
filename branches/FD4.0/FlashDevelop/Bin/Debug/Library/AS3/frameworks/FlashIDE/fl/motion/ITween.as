﻿package fl.motion
{
	/**
	 * The ITween interface defines the application programming interface (API) that interpolation
	 */
	public interface ITween
	{
		/**
		 * The name of the animation property to target.
		 */
		public function get target () : String;
		/**
		 * @private (setter)
		 */
		public function set target (value:String) : void;

		/**
		 * Calculates an interpolated value for a numerical property of animation.
		 */
		public function getValue (time:Number, begin:Number, change:Number, duration:Number) : Number;
	}
}