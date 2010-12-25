﻿package mx.formatters
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

	/**
	 *  The NumberFormatter class formats a valid number
	 */
	public class NumberFormatter extends Formatter
	{
		/**
		 *  @private
		 */
		private var _decimalSeparatorFrom : String;
		/**
		 *  @private
		 */
		private var decimalSeparatorFromOverride : String;
		/**
		 *  @private
		 */
		private var _decimalSeparatorTo : String;
		/**
		 *  @private
		 */
		private var decimalSeparatorToOverride : String;
		/**
		 *  @private
		 */
		private var _precision : Object;
		/**
		 *  @private
		 */
		private var precisionOverride : Object;
		/**
		 *  @private
		 */
		private var _rounding : String;
		/**
		 *  @private
		 */
		private var roundingOverride : String;
		/**
		 *  @private
		 */
		private var _thousandsSeparatorFrom : String;
		/**
		 *  @private
		 */
		private var thousandsSeparatorFromOverride : String;
		/**
		 *  @private
		 */
		private var _thousandsSeparatorTo : String;
		/**
		 *  @private
		 */
		private var thousandsSeparatorToOverride : String;
		/**
		 *  @private
		 */
		private var _useNegativeSign : Object;
		/**
		 *  @private
		 */
		private var useNegativeSignOverride : Object;
		/**
		 *  @private
		 */
		private var _useThousandsSeparator : Object;
		/**
		 *  @private
		 */
		private var useThousandsSeparatorOverride : Object;

		/**
		 *  Decimal separator character to use
		 */
		public function get decimalSeparatorFrom () : String;
		/**
		 *  @private
		 */
		public function set decimalSeparatorFrom (value:String) : void;
		/**
		 *  Decimal separator character to use
		 */
		public function get decimalSeparatorTo () : String;
		/**
		 *  @private
		 */
		public function set decimalSeparatorTo (value:String) : void;
		/**
		 *  Number of decimal places to include in the output String.
		 */
		public function get precision () : Object;
		/**
		 *  @private
		 */
		public function set precision (value:Object) : void;
		/**
		 *  Specifies how to round the number.
		 */
		public function get rounding () : String;
		/**
		 *  @private
		 */
		public function set rounding (value:String) : void;
		/**
		 *  Character to use as the thousands separator
		 */
		public function get thousandsSeparatorFrom () : String;
		/**
		 *  @private
		 */
		public function set thousandsSeparatorFrom (value:String) : void;
		/**
		 *  Character to use as the thousands separator
		 */
		public function get thousandsSeparatorTo () : String;
		/**
		 *  @private
		 */
		public function set thousandsSeparatorTo (value:String) : void;
		/**
		 *  If <code>true</code>, format a negative number 
		 */
		public function get useNegativeSign () : Object;
		/**
		 *  @private
		 */
		public function set useNegativeSign (value:Object) : void;
		/**
		 *  If <code>true</code>, split the number into thousands increments
		 */
		public function get useThousandsSeparator () : Object;
		/**
		 *  @private
		 */
		public function set useThousandsSeparator (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function NumberFormatter ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Formats the number as a String.
		 */
		public function format (value:Object) : String;
	}
}