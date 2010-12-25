﻿package mx.skins.halo
{
	import flash.display.GradientType;
	import mx.core.UIComponent;
	import mx.core.EdgeMetrics;
	import mx.skins.Border;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;

	/**
	 *  The skin for the background of a MenuBar.
	 */
	public class MenuBarBackgroundSkin extends Border
	{
		/**
		 *  @private
		 */
		private static var cache : Object;
		/**
		 *  @private
		 */
		private var _borderMetrics : EdgeMetrics;

		/**
		 *  @private
		 */
		public function get borderMetrics () : EdgeMetrics;
		/**
		 *  @private
		 */
		public function get measuredWidth () : Number;
		/**
		 *  @private
		 */
		public function get measuredHeight () : Number;

		/**
		 *  @private
		 */
		private static function calcDerivedStyles (themeColor:uint, fillColor0:uint, fillColor1:uint) : Object;
		/**
		 *  Constructor.
		 */
		public function MenuBarBackgroundSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}