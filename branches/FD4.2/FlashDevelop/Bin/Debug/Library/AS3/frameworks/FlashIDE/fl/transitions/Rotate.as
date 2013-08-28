﻿package fl.transitions
{
	import flash.display.*;

	/**
	 * The Rotate class rotates the movie clip object. This effect requires the
	 */
	public class Rotate extends Transition
	{
		/**
		 * @private
		 */
		protected var _rotationFinal : Number;
		/**
		 * @private
		 */
		protected var _degrees : Number;

		/**
		 * @private
		 */
		public function get type () : Class;

		/**
		 * @private
		 */
		function Rotate (content:MovieClip, transParams:Object, manager:TransitionManager);
		/**
		 * @private
		 */
		protected function _render (p:Number) : void;
	}
}