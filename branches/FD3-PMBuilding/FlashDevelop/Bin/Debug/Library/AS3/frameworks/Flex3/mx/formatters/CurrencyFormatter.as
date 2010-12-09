﻿package mx.formatters
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

	/**
	 *  The CurrencyFormatter class formats a valid number as a currency value.
	 */
	public class CurrencyFormatter extends Formatter
	{
		/**
		 *  @private
		 */
		private var _alignSymbol : String;
		/**
		 *  @private
		 */
		private var alignSymbolOverride : String;
		/**
		 *  @private
		 */
		private var _currencySymbol : String;
		/**
		 *  @private
		 */
		private var currencySymbolOverride : String;
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
		 *  Aligns currency symbol to the left side or the right side
		 */
		public function get alignSymbol () : String;
		/**
		 *  @private
		 */
		public function set alignSymbol (value:String) : void;
		/**
		 *  Character to use as a currency symbol for a formatted number.
		 */
		public function get currencySymbol () : String;
		/**
		 *  @private
		 */
		public function set currencySymbol (value:String) : void;
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
		 *  How to round the number.
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
		public function CurrencyFormatter ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Formats <code>value</code> as currency.
		 */
		public function format (value:Object) : String;
	}
}