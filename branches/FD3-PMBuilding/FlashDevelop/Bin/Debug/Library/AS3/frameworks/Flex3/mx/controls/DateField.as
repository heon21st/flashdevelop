﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListData;
	import mx.core.ClassFactory;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.mx_internal;
	import mx.core.UIComponentGlobals;
	import mx.events.CalendarLayoutChangeEvent;
	import mx.events.DateChooserEvent;
	import mx.events.DropdownEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.InterManagerRequest;
	import mx.events.SandboxMouseEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when a date is selected or changed,
	 */
	[Event(name="change", type="mx.events.CalendarLayoutChangeEvent")] 
	/**
	 *  Dispatched when a date is selected or the user clicks
	 */
	[Event(name="close", type="mx.events.DropdownEvent")] 
	/**
	 *  Dispatched when the <code>data</code> property changes.
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when a user selects the field to open the drop-down list.
	 */
	[Event(name="open", type="mx.events.DropdownEvent")] 
	/**
	 *  Dispatched when the month changes due to user interaction.
	 */
	[Event(name="scroll", type="mx.events.DateChooserEvent")] 
	/**
	 *  Color of the border.
	 */
	[Style(name="borderColor", type="uint", format="Color", inherit="no")] 
	/**
	 *  The bounding box thickness of the DateChooser control.
	 */
	[Style(name="borderThickness", type="Number", format="Length", inherit="no")] 
	/**
	 *  Radius of component corners.
	 */
	[Style(name="cornerRadius", type="Number", format="Length", inherit="no", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Name of the CSS Style declaration to use for the styles for the
	 */
	[Style(name="dateChooserStyleName", type="String", inherit="no")] 
	/**
	 *  Alphas used for the background fill of controls. Use [1, 1] to make the control background
	 */
	[Style(name="fillAlphas", type="Array", arrayType="Number", inherit="no", deprecatedReplacement="nextMonthStyleFilters, prevMonthStyleFilters, dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Colors used to tint the background of the control.
	 */
	[Style(name="fillColors", type="Array", arrayType="uint", format="Color", inherit="no", deprecatedReplacement="nextMonthStyleFilters, prevMonthStyleFilters, dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Colors of the band at the top of the DateChooser control.
	 */
	[Style(name="headerColors", type="Array", arrayType="uint", format="Color", inherit="yes", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Name of the style sheet definition to configure the text (month name and year)
	 */
	[Style(name="headerStyleName", type="String", inherit="no", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Alpha transparencies used for the highlight fill of controls.
	 */
	[Style(name="highlightAlphas", type="Array", arrayType="Number", inherit="no", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Color of the highlight area of the date when the user holds the
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Color of the highlight area of the currently selected date
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Name of the class to use as the default skin for the background and border. 
	 */
	[Style(name="skin", type="Class", inherit="no", states=" up, over, down, disabled")] 
	/**
	 *  Color of the highlight of today's date in the DateChooser control.
	 */
	[Style(name="todayColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Name of the style sheet definition to configure the appearance of the current day's
	 */
	[Style(name="todayStyleName", type="String", inherit="no", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Name of the style sheet definition to configure the weekday names of
	 */
	[Style(name="weekDayStyleName", type="String", inherit="no", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 

	/**
	 *  The DateField control is a text field that shows the date
	 */
	public class DateField extends ComboBase implements IDataRenderer
	{
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		private var creatingDropdown : Boolean;
		/**
		 *  @private
		 */
		local var showingDropdown : Boolean;
		/**
		 *  @private
		 */
		private var inKeyDown : Boolean;
		/**
		 *  @private
		 */
		private var isPressed : Boolean;
		/**
		 *  @private
		 */
		private var openPos : Number;
		/**
		 *  @private
		 */
		private var lastSelectedDate : Date;
		/**
		 *  @private
		 */
		private var updateDateFiller : Boolean;
		/**
		 *  @private
		 */
		private var addedToPopupManager : Boolean;
		/**
		 *  @private
		 */
		private var isMouseOver : Boolean;
		/**
		 *  @private
		 */
		private var yearChangedWithKeys : Boolean;
		/**
		 *  @private
		 */
		private var selectedDateSet : Boolean;
		/**
		 *  @private
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  @private
		 */
		private var _data : Object;
		/**
		 *  @private
		 */
		private var _dayNames : Array;
		/**
		 *  @private
		 */
		private var dayNamesChanged : Boolean;
		/**
		 *  @private
		 */
		private var dayNamesOverride : Array;
		/**
		 *  @private
		 */
		private var _disabledDays : Array;
		/**
		 *  @private
		 */
		private var disabledDaysChanged : Boolean;
		/**
		 *  @private
		 */
		private var _disabledRanges : Array;
		/**
		 *  @private
		 */
		private var disabledRangesChanged : Boolean;
		/**
		 *  @private
		 */
		private var _displayedMonth : int;
		/**
		 *  @private
		 */
		private var displayedMonthChanged : Boolean;
		/**
		 *  @private
		 */
		private var _displayedYear : int;
		/**
		 *  @private
		 */
		private var displayedYearChanged : Boolean;
		/**
		 *  @private
		 */
		private var _dropdown : DateChooser;
		/**
		 *  @private
		 */
		private var _dropdownFactory : IFactory;
		/**
		 *  @private
		 */
		private var _firstDayOfWeek : Object;
		/**
		 *  @private
		 */
		private var firstDayOfWeekChanged : Boolean;
		/**
		 *  @private
		 */
		private var firstDayOfWeekOverride : Object;
		/**
		 *  @private
		 */
		private var _formatString : String;
		/**
		 *  @private
		 */
		private var formatStringOverride : String;
		/**
		 *  @private
		 */
		private var _labelFunction : Function;
		/**
		 *  @private
		 */
		private var _listData : BaseListData;
		/**
		 *  @private
		 */
		private var _maxYear : int;
		/**
		 *  @private
		 */
		private var maxYearChanged : Boolean;
		/**
		 *  @private
		 */
		private var _minYear : int;
		/**
		 *  @private
		 */
		private var minYearChanged : Boolean;
		/**
		 *  @private
		 */
		private var _monthNames : Array;
		/**
		 *  @private
		 */
		private var monthNamesChanged : Boolean;
		/**
		 *  @private
		 */
		private var monthNamesOverride : Array;
		/**
		 *  @private
		 */
		private var _monthSymbol : String;
		/**
		 *  @private
		 */
		private var monthSymbolChanged : Boolean;
		/**
		 *  @private
		 */
		private var monthSymbolOverride : String;
		/**
		 *  @private
		 */
		private var _parseFunction : Function;
		/**
		 *  @private
		 */
		private var _selectableRange : Object;
		/**
		 *  @private
		 */
		private var selectableRangeChanged : Boolean;
		/**
		 *  @private
		 */
		private var _selectedDate : Date;
		/**
		 *  @private
		 */
		private var selectedDateChanged : Boolean;
		/**
		 *  @private
		 */
		private var _showToday : Boolean;
		/**
		 *  @private
		 */
		private var showTodayChanged : Boolean;
		/**
		 *  @private
		 */
		private var _yearNavigationEnabled : Boolean;
		/**
		 *  @private
		 */
		private var yearNavigationEnabledChanged : Boolean;
		/**
		 *  @private
		 */
		private var _yearSymbol : String;
		/**
		 *  @private
		 */
		private var yearSymbolChanged : Boolean;
		/**
		 *  @private
		 */
		private var yearSymbolOverride : String;

		/**
		 *  @private
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  The <code>data</code> property lets you pass a value
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  Weekday names for DateChooser control.
		 */
		public function get dayNames () : Array;
		/**
		 *  @private
		 */
		public function set dayNames (value:Array) : void;
		/**
		 *  Days to disable in a week.
		 */
		public function get disabledDays () : Array;
		/**
		 *  @private
		 */
		public function set disabledDays (value:Array) : void;
		/**
		 *  Disables single and multiple days.
		 */
		public function get disabledRanges () : Array;
		/**
		 *  @private
		 */
		public function set disabledRanges (value:Array) : void;
		/**
		 *  Used with the <code>displayedYear</code> property,
		 */
		public function get displayedMonth () : int;
		/**
		 *  @private
		 */
		public function set displayedMonth (value:int) : void;
		/**
		 *  Used with the <code>displayedMonth</code> property,
		 */
		public function get displayedYear () : int;
		/**
		 *  @private
		 */
		public function set displayedYear (value:int) : void;
		/**
		 *  Contains a reference to the DateChooser control
		 */
		public function get dropdown () : DateChooser;
		/**
		 *  The IFactory that creates a DateChooser-derived instance to use
		 */
		public function get dropdownFactory () : IFactory;
		/**
		 *  @private
		 */
		public function set dropdownFactory (value:IFactory) : void;
		/**
		 *  Day of the week (0-6, where 0 is the first element
		 */
		public function get firstDayOfWeek () : Object;
		/**
		 *  @private
		 */
		public function set firstDayOfWeek (value:Object) : void;
		/**
		 *  The format of the displayed date in the text field.
		 */
		public function get formatString () : String;
		/**
		 *  @private
		 */
		public function set formatString (value:String) : void;
		/**
		 *  Function used to format the date displayed
		 */
		public function get labelFunction () : Function;
		/**
		 *  @private
		 */
		public function set labelFunction (value:Function) : void;
		/**
		 *  When a component is used as a drop-in item renderer or drop-in
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  The last year selectable in the control.
		 */
		public function get maxYear () : int;
		/**
		 *  @private
		 */
		public function set maxYear (value:int) : void;
		/**
		 *  The first year selectable in the control.
		 */
		public function get minYear () : int;
		/**
		 *  @private
		 */
		public function set minYear (value:int) : void;
		/**
		 *  Names of the months displayed at the top of the control.
		 */
		public function get monthNames () : Array;
		/**
		 *  @private
		 */
		public function set monthNames (value:Array) : void;
		/**
		 *  This property is appended to the end of the value specified 
		 */
		public function get monthSymbol () : String;
		/**
		 *  @private
		 */
		public function set monthSymbol (value:String) : void;
		/**
		 *  Function used to parse the date entered as text
		 */
		public function get parseFunction () : Function;
		/**
		 *  @private
		 */
		public function set parseFunction (value:Function) : void;
		/**
		 *  Range of dates between which dates are selectable.
		 */
		public function get selectableRange () : Object;
		/**
		 *  @private
		 */
		public function set selectableRange (value:Object) : void;
		/**
		 *  Date as selected in the DateChooser control.
		 */
		public function get selectedDate () : Date;
		/**
		 *  @private
		 */
		public function set selectedDate (value:Date) : void;
		/**
		 *  If <code>true</code>, specifies that today is highlighted
		 */
		public function get showToday () : Boolean;
		/**
		 *  @private
		 */
		public function set showToday (value:Boolean) : void;
		/**
		 *  Enables year navigation. When <code>true</code>
		 */
		public function get yearNavigationEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set yearNavigationEnabled (value:Boolean) : void;
		/**
		 *  This property is appended to the end of the year 
		 */
		public function get yearSymbol () : String;
		/**
		 *  @private
		 */
		public function set yearSymbol (value:String) : void;

		/**
		 *  Parses a String object that contains a date, and returns a Date
		 */
		public static function stringToDate (valueString:String, inputFormat:String) : Date;
		/**
		 *  Formats a Date into a String according to the <code>outputFormat</code> argument.
		 */
		public static function dateToString (value:Date, outputFormat:String) : String;
		/**
		 *  Constructor.
		 */
		public function DateField ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
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
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  @private
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Opens the DateChooser control.
		 */
		public function open () : void;
		/**
		 *  Closes the DateChooser control.
		 */
		public function close () : void;
		/**
		 *  @private
		 */
		private function displayDropdown (show:Boolean, triggerEvent:Event = null) : void;
		/**
		 *  @private
		 */
		private function createDropdown () : void;
		/**
		 *  @private
		 */
		private function dateFiller (value:Date) : void;
		/**
		 *  @private
		 */
		private function scrubTimeValue (value:Object) : Object;
		/**
		 *  @private
		 */
		private function scrubTimeValues (values:Array) : Array;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function downArrowButton_buttonDownHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		protected function textInput_changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function removedFromStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_changeHandler (event:CalendarLayoutChangeEvent) : void;
		/**
		 *  @private
		 */
		private function dropdown_scrollHandler (event:DateChooserEvent) : void;
		/**
		 *  @private
		 */
		private function dropdown_mouseDownOutsideHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function selectedDate_changeHandler (triggerEvent:Event) : void;
		/**
		 *  @private
		 */
		private function textInput_textInputHandler (event:TextEvent) : void;
		/**
		 *  @private
		 */
		function isShowingDropdown () : Boolean;
	}
}