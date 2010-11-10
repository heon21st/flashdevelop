﻿package mx.validators
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.utils.StringUtil;

	/**
	 *  The StringValidator class validates that the length of a String 
	 */
	public class StringValidator extends Validator
	{
		/**
		 *  @private
		 */
		private var _maxLength : Object;
		/**
		 *  @private
		 */
		private var maxLengthOverride : Object;
		/**
		 *  @private
		 */
		private var _minLength : Object;
		/**
		 *  @private
		 */
		private var minLengthOverride : Object;
		/**
		 *  @private
		 */
		private var _tooLongError : String;
		/**
		 *  @private
		 */
		private var tooLongErrorOverride : String;
		/**
		 *  @private
		 */
		private var _tooShortError : String;
		/**
		 *  @private
		 */
		private var tooShortErrorOverride : String;

		/**
		 *  Maximum length for a valid String. 
		 */
		public function get maxLength () : Object;
		/**
		 *  @private
		 */
		public function set maxLength (value:Object) : void;
		/**
		 *  Minimum length for a valid String.
		 */
		public function get minLength () : Object;
		/**
		 *  @private
		 */
		public function set minLength (value:Object) : void;
		/**
		 *  Error message when the String is longer
		 */
		public function get tooLongError () : String;
		/**
		 *  @private
		 */
		public function set tooLongError (value:String) : void;
		/**
		 *  Error message when the string is shorter
		 */
		public function get tooShortError () : String;
		/**
		 *  @private
		 */
		public function set tooShortError (value:String) : void;

		/**
		 *  Convenience method for calling a validator.
		 */
		public static function validateString (validator:StringValidator, value:Object, baseField:String = null) : Array;
		/**
		 *  Constructor.
		 */
		public function StringValidator ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Override of the base class <code>doValidation()</code> method
		 */
		protected function doValidation (value:Object) : Array;
	}
}