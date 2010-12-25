﻿package mx.core
{
	/**
	 *  TextFieldAsset is a subclass of the flash.text.TextField class
	 */
	public class TextFieldAsset extends FlexTextField implements IFlexAsset
	{
		/**
		 *  @private
		 */
		private var _measuredHeight : Number;
		/**
		 *  @private
		 */
		private var _measuredWidth : Number;

		/**
		 *  @inheritDoc
		 */
		public function get measuredHeight () : Number;
		/**
		 *  @inheritDoc
		 */
		public function get measuredWidth () : Number;

		/**
		 *  Constructor.
		 */
		public function TextFieldAsset ();
		/**
		 *  @inheritDoc
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 *  @inheritDoc
		 */
		public function setActualSize (newWidth:Number, newHeight:Number) : void;
	}
}