﻿package mx.controls
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.text.TextLineMetrics;
	import mx.collections.CursorBookmark;
	import mx.controls.ComboBox;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;
	import mx.core.ClassFactory;
	import mx.core.mx_internal;
	import mx.events.FileEvent;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	import flash.display.DisplayObject;
	import flash.filesystem.File;
	import mx.controls.FileSystemComboBox;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;
	import mx.controls.listClasses.ListItemRenderer;
	import mx.core.mx_internal;

	/**
	 *  Dispatched when the selected directory displayed by this control
	 */
	[Event(name="directoryChange", type="mx.events.FileEvent")] 
	/**
	 *  Specifies the icon that indicates
	 */
	[Style(name="computerIcon", type="Class", format="EmbeddedFile", inherit="no")] 
	/**
	 *  Specifies the icon that indicates a directory.
	 */
	[Style(name="directoryIcon", type="Class", format="EmbeddedFile", inherit="no")] 

	/**
	 *  The FileSystemComboBox control defines a combo box control for
	 */
	public class FileSystemComboBox extends ComboBox
	{
		/**
		 *  A constant that can be used as a value for the <code>directory</code> property,
		 */
		public static const COMPUTER : File = FileSystemControlHelper.COMPUTER;
		/**
		 *  @private
		 */
		local var helper : FileSystemControlHelper;
		/**
		 *  @private
		 */
		private var _directory : File;
		/**
		 *  @private
		 */
		private var directoryChanged : Boolean;
		/**
		 *  @private
		 */
		private var _indent : int;
		/**
		 *  @private
		 */
		private var _showIcons : Boolean;

		/**
		 *  A File object representing the directory
		 */
		public function get directory () : File;
		/**
		 *  @private
		 */
		public function set directory (value:File) : void;
		/**
		 *  The number of pixels to indent each entry in the dropdown list.
		 */
		public function get indent () : int;
		/**
		 *  @private
		 */
		public function set indent (value:int) : void;
		/**
		 *  A flag that determines whether icons are displayed
		 */
		public function get showIcons () : Boolean;
		/**
		 *  @private
		 */
		public function set showIcons (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function FileSystemComboBox ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  @private
		 */
		protected function calculatePreferredSizeFromData (count:int) : Object;
		/**
		 *  @private
		 */
		private function getParentChain (file:File) : Array;
		/**
		 *  @private
		 */
		private function changeHandler (event:Event) : void;
	}
	/**
	 *  @private
	 */
	internal class FileSystemComboBoxRenderer extends ListItemRenderer
	{
		/**
		 *  Constructor.
		 */
		public function FileSystemComboBoxRenderer ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		private function getNestLevel (item:File) : int;
	}
}