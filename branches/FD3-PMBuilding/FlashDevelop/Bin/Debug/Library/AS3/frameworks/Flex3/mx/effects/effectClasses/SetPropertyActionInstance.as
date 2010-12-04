﻿package mx.effects.effectClasses
{
	import mx.core.mx_internal;

	/**
	 *  The SetPropertyActionInstance class implements the instance class
	 */
	public class SetPropertyActionInstance extends ActionEffectInstance
	{
		/**
		 *  The name of the property being changed.
		 */
		public var name : String;
		/**
		 *  Storage for the value property.
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
		public function SetPropertyActionInstance (target:Object);
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