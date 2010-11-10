﻿package mx.validators
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The DateValidator class validates that a String, Date, or Object contains a 
	 */
	public class DateValidator extends Validator
	{
		/**
		 *  @private
		 */
		private var _allowedFormatChars : String;
		/**
		 *  @private
		 */
		private var allowedFormatCharsOverride : String;
		/**
		 *  @private
		 */
		private var _dayListener : IValidatorListener;
		/**
		 *  Name of the day property to validate. 
		 */
		public var dayProperty : String;
		/**
		 *  @private
		 */
		private var _daySource : Object;
		/**
		 *  @private
		 */
		private var _inputFormat : String;
		/**
		 *  @private
		 */
		private var inputFormatOverride : String;
		/**
		 *  @private
		 */
		private var _monthListener : IValidatorListener;
		/**
		 *  Name of the month property to validate. 
		 */
		public var monthProperty : String;
		/**
		 *  @private
		 */
		private var _monthSource : Object;
		/**
		 *  @private
		 */
		private var _validateAsString : Object;
		/**
		 *  @private
		 */
		private var validateAsStringOverride : Object;
		/**
		 *  @private
		 */
		private var _yearListener : IValidatorListener;
		/**
		 *  Name of the year property to validate. 
		 */
		public var yearProperty : String;
		/**
		 *  @private
		 */
		private var _yearSource : Object;
		/**
		 *  @private
		 */
		private var _formatError : String;
		/**
		 *  @private
		 */
		private var formatErrorOverride : String;
		/**
		 *  @private
		 */
		private var _invalidCharError : String;
		/**
		 *  @private
		 */
		private var invalidCharErrorOverride : String;
		/**
		 *  @private
		 */
		private var _wrongDayError : String;
		/**
		 *  @private
		 */
		private var wrongDayErrorOverride : String;
		/**
		 *  @private
		 */
		private var _wrongLengthError : String;
		/**
		 *  @private
		 */
		private var wrongLengthErrorOverride : String;
		/**
		 *  @private
		 */
		private var _wrongMonthError : String;
		/**
		 *  @private
		 */
		private var wrongMonthErrorOverride : String;
		/**
		 *  @private
		 */
		private var _wrongYearError : String;
		/**
		 *  @private
		 */
		private var wrongYearErrorOverride : String;

		/**
		 *  @private
		 */
		protected function get actualListeners () : Array;
		/**
		 *  The set of formatting characters allowed for separating
		 */
		public function get allowedFormatChars () : String;
		/**
		 *  @private
		 */
		public function set allowedFormatChars (value:String) : void;
		/**
		 *  The component that listens for the validation result
		 */
		public function get dayListener () : IValidatorListener;
		/**
		 *  @private
		 */
		public function set dayListener (value:IValidatorListener) : void;
		/**
		 *  Object that contains the value of the day field.
		 */
		public function get daySource () : Object;
		/**
		 *  @private
		 */
		public function set daySource (value:Object) : void;
		/**
		 *  The date format to validate the value against.
		 */
		public function get inputFormat () : String;
		/**
		 *  @private
		 */
		public function set inputFormat (value:String) : void;
		/**
		 *  The component that listens for the validation result
		 */
		public function get monthListener () : IValidatorListener;
		/**
		 *  @private
		 */
		public function set monthListener (value:IValidatorListener) : void;
		/**
		 *  Object that contains the value of the month field.
		 */
		public function get monthSource () : Object;
		/**
		 *  @private
		 */
		public function set monthSource (value:Object) : void;
		/**
		 *  Determines how to validate the value.
		 */
		public function get validateAsString () : Object;
		/**
		 *  @private
		 */
		public function set validateAsString (value:Object) : void;
		/**
		 *  The component that listens for the validation result
		 */
		public function get yearListener () : IValidatorListener;
		/**
		 *  @private
		 */
		public function set yearListener (value:IValidatorListener) : void;
		/**
		 *  Object that contains the value of the year field.
		 */
		public function get yearSource () : Object;
		/**
		 *  @private
		 */
		public function set yearSource (value:Object) : void;
		/**
		 *  Error message when the <code>inputFormat</code> property
		 */
		public function get formatError () : String;
		/**
		 *  @private
		 */
		public function set formatError (value:String) : void;
		/**
		 *  Error message when there are invalid characters in the date.
		 */
		public function get invalidCharError () : String;
		/**
		 *  @private
		 */
		public function set invalidCharError (value:String) : void;
		/**
		 *  Error message when the day is invalid.
		 */
		public function get wrongDayError () : String;
		/**
		 *  @private
		 */
		public function set wrongDayError (value:String) : void;
		/**
		 *  Error message when the length of the date
		 */
		public function get wrongLengthError () : String;
		/**
		 *  @private
		 */
		public function set wrongLengthError (value:String) : void;
		/**
		 *  Error message when the month is invalid.
		 */
		public function get wrongMonthError () : String;
		/**
		 *  @private
		 */
		public function set wrongMonthError (value:String) : void;
		/**
		 *  Error message when the year is invalid.
		 */
		public function get wrongYearError () : String;
		/**
		 *  @private
		 */
		public function set wrongYearError (value:String) : void;

		/**
		 *  Convenience method for calling a validator
		 */
		public static function validateDate (validator:DateValidator, value:Object, baseField:String) : Array;
		/**
		 *  @private
		 */
		private static function validateFormatString (validator:DateValidator, format:String, baseField:String) : ValidationResult;
		/**
		 *  Constructor.
		 */
		public function DateValidator ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Override of the base class <code>doValidation()</code> method
		 */
		protected function doValidation (value:Object) : Array;
		/**
		 *  @private
		 */
		protected function getValueFromSource () : Object;
	}
}