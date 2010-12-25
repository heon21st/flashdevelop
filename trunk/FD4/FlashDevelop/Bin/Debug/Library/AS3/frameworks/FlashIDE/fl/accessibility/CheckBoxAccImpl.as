﻿package fl.accessibility
{
	import fl.controls.LabelButton;
	import fl.controls.CheckBox;
	import fl.core.UIComponent;

	/**
	 *  The CheckBoxAccImpl class, also called the CheckBox Accessibility Implementation class,
	 */
	public class CheckBoxAccImpl extends LabelButtonAccImpl
	{
		/**
		 *  @private
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_CHECKED : uint = 0x00000010;

		/**
		 *  @private
		 */
		private static function hookAccessibility () : Boolean;
		/**
		 *  @private
		 */
		public static function createAccessibilityImplementation (component:UIComponent) : void;
		/**
		 *  Enables accessibility for a CheckBox component.
		 */
		public static function enableAccessibility () : void;
		/**
		 * @private
		 */
		public function CheckBoxAccImpl (component:UIComponent);
		/**
		 *  @private
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private
		 */
		public function get_accDefaultAction (childID:uint) : String;
	}
}