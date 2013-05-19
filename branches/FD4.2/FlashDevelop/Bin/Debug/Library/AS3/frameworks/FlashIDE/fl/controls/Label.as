﻿package fl.controls
{
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.events.ComponentEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import fl.controls.TextInput;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	/**
	 * Dispatched after there is a change in the width or height of the component.
	 */
	[Event(name="resize", type="fl.events.ComponentEvent")] 
	/**
	 * @copy fl.controls.LabelButton#style:embedFonts
	 */
	[Style(name="embedFonts", type="Boolean")] 

	/**
	 * A Label component displays one or more lines of plain or 
	 */
	public class Label extends UIComponent
	{
		/**
		 * A reference to the internal text field of the Label component.
		 */
		public var textField : TextField;
		/**
		 * @private (protected)
		 */
		protected var actualWidth : Number;
		/**
		 * @private (protected)
		 */
		protected var actualHeight : Number;
		/**
		 * @private (protected)
		 */
		protected var defaultLabel : String;
		/**
		 * @private (protected)
		 */
		protected var _savedHTML : String;
		/**
		 * @private (protected)
		 */
		protected var _html : Boolean;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;

		/**
		 * Gets or sets the plain text to be displayed by the Label component.
		 */
		public function get text () : String;
		/**
		 * @private (setter)
		 */
		public function set text (value:String) : void;
		/**
		 * Gets or sets the text to be displayed by the Label component, including 
		 */
		public function get htmlText () : String;
		/**
		 * @private (setter)
		 */
		public function set htmlText (value:String) : void;
		/**
		 * Gets or sets a value that indicates whether extra white space such as spaces 
		 */
		public function get condenseWhite () : Boolean;
		/**
		 * @private
		 */
		public function set condenseWhite (value:Boolean) : void;
		/**
		 * Gets or sets a value that indicates whether the text can be selected. A value 
		 */
		public function get selectable () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set selectable (value:Boolean) : void;
		/**
		 * Gets or sets a value that indicates whether the text field supports word wrapping.
		 */
		public function get wordWrap () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set wordWrap (value:Boolean) : void;
		/**
		 * Gets or sets a string that indicates how a label is sized and aligned to
		 */
		public function get autoSize () : String;
		/**
		 * @private (setter)
		 */
		public function set autoSize (value:String) : void;
		/**
		 * @copy fl.core.UIComponent#width
		 */
		public function get width () : Number;
		/**
		 * @private (setter)
		 */
		public function set width (value:Number) : void;
		/**
		 * @copy fl.core.UIComponent#height
		 */
		public function get height () : Number;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * Creates a new Label component instance.
		 */
		public function Label ();
		/**
		 * @private (setter)
		 */
		public function setSize (width:Number, height:Number) : void;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function drawTextFormat () : void;
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
	}
}