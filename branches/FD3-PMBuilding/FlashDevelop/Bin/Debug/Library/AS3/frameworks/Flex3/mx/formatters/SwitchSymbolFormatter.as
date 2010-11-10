﻿package mx.formatters
{
	/**
	 *  The SwitchSymbolFormatter class is a utility class that you can use 
	 */
	public class SwitchSymbolFormatter
	{
		/**
		 *  @private
		 */
		private var numberSymbol : String;
		/**
		 *  @private
		 */
		private var isValid : Boolean;

		/**
		 *  Constructor.
		 */
		public function SwitchSymbolFormatter (numberSymbol:String = "#");
		/**
		 *  Creates a new String by formatting the source String
		 */
		public function formatValue (format:String, source:Object) : String;
	}
}