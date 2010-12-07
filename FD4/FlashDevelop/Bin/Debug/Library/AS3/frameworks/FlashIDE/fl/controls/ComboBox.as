﻿package fl.controls
{
	import fl.data.DataProvider;
	import fl.containers.BaseScrollPane;
	import fl.controls.BaseButton;
	import fl.controls.List;
	import fl.controls.listClasses.ICellRenderer;
	import fl.controls.TextInput;
	import fl.controls.TextArea;
	import fl.controls.ScrollBar;
	import fl.controls.SelectableList;
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.events.ComponentEvent;
	import fl.events.DataChangeEvent;
	import fl.events.DataChangeType;
	import fl.events.ListEvent;
	import fl.managers.IFocusManagerComponent;
	import fl.data.DataProvider;
	import fl.data.SimpleCollectionItem;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.system.IME;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;

	/**
	 * Dispatched when the user changes the selection in the ComboBox component or, if 
	 */
	[Event(name="change", type="flash.events.Event")] 
	/**
	 * @copy fl.controls.SelectableList#event:itemRollOver
	 */
	[Event(name="itemRollOver", type="fl.events.ListEvent")] 
	/**
	 * @copy fl.controls.SelectableList#event:itemRollOut
	 */
	[Event(name="itemRollOut", type="fl.events.ListEvent")] 
	/**
	 * Dispatched when the drop-down list is dismissed for any reason.
	 */
	[Event(name="close", type="flash.events.Event")] 
	/**
	 * Dispatched if the <code>editable</code> property is set to <code>true</code> and the user 
	 */
	[Event(name="enter", type="fl.events.ComponentEvent")] 
	/**
	 * Dispatched when the user clicks the drop-down button to display 
	 */
	[Event(name="open", type="flash.events.Event")] 
	/**
	 * Dispatched when the user scrolls the drop-down list of the ComboBox component.
	 */
	[Event(name="scroll", type="fl.events.ScrollEvent")] 
	/**
	 * The space that separates the right edge of the component from the
	 */
	[Style(name="buttonWidth", type="Number", format="Length")] 
	/**
	 * The space that separates the border from the text representing the
	 */
	[Style(name="textPadding", type="Number", format="Length")] 
	/**
	 * The name of the class that provides the background of the ComboBox component.
	 */
	[Style(name="upSkin", type="Class")] 
	/**
	 * The name of the class that provides the background that appears
	 */
	[Style(name="overSkin", type="Class")] 
	/**
	 * The name of the class that provides the background that appears
	 */
	[Style(name="downSkin", type="Class")] 
	/**
	 * The name of the class that provides the background that appears  
	 */
	[Style(name="disabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.SelectableList#style:cellRenderer
	 */
	[Style(name="cellRenderer", type="Class")] 
	/**
	 * @copy fl.containers.BaseScrollPane#style:contentPadding
	 */
	[Style(name="contentPadding", type="Number", format="Length")] 
	/**
	 * @copy fl.controls.SelectableList#style:disabledAlpha
	 */
	[Style(name="disabledAlpha", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:downArrowDisabledSkin
	 */
	[Style(name="downArrowDisabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:downArrowDownSkin
	 */
	[Style(name="downArrowDownSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:downArrowOverSkin
	 */
	[Style(name="downArrowOverSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:downArrowUpSkin
	 */
	[Style(name="downArrowUpSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:thumbDisabledSkin
	 */
	[Style(name="thumbDisabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:thumbDownSkin
	 */
	[Style(name="thumbDownSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:thumbOverSkin
	 */
	[Style(name="thumbOverSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:thumbUpSkin
	 */
	[Style(name="thumbArrowUpSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:trackDisabledSkin
	 */
	[Style(name="trackDisabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:trackDownSkin
	 */
	[Style(name="trackDownSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:trackOverSkin
	 */
	[Style(name="trackOverSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:trackUpSkin
	 */
	[Style(name="trackUpSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:upArrowDisabledSkin
	 */
	[Style(name="upArrowDisabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:upArrowDownSkin
	 */
	[Style(name="upArrowDownSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:upArrowOverSkin
	 */
	[Style(name="upArrowOverSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:upArrowUpSkin
	 */
	[Style(name="upArrowUpSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:thumbIcon
	 */
	[Style(name="thumbIcon", type="Class")] 
	/**
	 * @copy fl.controls.BaseButton#style:repeatDelay
	 */
	[Style(name="repeatDelay", type="Number", format="Time")] 
	/**
	 * @copy fl.controls.BaseButton#style:repeatInterval
	 */
	[Style(name="repeatInterval", type="Number", format="Time")] 
	/**
	 * @copy fl.controls.LabelButton#style:embedFonts
	 */
	[Style(name="embedFonts", type="Boolean")] 

	/**
	 * The ComboBox component contains a drop-down list from which the
	 */
	public class ComboBox extends UIComponent implements IFocusManagerComponent
	{
		/**
		 * @private (protected)
		 */
		protected var inputField : TextInput;
		/**
		 * @private (protected)
		 */
		protected var background : BaseButton;
		/**
		 * @private (protected)
		 */
		protected var list : List;
		/**
		 * @private (protected)
		 */
		protected var _rowCount : uint;
		/**
		 * @private (protected)
		 */
		protected var _editable : Boolean;
		/**
		 * @private (protected)
		 */
		protected var isOpen : Boolean;
		/**
		 * @private (protected)
		 */
		protected var highlightedCell : int;
		/**
		 * @private (protected)
		 */
		protected var editableValue : String;
		/**
		 * @private (protected)
		 */
		protected var _prompt : String;
		/**
		 * @private (protected)
		 */
		protected var isKeyDown : Boolean;
		/**
		 * @private (protected)
		 */
		protected var currentIndex : int;
		/**
		 * @private (protected)
		 */
		protected var listOverIndex : uint;
		/**
		 * @private (protected)
		 */
		protected var _dropdownWidth : Number;
		/**
		 * @private (protected)
		 */
		protected var _labels : Array;
		/**
		 * @private
		 */
		private var collectionItemImport : SimpleCollectionItem;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;
		/**
		 * @private (protected)
		 */
		protected static const LIST_STYLES : Object;
		/**
		 * @private (protected)
		 */
		protected const BACKGROUND_STYLES : Object;
		/**
		 * @private (internal)
		 */
		public static var createAccessibilityImplementation : Function;

		/**
		 * Gets or sets a Boolean value that indicates whether the ComboBox 
		 */
		public function get editable () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set editable (value:Boolean) : void;
		/**
		 * Gets or sets the maximum number of rows that can appear in a drop-down  
		 */
		public function get rowCount () : uint;
		/**
		 * @private (setter)
		 */
		public function set rowCount (value:uint) : void;
		/**
		 * Gets or sets the characters that a user can enter in the text field.
		 */
		public function get restrict () : String;
		/**
		 * @private (setter)
		 */
		public function set restrict (value:String) : void;
		/**
		 * @copy fl.controls.SelectableList#selectedIndex
		 */
		public function get selectedIndex () : int;
		/**
		 * @private
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 * Gets or sets the text that the text box contains in an editable ComboBox component. 
		 */
		public function get text () : String;
		/**
		 * @private (setter)
		 */
		public function set text (value:String) : void;
		/**
		 * @copy fl.controls.List#labelField
		 */
		public function get labelField () : String;
		/**
		 * @private (setter)
		 */
		public function set labelField (value:String) : void;
		/**
		 * @copy fl.controls.List#labelFunction
		 */
		public function get labelFunction () : Function;
		/**
		 * @private (setter)
		 */
		public function set labelFunction (value:Function) : void;
		/**
		 * Gets or sets the value of the item that is selected in the drop-down list.
		 */
		public function get selectedItem () : Object;
		/**
		 * @private (setter)
		 */
		public function set selectedItem (value:Object) : void;
		/**
		 * Gets a reference to the List component that the ComboBox component contains. 
		 */
		public function get dropdown () : List;
		/**
		 * Gets the number of items in the list. This property belongs to
		 */
		public function get length () : int;
		/**
		 * Gets a reference to the TextInput component that the ComboBox 
		 */
		public function get textField () : TextInput;
		/**
		 * Gets the label of an item in an editable ComboBox component. For a ComboBox 
		 */
		public function get value () : String;
		/**
		 * @copy fl.controls.SelectableList#dataProvider
		 */
		public function get dataProvider () : DataProvider;
		/**
		 * @private (setter)
		 */
		public function set dataProvider (value:DataProvider) : void;
		/**
		 * Gets or sets the maximum width of the drop-down list, in pixels. 
		 */
		public function get dropdownWidth () : Number;
		/**
		 * @private (setter)
		 */
		public function set dropdownWidth (value:Number) : void;
		/**
		 * Gets or sets the prompt for the ComboBox component. This prompt is a string 
		 */
		public function get prompt () : String;
		/**
		 * @private (setter)
		 */
		public function set prompt (value:String) : void;
		/**
		 * @private (protected)
		 */
		public function get imeMode () : String;
		/**
		 * @private (protected)
		 */
		public function set imeMode (value:String) : void;
		/**
		 * Gets the string that is displayed in the TextInput portion 
		 */
		public function get selectedLabel () : String;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public function getStyleDefinition () : Object;
		/**
		 * Creates a new ComboBox component instance.
		 */
		public function ComboBox ();
		/**
		 * @copy fl.controls.List#itemToLabel()
		 */
		public function itemToLabel (item:Object) : String;
		/**
		 * @copy fl.controls.SelectableList#addItem()
		 */
		public function addItem (item:Object) : void;
		/**
		 * @copy fl.controls.SelectableList#addItemAt()
		 */
		public function addItemAt (item:Object, index:uint) : void;
		/**
		 * @copy fl.controls.SelectableList#removeAll()
		 */
		public function removeAll () : void;
		/**
		 * @copy fl.controls.SelectableList#removeItem()
		 */
		public function removeItem (item:Object) : Object;
		/**
		 * Removes the item at the specified index position. The index 
		 */
		public function removeItemAt (index:uint) : void;
		/**
		 * @copy fl.controls.SelectableList#getItemAt()
		 */
		public function getItemAt (index:uint) : Object;
		/**
		 * @copy fl.controls.SelectableList#replaceItemAt()
		 */
		public function replaceItemAt (item:Object, index:uint) : Object;
		/**
		 * @copy fl.controls.SelectableList#sortItems()
		 */
		public function sortItems (...sortArgs:Array) : *;
		/**
		 * @copy fl.controls.SelectableList#sortItemsOn()
		 */
		public function sortItemsOn (field:String, options:Object = null) : *;
		/**
		 * Opens the drop-down list.
		 */
		public function open () : void;
		/**
		 * Closes the drop-down list.
		 */
		public function close () : void;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
		/**
		 * @private (protected)
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function handleDataChange (event:DataChangeEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function setEmbedFonts () : void;
		/**
		 * @private (protected)
		 */
		protected function showPrompt () : void;
		/**
		 * @private (protected)
		 */
		protected function setStyles () : void;
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
		/**
		 * @private (protected)
		 */
		protected function drawTextFormat () : void;
		/**
		 * @private (protected)
		 */
		protected function drawList () : void;
		/**
		 * @private (protected)
		 */
		protected function positionList () : void;
		/**
		 * @private (protected)
		 */
		protected function drawTextField () : void;
		/**
		 * @private (protected)
		 */
		protected function onInputFieldFocus (event:FocusEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function onInputFieldFocusOut (event:FocusEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function onEnter (event:ComponentEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function onToggleListVisibility (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function onListItemUp (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function onListChange (event:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function onStageClick (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function passEvent (event:Event) : void;
		/**
		 * @private (protected)
		 */
		private function addCloseListener (event:Event);
		/**
		 * @private (protected)
		 */
		protected function onTextInput (event:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function calculateAvailableHeight () : Number;
		/**
		 * @private (protected)
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function highlightCell (index:int = -1) : void;
		/**
		 * @private (protected)
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function initializeAccessibility () : void;
	}
}