﻿package mx.controls
{
	import flash.display.InteractiveObject;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.xml.XMLNode;
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.core.Application;
	import mx.core.EventPriority;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexNativeMenuEvent;
	import mx.managers.ILayoutManagerClient;
	import mx.managers.ISystemManager;

	/**
	 *  Dispatched before a menu or submenu is displayed.
	 */
	[Event(name="menuShow", type="mx.events.FlexNativeMenuEvent")] 
	/**
	 *  Dispatched when a menu item is selected.
	 */
	[Event(name="itemClick", type="mx.events.FlexNativeMenuEvent")] 

	/**
	 *  The FlexNativeMenu component provides a wrapper for AIR's NativeMenu class. The FlexNativeMenu
	 */
	public class FlexNativeMenu extends EventDispatcher implements ILayoutManagerClient
	{
		/**
		 *  The character to use to indicate the mnemonic index in a label.  By
		 */
		private static var MNEMONIC_INDEX_CHARACTER : String;
		/**
		 *  @private
		 */
		private var _initialized : Boolean;
		/**
		 *  @private
		 */
		private var _nestLevel : int;
		/**
		 *  @private
		 */
		private var _processedDescriptors : Boolean;
		/**
		 *  @private
		 */
		private var _updateCompletePendingFlag : Boolean;
		/**
		 *  @private
		 */
		private var invalidatePropertiesFlag : Boolean;
		/**
		 * @private
		 */
		private var _nativeMenu : NativeMenu;
		/**
		 *  @private
		 */
		private var dataDescriptorChanged : Boolean;
		/**
		 *  @private
		 */
		private var _dataDescriptor : IMenuDataDescriptor;
		/**
		 *  @private
		 */
		private var dataProviderChanged : Boolean;
		/**
		 *  @private
		 */
		local var _rootModel : ICollectionView;
		/**
		 *  @private
		 */
		private var _hasRoot : Boolean;
		/**
		 *  @private
		 */
		private var keyEquivalentFieldChanged : Boolean;
		/**
		 *  @private
		 */
		private var _keyEquivalentField : String;
		/**
		 *  @private
		 */
		private var _keyEquivalentFunction : Function;
		/**
		 *  @private
		 */
		private var keyEquivalentModifiersFunctionChanged : Boolean;
		/**
		 *  @private
		 */
		private var _keyEquivalentModifiersFunction : Function;
		/**
		 *  @private
		 */
		private var labelFieldChanged : Boolean;
		/**
		 *  @private
		 */
		private var _labelField : String;
		/**
		 *  @private
		 */
		private var _labelFunction : Function;
		/**
		 *  @private
		 */
		private var mnemonicIndexFieldChanged : Boolean;
		/**
		 *  @private
		 */
		private var _mnemonicIndexField : String;
		/**
		 *  @private
		 */
		private var _mnemonicIndexFunction : Function;
		/**
		 *  @private
		 */
		private var _showRoot : Boolean;
		/**
		 *  @private
		 */
		private var showRootChanged : Boolean;

		/**
		 *  @copy mx.core.UIComponent#initialized
		 */
		public function get initialized () : Boolean;
		/**
		 *  @private
		 */
		public function set initialized (value:Boolean) : void;
		/**
		 *  @copy mx.core.UIComponent#nestLevel
		 */
		public function get nestLevel () : int;
		/**
		 *  @private
		 */
		public function set nestLevel (value:int) : void;
		/**
		 *  @copy mx.core.UIComponent#processedDescriptors
		 */
		public function get processedDescriptors () : Boolean;
		/**
		 *  @private
		 */
		public function set processedDescriptors (value:Boolean) : void;
		/**
		 *  A flag that determines if an object has been through all three phases
		 */
		public function get updateCompletePendingFlag () : Boolean;
		/**
		 *  @private
		 */
		public function set updateCompletePendingFlag (value:Boolean) : void;
		/**
		 *  Returns the flash.display.NativeMenu managed by this object,
		 */
		public function get nativeMenu () : NativeMenu;
		/**
		 *  The object that accesses and manipulates data in the data provider.
		 */
		public function get dataDescriptor () : IMenuDataDescriptor;
		/**
		 *  @private
		 */
		public function set dataDescriptor (value:IMenuDataDescriptor) : void;
		/**
		 *  The hierarchy of objects that are used to define the structure
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  @copy mx.controls.Menu#hasRoot
		 */
		public function get hasRoot () : Boolean;
		/**
		 *  The name of the field in the data provider that determines the
		 */
		public function get keyEquivalentField () : String;
		/**
		 *  @private
		 */
		public function set keyEquivalentField (value:String) : void;
		/**
		 *  The function that determines the key equivalent for each menu item.
		 */
		public function get keyEquivalentFunction () : Function;
		/**
		 *  @private
		 */
		public function set keyEquivalentFunction (value:Function) : void;
		/**
		 *  The function that determines the key equivalent modifiers for each menu item.
		 */
		public function get keyEquivalentModifiersFunction () : Function;
		/**
		 *  @private
		 */
		public function set keyEquivalentModifiersFunction (value:Function) : void;
		/**
		 *  The name of the field in the data provider that determines the
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;
		/**
		 *  The function that determines the text to display for each menu item.
		 */
		public function get labelFunction () : Function;
		/**
		 *  @private
		 */
		public function set labelFunction (value:Function) : void;
		/**
		 *  The name of the field in the data provider that determines the
		 */
		public function get mnemonicIndexField () : String;
		/**
		 *  @private
		 */
		public function set mnemonicIndexField (value:String) : void;
		/**
		 *  The function that determines the mnemonic index for each menu item.
		 */
		public function get mnemonicIndexFunction () : Function;
		/**
		 *  @private
		 */
		public function set mnemonicIndexFunction (value:Function) : void;
		/**
		 *  A Boolean flag that specifies whether to display the data provider's
		 */
		public function get showRoot () : Boolean;
		/**
		 *  @private
		 */
		public function set showRoot (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function FlexNativeMenu ();
		private function keyEquivalentModifiersDefaultFunction (data:Object) : Array;
		/**
		 *  @copy mx.core.UIComponent#invalidateProperties()
		 */
		public function invalidateProperties () : void;
		/**
		 *  @private
		 */
		public function validatePropertiesTimerHandler (event:TimerEvent) : void;
		/**
		 *  @inheritDoc
		 */
		public function validateProperties () : void;
		/**
		 *  @inheritDoc
		 */
		public function validateSize (recursive:Boolean = false) : void;
		/**
		 *  @inheritDoc
		 */
		public function validateDisplayList () : void;
		/**
		 *  Validates and updates the properties and layout of this object
		 */
		public function validateNow () : void;
		/**
		 *  Sets the context menu of the InteractiveObject to the underlying native menu.
		 */
		public function setContextMenu (component:InteractiveObject) : void;
		/**
		 *  Unsets the context menu of the InteractiveObject that has been set to
		 */
		public function unsetContextMenu (component:InteractiveObject) : void;
		/**
		 *  Processes the properties set on the component.
		 */
		protected function commitProperties () : void;
		/**
		 *  Creates a menu and adds appropriate listeners
		 */
		private function createMenu () : NativeMenu;
		/**
		 *  Clears out all items in a given menu
		 */
		private function clearMenu (menu:NativeMenu) : void;
		/**
		 *  Populates a menu and the related submenus given a collection
		 */
		private function populateMenu (menu:NativeMenu, collection:ICollectionView) : NativeMenu;
		/**
		 *  Adds the NativeMenuItem to the NativeMenu.  This methods looks at the
		 */
		private function insertMenuItem (menu:NativeMenu, index:int, data:Object) : void;
		/**
		 *  @copy flash.display.NativeMenu#display()
		 */
		public function display (stage:Stage, x:int, y:int) : void;
		/**
		 *  Returns the key equivalent for the given data object
		 */
		protected function itemToKeyEquivalent (data:Object) : String;
		/**
		 *  Returns the key equivalent modifiers for the given data object
		 */
		protected function itemToKeyEquivalentModifiers (data:Object) : Array;
		/**
		 *  Returns the String to use as the menu item label for the given data
		 */
		protected function itemToLabel (data:Object) : String;
		/**
		 *  Returns the mnemonic index for the given data object
		 */
		protected function itemToMnemonicIndex (data:Object) : int;
		/**
		 *  Determines the actual label to be used for the NativeMenuItem
		 */
		protected function parseLabelToString (data:String) : String;
		/**
		 *  Extracts the mnemonic index from a label based on the presence of
		 */
		protected function parseLabelToMnemonicIndex (data:String) : int;
		/**
		 *  @private
		 */
		private function itemSelectHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function menuDisplayHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function collectionChangeHandler (ce:CollectionEvent) : void;
	}
}