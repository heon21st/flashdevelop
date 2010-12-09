﻿package fl.transitions.easing
{
	/**
	 *  The Regular class defines three easing functions to implement 
	 */
	public class Regular
	{
		/**
		 * The <code>easeIn()</code> method starts motion from a zero velocity 
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 * The <code>easeOut()</code> method starts motion fast 
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 * The <code>easeInOut()</code> method combines the motion
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number) : Number;
	}
}