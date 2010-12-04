﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import mx.collections.CursorBookmark;
	import mx.collections.IList;
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListBase;
	import mx.controls.listClasses.ListBaseContentHolder;
	import mx.controls.listClasses.ListBaseSeekPending;
	import mx.controls.listClasses.ListData;
	import mx.controls.listClasses.ListItemRenderer;
	import mx.controls.listClasses.ListRowInfo;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.ClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.EventPriority;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.core.FlexVersion;
	import mx.core.IChildList;
	import mx.core.IFactory;
	import mx.core.IIMESupport;
	import mx.core.IInvalidating;
	import mx.core.IPropertyChangeNotifier;
	import mx.core.IRawChildrenContainer;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.ListEvent;
	import mx.events.ListEventReason;
	import mx.events.SandboxMouseEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.styles.StyleManager;
	import mx.collections.ItemWrapper;
	import mx.collections.ModifiedCollectionView;
	import mx.core.IUIComponent;

	/**
	 *  Dispatched when the user releases the mouse button while over an item,
	 */
	[Event(name="itemEditBeginning", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the <code>editedItemPosition</code> property is set
	 */
	[Event(name="itemEditBegin", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when an item editing session is ending for any reason.
	 */
	[Event(name="itemEditEnd", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when an item renderer gets focus, which can occur if the user
	 */
	[Event(name="itemFocusIn", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when an item renderer loses the focus, which can occur if the 
	 */
	[Event(name="itemFocusOut", type="mx.events.ListEvent")] 

	/**
	 *  The List control displays a vertical list of items.
	 */
	public class List extends ListBase implements IIMESupport
	{
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  A reference to the currently active instance of the item editor, 
		 */
		public var itemEditorInstance : IListItemRenderer;
		/**
		 *  @private
		 */
		private var dontEdit : Boolean;
		/**
		 *  @private
		 */
		private var losingFocus : Boolean;
		/**
		 *  @private
		 */
		private var inEndEdit : Boolean;
		private var actualRowIndex : int;
		private var actualColIndex : int;
		/**
		 *  cache of measuring objects by factory
		 */
		protected var measuringObjects : Dictionary;
		/**
		 *  A flag that indicates whether or not the user can edit
		 */
		public var editable : Boolean;
		/**
		 *  The class factory for the item editor to use for the control, if the 
		 */
		public var itemEditor : IFactory;
		/**
		 *  The name of the property of the item editor that contains the new
		 */
		public var editorDataField : String;
		/**
		 *  The height of the item editor, in pixels, relative to the size of the 
		 */
		public var editorHeightOffset : Number;
		/**
		 *  The width of the item editor, in pixels, relative to the size of the 
		 */
		public var editorWidthOffset : Number;
		/**
		 *  The x location of the upper-left corner of the item editor,
		 */
		public var editorXOffset : Number;
		/**
		 *  The y location of the upper-left corner of the item editor,
		 */
		public var editorYOffset : Number;
		/**
		 *  A flag that indicates whether the item editor uses Enter key.
		 */
		public var editorUsesEnterKey : Boolean;
		/**
		 *  @private
		 */
		private var bEditedItemPositionChanged : Boolean;
		/**
		 *  @private
		 */
		private var _proposedEditedItemPosition : *;
		/**
		 *  @private
		 */
		private var lastEditedItemPosition : *;
		/**
		 *  @private
		 */
		private var _editedItemPosition : Object;
		/**
		 *  @private
		 */
		local var _lockedRowCount : int;
		/**
		 *  Specifies whether the item renderer is also an item 
		 */
		public var rendererIsEditor : Boolean;
		/**
		 *  @private
		 */
		private var _imeMode : String;

		/**
		 *  A reference to the item renderer
		 */
		public function get editedItemRenderer () : IListItemRenderer;
		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function set maxHorizontalScrollPosition (value:Number) : void;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  The column and row index of the item renderer for the
		 */
		public function get editedItemPosition () : Object;
		/**
		 *  @private
		 */
		public function set editedItemPosition (value:Object) : void;
		/**
		 *  The index of the first row in the control that scrolls.
		 */
		public function get lockedRowCount () : int;
		/**
		 *  @private
		 */
		public function set lockedRowCount (value:int) : void;
		/**
		 *  Specifies the IME (input method editor) mode.
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  @private
		 */
		public function set itemRenderer (value:IFactory) : void;

		/**
		 *  Constructor.
		 */
		public function List ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
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
		protected function configureScrollBars () : void;
		/**
		 *  @private
		 */
		private function adjustVerticalScrollPositionDownward (rowCount:int) : Boolean;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		protected function adjustListContent (unscaledWidth:Number = -1, unscaledHeight:Number = -1) : void;
		/**
		 *  @private
		 */
		protected function drawRowBackgrounds () : void;
		/**
		 *  Draws a row background 
		 */
		protected function drawRowBackground (s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int) : void;
		/**
		 *  @private
		 */
		protected function makeRowsAndColumns (left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0) : Point;
		/**
		 *  Positions the item editor instance at the suggested position
		 */
		protected function layoutEditor (x:int, y:int, w:int, h:int) : void;
		/**
		 *  @private
		 */
		protected function scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function scrollHorizontally (pos:int, deltaPos:int, scrollUp:Boolean) : void;
		/**
		 *  Creates a new ListData instance and populates the fields based on
		 */
		protected function makeListData (data:Object, uid:String, rowNum:int) : BaseListData;
		/**
		 *  @private
		 */
		function setupRendererFromData (item:IListItemRenderer, wrappedData:Object) : void;
		/**
		 *  @private
		 */
		public function measureWidthOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  @private
		 */
		public function measureHeightOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  @private
		 */
		protected function mouseEventToItemRenderer (event:MouseEvent) : IListItemRenderer;
		/**
		 *  @private
		 */
		function getMeasuringRenderer (data:Object) : IListItemRenderer;
		/**
		 *  @private
		 */
		function purgeMeasuringRenderers () : void;
		/**
		 *  Get the appropriate renderer, using the default renderer if none is specified.
		 */
		public function createItemRenderer (data:Object) : IListItemRenderer;
		/**
		 *  @private
		 */
		private function editingTemporarilyPrevented (coord:Object) : Boolean;
		/**
		 *  @private
		 */
		private function setEditedItemPosition (coord:Object) : void;
		/**
		 *  @private
		 */
		private function commitEditedItemPosition (coord:Object) : void;
		/**
		 *  Creates the item editor for the item renderer at the
		 */
		public function createItemEditor (colIndex:int, rowIndex:int) : void;
		/**
		 *  @private
		 */
		private function findNextItemRenderer (shiftKey:Boolean) : Boolean;
		/**
		 *  Closes an item editor that is currently open on an item. 
		 */
		public function destroyItemEditor () : void;
		/**
		 *  Stops the editing of an item in the data provider.
		 */
		protected function endEdit (reason:String) : Boolean;
		/**
		 *  Determines if the item renderer for a data provider item 
		 */
		public function isItemEditable (data:Object) : Boolean;
		/**
		 *  @private
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		private function deactivateHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		private function editorMouseDownHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function editorKeyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		private function findNextEnterItemRenderer (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		private function mouseFocusChangeHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function keyFocusChangeHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		private function itemEditorFocusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		private function itemEditorItemEditBeginningHandler (event:ListEvent) : void;
		/**
		 *  @private
		 */
		private function itemEditorItemEditBeginHandler (event:ListEvent) : void;
		/**
		 *  @private
		 */
		private function itemEditorItemEditEndHandler (event:ListEvent) : void;
		/**
		 *  @private
		 */
		protected function drawHighlightIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function drawCaretIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function drawSelectionIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function mouseWheelHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function callSetupRendererFromData (item:IListItemRenderer, data:Object) : void;
		/**
		 *  @private
		 */
		function callMakeListData (data:Object, uid:String, rowNum:int) : BaseListData;
	}
}