﻿package mx.validators
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The SocialSecurityValidator class validates that a String *  is a valid United States Social Security number. *  It does not check whether it is an existing Social Security number. * *  @mxml * *  <p>The <code>&lt;mx:SocialSecurityValidator&gt;</code> tag *  inherits all of the tag attributes of its superclass, *  and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:SocialSecurityValidator *    allowedFormatChars=" -" *    invalidCharError="You entered invalid characters in your Social Security number." *    wrongFormatError="The Social Security number must be 9 digits or in the form NNN-NN-NNNN." *    zeroStartError="Invalid Social Security number; the number cannot start with 000." *  /&gt; *  </pre> * *  @includeExample examples/SocialSecurityValidatorExample.mxml
	 */
	public class SocialSecurityValidator extends Validator
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
		 *  @private	 *  Storage for the invalidCharError property.
		 */
		private var _invalidCharError : String;
		/**
		 *  @private
		 */
		private var invalidCharErrorOverride : String;
		/**
		 *  @private	 *  Storage for the wrongFormatError property.
		 */
		private var _wrongFormatError : String;
		/**
		 *  @private
		 */
		private var wrongFormatErrorOverride : String;
		/**
		 *  @private	 *  Storage for the zeroStartError property.
		 */
		private var _zeroStartError : String;
		/**
		 *  @private
		 */
		private var zeroStartErrorOverride : String;

		/**
		 *  Specifies the set of formatting characters allowed in the input.	 *	 *  @default "()- .+" // ?????
		 */
		public function get allowedFormatChars () : String;
		/**
		 *  @private
		 */
		public function set allowedFormatChars (value:String) : void;
		/**
		 *  Error message when the value contains characters	 *  other than digits and formatting characters	 *  defined by the <code>allowedFormatChars</code> property.	 *	 *  @default "You entered invalid characters in your Social Security number."
		 */
		public function get invalidCharError () : String;
		/**
		 *  @private
		 */
		public function set invalidCharError (value:String) : void;
		/**
		 *  Error message when the value is incorrectly formatted.	 *	 *  @default "The Social Security number must be 9 digits or in the form NNN-NN-NNNN."
		 */
		public function get wrongFormatError () : String;
		/**
		 *  @private
		 */
		public function set wrongFormatError (value:String) : void;
		/**
		 *  Error message when the value contains an invalid Social Security number.	 *	 *  @default "Invalid Social Security number; the number cannot start with 000."
		 */
		public function get zeroStartError () : String;
		/**
		 *  @private
		 */
		public function set zeroStartError (value:String) : void;

		/**
		 *  Convenience method for calling a validator.	 *  Each of the standard Flex validators has a similar convenience method.	 *	 *  @param validator The SocialSecurityValidator instance.	 *	 *  @param value A field to validate.	 *	 *  @param baseField Text representation of the subfield	 *  specified in the <code>value</code> parameter.	 *  For example, if the <code>value</code> parameter specifies	 *  value.social, the <code>baseField</code> value is <code>social</code>.	 *	 *  @return An Array of ValidationResult objects, with one ValidationResult	 *  object for each field examined by the validator.	 *	 *  @see mx.validators.ValidationResult
		 */
		public static function validateSocialSecurity (validator:SocialSecurityValidator, value:Object, baseField:String) : Array;
		/**
		 *  Constructor.
		 */
		public function SocialSecurityValidator ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Override of the base class <code>doValidation()</code> method     *  to validate a Social Security number.     *	 *  <p>You do not call this method directly;	 *  Flex calls it as part of performing a validation.	 *  If you create a custom Validator class, you must implement this method.</p>	 *     *  @param value Object to validate.     *	 *  @return An Array of ValidationResult objects, with one ValidationResult	 *  object for each field examined by the validator.
		 */
		protected function doValidation (value:Object) : Array;
	}
}
