﻿package mx.effects.effectClasses
{
	import mx.styles.StyleManager;
	import mx.core.mx_internal;

	/**
	 *  The SetStyleActionInstance class implements the instance class
	 */
	public class SetStyleActionInstance extends ActionEffectInstance
	{
		/**
		 *  The name of the style property being changed.
		 */
		public var name : String;
		/**
		 *  @private
		 */
		private var _value : *;

		/**
		 *  The new value for the property.
		 */
		public function get value () : *;
		/**
		 *  @private
		 */
		public function set value (val:*) : void;

		/**
		 *  Constructor.
		 */
		public function SetStyleActionInstance (target:Object);
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		protected function saveStartValue () : *;
	}
}