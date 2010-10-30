﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import mx.core.EdgeMetrics;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IRectangularBorder;
	import mx.core.IToolTip;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  The ToolTip control lets you provide helpful information to your users.
	 */
	public class ToolTip extends UIComponent implements IToolTip
	{
		/**
		 *  Maximum width in pixels for new ToolTip controls.
		 */
		public static var maxWidth : Number;
		/**
		 *  The internal object that draws the border.
		 */
		local var border : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var _text : String;
		/**
		 *  @private
		 */
		private var textChanged : Boolean;
		/**
		 *  The internal UITextField that renders the text of this ToolTip.
		 */
		protected var textField : IUITextField;

		/**
		 *  @private
		 */
		private function get borderMetrics () : EdgeMetrics;
		/**
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  The text displayed by the ToolTip.
		 */
		public function get text () : String;
		/**
		 *  @private
		 */
		public function set text (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function ToolTip ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		function createTextField (childIndex:int) : void;
		/**
		 *  @private
		 */
		function removeTextField () : void;
		/**
		 *  @private
		 */
		function getTextField () : IUITextField;
	}
}