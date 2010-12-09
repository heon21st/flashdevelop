﻿package mx.containers
{
	import flash.display.DisplayObject;
	import mx.containers.utilityClasses.BoxLayout;
	import mx.controls.Label;
	import mx.core.Container;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.styles.StyleManager;

	/**
	 *  Number of pixels between the label and child components.
	 */
	[Style(name="indicatorGap", type="Number", format="Length", inherit="yes")] 
	/**
	 *  Width of the form labels.
	 */
	[Style(name="labelWidth", type="Number", format="Length", inherit="yes")] 
	/**
	 *  Number of pixels between the container's bottom border
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's top border
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  The Form container lets you control the layout of a form,
	 */
	public class Form extends Container
	{
		/**
		 *  @private
		 */
		private static var classInitialized : Boolean;
		/**
		 *  @private
		 */
		local var layoutObject : BoxLayout;
		/**
		 *  @private
		 */
		private var measuredLabelWidth : Number;

		/**
		 *  The maximum width, in pixels, of the labels of the FormItems containers in this Form.
		 */
		public function get maxLabelWidth () : Number;

		/**
		 *  @private
		 */
		private static function initializeClass () : void;
		/**
		 *  Constructor.
		 */
		public function Form ();
		/**
		 *  @private
		 */
		public function addChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  @private
		 */
		public function removeChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		public function removeChildAt (index:int) : DisplayObject;
		/**
		 *  Calculates the preferred, minimum and maximum sizes of the Form.
		 */
		protected function measure () : void;
		/**
		 *  Responds to size changes by setting the positions
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		function invalidateLabelWidth () : void;
		/**
		 *  @private
		 */
		function calculateLabelWidth () : Number;
	}
}