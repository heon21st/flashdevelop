﻿package fl.controls
{
	import fl.controls.ButtonLabelPlacement;
	import fl.controls.LabelButton;
	import fl.core.UIComponent;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Shape;
	import Error;

	/**
	 *  @copy fl.controls.LabelButton#style:icon
	 */
	[Style(name="icon", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:upIcon
	 */
	[Style(name="upIcon", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:downIcon
	 */
	[Style(name="downIcon", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:overIcon
	 */
	[Style(name="overIcon", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:disabledIcon
	 */
	[Style(name="disabledIcon", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:selectedDisabledIcon
	 */
	[Style(name="selectedDisabledIcon", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:selectedUpIcon
	 */
	[Style(name="selectedUpIcon", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:selectedDownIcon
	 */
	[Style(name="selectedDownIcon", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:selectedOverIcon
	 */
	[Style(name="selectedOverIcon", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:textPadding
	 */
	[Style(name="textPadding", type="Number", format="Length")] 

	/**
	 *  The CheckBox component displays a small box that can contain 
	 */
	public class CheckBox extends LabelButton
	{
		/**
		 * @private
		 */
		private static var defaultStyles : Object;
		/**
		 *  @private
		 */
		public static var createAccessibilityImplementation : Function;

		/**
		 * A CheckBox toggles by definition, so the <code>toggle</code> property is set to 
		 */
		public function get toggle () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set toggle (value:Boolean) : void;
		/**
		 * A CheckBox never auto-repeats by definition, so the <code>autoRepeat</code> property is set 
		 */
		public function get autoRepeat () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set autoRepeat (value:Boolean) : void;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * Creates a new CheckBox component instance.
		 */
		public function CheckBox ();
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
		/**
		 * @private (protected)
		 */
		protected function drawBackground () : void;
		/**
		 * Shows or hides the focus indicator around this component.
		 */
		public function drawFocus (focused:Boolean) : void;
		/**
		 * @private (protected)
		 */
		protected function initializeAccessibility () : void;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
	}
}