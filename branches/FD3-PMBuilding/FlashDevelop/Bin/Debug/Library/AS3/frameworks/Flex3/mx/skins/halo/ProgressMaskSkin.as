﻿package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;

	/**
	 *  The skin for the mask of the ProgressBar's determinate and indeterminate bars.
	 */
	public class ProgressMaskSkin extends ProgrammaticSkin
	{
		/**
		 *  Constructor.
		 */
		public function ProgressMaskSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}