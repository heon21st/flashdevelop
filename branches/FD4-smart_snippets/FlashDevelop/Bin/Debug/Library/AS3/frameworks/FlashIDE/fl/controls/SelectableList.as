﻿package fl.controls
{
	import fl.containers.BaseScrollPane;
	import fl.controls.listClasses.CellRenderer;
	import fl.controls.listClasses.ICellRenderer;
	import fl.controls.listClasses.ListData;
	import fl.controls.ScrollPolicy;
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.data.DataProvider;
	import fl.data.SimpleCollectionItem;
	import fl.events.DataChangeEvent;
	import fl.events.DataChangeType;
	import fl.events.ListEvent;
	import fl.events.ScrollEvent;
	import fl.managers.IFocusManagerComponent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

	/**
	 * Dispatched when the user rolls the pointer off of an item in the component.
	 */
	[Event(name="itemRollOut", type="fl.events.ListEvent")] 
	/**
	 * Dispatched when the user rolls the pointer over an item in the component.
	 */
	[Event(name="itemRollOver", type="fl.events.ListEvent")] 
	/**
	 * Dispatched when the user rolls the pointer over the component.
	 */
	[Event(name="rollOver", type="flash.events.MouseEvent")] 
	/**
	 * Dispatched when the user rolls the pointer off of the component.
	 */
	[Event(name="rollOut", type="flash.events.MouseEvent")] 
	/**
	 * Dispatched when the user clicks an item in the component. 
	 */
	[Event(name="itemClick", type="fl.events.ListEvent")] 
	/**
	 * Dispatched when the user clicks an item in the component twice in
	 */
	[Event(name="itemDoubleClick", type="fl.events.ListEvent")] 
	/**
	 * Dispatched when a different item is selected in the list.
	 */
	[Event(name="change", type="flash.events.Event")] 
	/**
	 * Dispatched when the user scrolls horizontally or vertically.
	 */
	[Event(name="scroll", type="fl.events.ScrollEvent")] 
	/**
	 * The class that provides the skin for the background of the component.
	 */
	[Style(name="skin", type="Class")] 
	/**
	 * The class that provides the cell renderer for each item in the component.
	 */
	[Style(name="cellRenderer", type="Class")] 
	/**
	 * The alpha value to set the list to when the <code>enabled</code> property is <code>false</code>.
	 */
	[Style(name="disabledAlpha", type="Number")] 
	/**
	 * The padding that separates the border of the list from its contents, in pixels.
	 */
	[Style(name="contentPadding", type="Number", format="Length")] 

	/**
	 * The SelectableList is the base class for all list-based components--for  
	 */
	public class SelectableList extends BaseScrollPane implements IFocusManagerComponent
	{
		/**
		 * @private
		 */
		protected var listHolder : Sprite;
		/**
		 * @private
		 */
		protected var list : Sprite;
		/**
		 * @private
		 */
		protected var _dataProvider : DataProvider;
		/**
		 * @private
		 */
		protected var activeCellRenderers : Array;
		/**
		 * @private
		 */
		protected var availableCellRenderers : Array;
		/**
		 * @private
		 */
		protected var renderedItems : Dictionary;
		/**
		 * @private
		 */
		protected var invalidItems : Dictionary;
		/**
		 * @private
		 */
		protected var _horizontalScrollPosition : Number;
		/**
		 * @private
		 */
		protected var _verticalScrollPosition : Number;
		/**
		 * @private
		 */
		protected var _allowMultipleSelection : Boolean;
		/**
		 * @private
		 */
		protected var _selectable : Boolean;
		/**
		 * @private
		 */
		protected var _selectedIndices : Array;
		/**
		 * @private
		 */
		protected var caretIndex : int;
		/**
		 * @private
		 */
		protected var lastCaretIndex : int;
		/**
		 * @private (protected)
		 */
		protected var preChangeItems : Array;
		/**
		 * @private
		 */
		private var collectionItemImport : SimpleCollectionItem;
		/**
		 * @private (protected)
		 */
		protected var rendererStyles : Object;
		/**
		 * @private (protected)
		 */
		protected var updatedRendererStyles : Object;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;
		/**
		 *  @private
		 */
		public static var createAccessibilityImplementation : Function;

		/**
		 * @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 * Gets or sets the data model of the list of items to be viewed. A data provider 
		 */
		public function get dataProvider () : DataProvider;
		/**
		 * @private (setter)
		 */
		public function set dataProvider (value:DataProvider) : void;
		/**
		 * Gets or sets the number of pixels that the list scrolls to the right when the
		 */
		public function get maxHorizontalScrollPosition () : Number;
		/**
		 * @private
		 */
		public function set maxHorizontalScrollPosition (value:Number) : void;
		/**
		 * Gets the number of items in the data provider.
		 */
		public function get length () : uint;
		/**
		 * Gets a Boolean value that indicates whether more than one list item 
		 */
		public function get allowMultipleSelection () : Boolean;
		/**
		 * @private
		 */
		public function set allowMultipleSelection (value:Boolean) : void;
		/**
		 * Gets or sets a Boolean value that indicates whether the items in the list 
		 */
		public function get selectable () : Boolean;
		/**
		 * @private
		 */
		public function set selectable (value:Boolean) : void;
		/**
		 * Gets or sets the index of the item that is selected in a single-selection
		 */
		public function get selectedIndex () : int;
		/**
		 * @private
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 * Gets or sets an array that contains the items that were selected from
		 */
		public function get selectedIndices () : Array;
		/**
		 * @private
		 */
		public function set selectedIndices (value:Array) : void;
		/**
		 * Gets or sets the item that was selected from a single-selection list. For a 
		 */
		public function get selectedItem () : Object;
		/**
		 * @private (setter)
		 */
		public function set selectedItem (value:Object) : void;
		/**
		 * Gets or sets an array that contains the objects for the  
		 */
		public function get selectedItems () : Array;
		/**
		 * @private (setter)
		 */
		public function set selectedItems (value:Array) : void;
		/**
		 * Gets the number of rows that are at least partially visible in the list.
		 */
		public function get rowCount () : uint;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * Creates a new SelectableList instance.
		 */
		public function SelectableList ();
		/**
		 * Clears the currently selected item in the list and sets the <code>selectedIndex</code> property to -1.
		 */
		public function clearSelection () : void;
		/**
		 * Retrieves the ICellRenderer for a given item object, if there is one. 
		 */
		public function itemToCellRenderer (item:Object) : ICellRenderer;
		/**
		 * Appends an item to the end of the list of items. 
		 */
		public function addItem (item:Object) : void;
		/**
		 * Inserts an item into the list at the specified index location. The indices of 
		 */
		public function addItemAt (item:Object, index:uint) : void;
		/**
		 * Removes all items from the list. 
		 */
		public function removeAll () : void;
		/**
		 * Retrieves the item at the specified index.
		 */
		public function getItemAt (index:uint) : Object;
		/**
		 * Removes the specified item from the list. 
		 */
		public function removeItem (item:Object) : Object;
		/**
		 * Removes the item at the specified index position. The indices of 
		 */
		public function removeItemAt (index:uint) : Object;
		/**
		 * Replaces the item at the specified index location with another item. 
		 */
		public function replaceItemAt (item:Object, index:uint) : Object;
		/**
		 * Invalidates the whole list, forcing the list items to be redrawn.
		 */
		public function invalidateList () : void;
		/**
		 * Invalidates a specific item renderer.
		 */
		public function invalidateItem (item:Object) : void;
		/**
		 * Invalidates the renderer for the item at the specified index.
		 */
		public function invalidateItemAt (index:uint) : void;
		/**
		 * Sorts the elements of the current data provider. This method 
		 */
		public function sortItems (...sortArgs:Array) : *;
		/**
		 * Sorts the elements of the current data provider by one or more  
		 */
		public function sortItemsOn (field:String, options:Object = null) : *;
		/**
		 * Checks whether the specified item is selected in the list. 
		 */
		public function isItemSelected (item:Object) : Boolean;
		/**
		 * Scrolls the list to the item at the location indicated by    
		 */
		public function scrollToSelected () : void;
		/**
		 * Scrolls the list to the item at the specified index. If the index 
		 */
		public function scrollToIndex (newCaretIndex:int) : void;
		/**
		 * Returns the index of the next item in the dataProvider in which
		 */
		public function getNextIndexAtLetter (firstLetter:String, startIndex:int = -1) : int;
		/**
		 * Retrieves the string that the renderer displays for the given data object 
		 */
		public function itemToLabel (item:Object) : String;
		/**
		 * Sets a style on the renderers in the list.
		 */
		public function setRendererStyle (name:String, style:Object, column:uint = 0) : void;
		/**
		 * Retrieves a style that is set on the renderers in the list.
		 */
		public function getRendererStyle (name:String, column:int = -1) : Object;
		/**
		 * Clears a style that is set on the renderers in the list.
		 */
		public function clearRendererStyle (name:String, column:int = -1) : void;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
		/**
		 * @private (protected)
		 */
		protected function _invalidateList () : void;
		/**
		 * @private (protected)
		 */
		protected function handleDataChange (event:DataChangeEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function handleCellRendererMouseEvent (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function handleCellRendererClick (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function handleCellRendererChange (event:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function handleCellRendererDoubleClick (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function setHorizontalScrollPosition (scroll:Number, fireEvent:Boolean = false) : void;
		/**
		 * @private (protected)
		 */
		protected function setVerticalScrollPosition (scroll:Number, fireEvent:Boolean = false) : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
		/**
		 * @private (protected)
		 */
		protected function updateRendererStyles () : void;
		/**
		 * @private (protected)
		 */
		protected function drawList () : void;
		/**
		 * @private (protected)
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function moveSelectionHorizontally (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		/**
		 * @private (protected)
		 */
		protected function moveSelectionVertically (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		/**
		 * @private (protected)
		 */
		protected function initializeAccessibility () : void;
		/**
		 * @private (protected)
		 */
		protected function onPreChange (event:DataChangeEvent) : void;
	}
}