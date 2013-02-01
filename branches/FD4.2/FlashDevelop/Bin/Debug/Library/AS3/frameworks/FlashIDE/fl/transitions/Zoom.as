﻿package fl.transitions
{
	import flash.display.MovieClip;

	/**
	 * The Zoom class zooms the movie clip object in or out by scaling it in proportion.
	 */
	public class Zoom extends Transition
	{
		/**
		 * @private
		 */
		protected var _scaleXFinal : Number;
		/**
		 * @private
		 */
		protected var _scaleYFinal : Number;

		/**
		 * @private
		 */
		public function get type () : Class;

		/**
		 * @private
		 */
		function Zoom (content:MovieClip, transParams:Object, manager:TransitionManager);
		/**
		 * @private
		 */
		protected function _render (p:Number) : void;
	}
}