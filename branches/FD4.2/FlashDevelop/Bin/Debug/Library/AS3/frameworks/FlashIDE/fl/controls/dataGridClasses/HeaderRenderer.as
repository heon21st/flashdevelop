﻿package fl.controls.dataGridClasses
{
	import fl.controls.ButtonLabelPlacement;
	import fl.controls.LabelButton;
	import fl.core.UIComponent;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @copy fl.controls.LabelButton#style:selectedDisabledSkin
	 */
	[Style(name="selectedDisabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:selectedUpSkin
	 */
	[Style(name="selectedUpSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:selectedDownSkin
	 */
	[Style(name="selectedDownSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:selectedOverSkin
	 */
	[Style(name="selectedOverSkin", type="Class")] 

	/**
	 * The HeaderRenderer class displays the column header for the current 
	 */
	public class HeaderRenderer extends LabelButton
	{
		/**
		 * @private
		 */
		public var _column : uint;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;

		/**
		 * The index of the column that belongs to this HeaderRenderer instance.
		 */
		public function get column () : uint;
		/**
		 * @private (setter)
		 */
		public function set column (value:uint) : void;

		/**
		 * Creates a new HeaderRenderer instance.
		 */
		public function HeaderRenderer ();
		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
	}
}