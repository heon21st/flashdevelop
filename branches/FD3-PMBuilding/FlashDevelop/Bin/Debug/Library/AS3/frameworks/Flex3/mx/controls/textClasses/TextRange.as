﻿package mx.controls.textClasses
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.styles.StyleManager;
	import mx.utils.StringUtil;

	/**
	 *  The TextRange class provides properties that select and format a range of
	 */
	public class TextRange
	{
		/**
		 *  @private
		 */
		private static var htmlTextField : TextField;
		/**
		 *  @private
		 */
		private var textField : TextField;
		/**
		 *  Storage for the beginIndex property.
		 */
		private var _beginIndex : int;
		/**
		 *  Storage for the beginIndex property.
		 */
		private var _endIndex : int;
		/**
		 *  @private
		 */
		private var _modifiesSelection : Boolean;
		/**
		 *  @private
		 */
		private var _owner : UIComponent;

		/**
		 *  Zero-based index in the control's text field of the first
		 */
		public function get beginIndex () : int;
		/**
		 *  @private
		 */
		public function set beginIndex (value:int) : void;
		/**
		 *  Whether the text in the range is in a bulleted list.
		 */
		public function get bullet () : Boolean;
		/**
		 *  @private
		 */
		public function set bullet (value:Boolean) : void;
		/**
		 *  Color of the text in the range.
		 */
		public function get color () : Object;
		/**
		 *  @private
		 */
		public function set color (value:Object) : void;
		/**
		 *  Zero-based index in the control's text field of the point
		 */
		public function get endIndex () : int;
		/**
		 *  @private
		 */
		public function set endIndex (value:int) : void;
		/**
		 *  Name of the font for text in the range.
		 */
		public function get fontFamily () : String;
		/**
		 *  @private
		 */
		public function set fontFamily (value:String) : void;
		/**
		 *  Point size of the text in the range.
		 */
		public function get fontSize () : int;
		/**
		 *  @private
		 */
		public function set fontSize (value:int) : void;
		/**
		 *  Style of the font in the range, as "italic"
		 */
		public function get fontStyle () : String;
		/**
		 *  @private
		 */
		public function set fontStyle (value:String) : void;
		/**
		 *  Weight of the font in the range, as "bold"
		 */
		public function get fontWeight () : String;
		/**
		 *  @private
		 */
		public function set fontWeight (value:String) : void;
		/**
		 *  Contents of the range in the form of HTML text.
		 */
		public function get htmlText () : String;
		/**
		 *  @private
		 */
		public function set htmlText (value:String) : void;
		/**
		 *  A Boolean value that indicates whether kerning
		 */
		public function get kerning () : Boolean;
		/**
		 *  @private
		 */
		public function set kerning (value:Boolean) : void;
		/**
		 *  The number of additional pixels to appear between each character.
		 */
		public function get letterSpacing () : Number;
		/**
		 *  @private
		 */
		public function set letterSpacing (value:Number) : void;
		/**
		 *  Whether the TextRange modifies the currenly selected text.
		 */
		public function get modifiesSelection () : Boolean;
		/**
		 *  The control that contains the text.
		 */
		public function get owner () : UIComponent;
		/**
		 *  @private
		 */
		public function set owner (value:UIComponent) : void;
		/**
		 *  Plain-text contents of the range.
		 */
		public function get text () : String;
		/**
		 *  @private
		 */
		public function set text (value:String) : void;
		/**
		 *  Alignment of the text in the range.
		 */
		public function get textAlign () : String;
		/**
		 *  @private
		 */
		public function set textAlign (value:String) : void;
		/**
		 *  Decoration of the font in the range, as "underline"
		 */
		public function get textDecoration () : String;
		/**
		 *  @private
		 */
		public function set textDecoration (value:String) : void;
		/**
		 *  URL for a hypertext link in the range.
		 */
		public function get url () : String;
		/**
		 *  @private
		 */
		public function set url (value:String) : void;

		/**
		 *  Create a new TextRange Object that represents a subset of the contents
		 */
		public function TextRange (owner:UIComponent, modifiesSelection:Boolean = false, beginIndex:int = -1, endIndex:int = -1);
		/**
		 *  @private
		 */
		private function getTextFormat () : TextFormat;
		/**
		 *  @private
		 */
		private function setTextFormat (tf:TextFormat) : void;
	}
}