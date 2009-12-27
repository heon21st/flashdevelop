﻿package mx.formatters
{
include "../core/Version.as"
	/**
	 *  The SwitchSymbolFormatter class is a utility class that you can use 
 *  when creating custom formatters.
 *  This class performs a substitution by replacing placeholder characters
 *  in one String with numbers from a second String.
 *  
 *  <p>For example, you specify the following information
 *  to the SwitchSymbolFormatter class:</p>
 *
 *  <p>Format String: "The SocialSecurity number is: ###-##-####"</p>
 *  <p>Input String: "123456789"</p>
 *  
 *  <p>The SwitchSymbolFormatter class parses the format String and replaces
 *  each placeholder character, by default the number character (#), 
 *  with a number from the input String in the order in which
 *  the numbers are specified in the input String.
 *  You can define a different placeholder symbol by passing it
 *  to the constructor when you instantiate a SwitchSymbolFormatter object.</p>
 *  
 *  <p>The output String created by the SwitchSymbolFormatter class
 *  from these two Strings is the following:</p>
 * 
 *  <p>"The SocialSecurity number is: 123-45-6789"</p>
 *  
 *  <p>The pattern can contain any characters as long as they are constant
 *  for all values of the numeric portion of the String.
 *  However, the value for formatting must be numeric.</p>
 *  
 *  <p>The number of digits supplied in the source value must match
 *  the number of digits defined in the pattern String.
 *  This is the responsibility of the script calling the
 *  SwitchSymbolFormatter object.</p>
 *  
 *  @includeExample examples/SwitchSymbolFormatterExample.mxml
 *  
 *  @see mx.formatters.PhoneFormatter
 *  @access private
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
	 *
	 *  @param numberSymbol Character to use as the pattern character.
		 */
		public function SwitchSymbolFormatter (numberSymbol:String = "#");

		/**
		 *  Creates a new String by formatting the source String
	 *  using the format pattern.
	 *
	 *  @param format String that defines the user-requested pattern including.
	 *
	 *  @param source Valid number sequence
	 *  (alpha characters are allowed if needed).
	 *
	 *  @returns Formatted String.
		 */
		public function formatValue (format:String, source:Object) : String;
	}
}
