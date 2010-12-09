﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.xml.XMLNode;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.ItemResponder;
	import mx.collections.IViewCursor;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListRowInfo;
	import mx.controls.listClasses.ListBaseSelectionDataPending;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.controls.treeClasses.HierarchicalCollectionView;
	import mx.controls.treeClasses.HierarchicalViewCursor;
	import mx.controls.treeClasses.ITreeDataDescriptor;
	import mx.controls.treeClasses.ITreeDataDescriptor2;
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.controls.treeClasses.TreeListData;
	import mx.core.ClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.EventPriority;
	import mx.core.FlexSprite;
	import mx.core.FlexShape;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IIMESupport;
	import mx.core.IInvalidating;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.Tween;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.events.ListEventReason;
	import mx.events.ScrollEvent;
	import mx.events.TreeEvent;
	import mx.managers.DragManager;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.styles.StyleManager;
	import mx.events.DragEvent;

	/**
	 *  Dispatched when a branch is closed or collapsed.
	 */
	[Event(name="itemClose", type="mx.events.TreeEvent")] 
	/**
	 *  Dispatched when a branch is opened or expanded.
	 */
	[Event(name="itemOpen", type="mx.events.TreeEvent")] 
	/**
	 *  Dispatched when a branch open or close is initiated.
	 */
	[Event(name="itemOpening", type="mx.events.TreeEvent")] 
	/**
	 *  Colors for rows in an alternating pattern.
	 */
	[Style(name="alternatingItemColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 
	/**
	 *  Array of colors used in the Tree control, in descending order.
	 */
	[Style(name="depthColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 
	/**
	 *  Specifies the default icon for a leaf item.
	 */
	[Style(name="defaultLeafIcon", type="Class", format="EmbeddedFile", inherit="no")] 
	/**
	 *  Specifies the icon that is displayed next to a parent item that is open so that its
	 */
	[Style(name="disclosureOpenIcon", type="Class", format="EmbeddedFile", inherit="no")] 
	/**
	 *  Specifies the icon that is displayed next to a parent item that is closed so that its
	 */
	[Style(name="disclosureClosedIcon", type="Class", format="EmbeddedFile", inherit="no")] 
	/**
	 *  Specifies the folder open icon for a branch item of the tree.
	 */
	[Style(name="folderOpenIcon", type="Class", format="EmbeddedFile", inherit="no")] 
	/**
	 *  Specifies the folder closed icon for a branch item of the tree.
	 */
	[Style(name="folderClosedIcon", type="Class", format="EmbeddedFile", inherit="no")] 
	/**
	 *  Indentation for each tree level, in pixels.
	 */
	[Style(name="indentation", type="Number", inherit="no")] 
	/**
	 *  Length of an open or close transition, in milliseconds.
	 */
	[Style(name="openDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  Easing function to control component tweening.
	 */
	[Style(name="openEasingFunction", type="Function", inherit="no")] 
	/**
	 *  Color of the background when the user rolls over the link.
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Color of the background when the user selects the link.
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Specifies the disabled color of a list item.
	 */
	[Style(name="selectionDisabledColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Reference to an <code>easingFunction</code> function used for controlling programmatic tweening.
	 */
	[Style(name="selectionEasingFunction", type="Function", inherit="no")] 
	/**
	 *  Color of the text when the user rolls over a row.
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Color of the text when the user selects a row.
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The Tree control lets a user view hierarchical data arranged as an expandable tree.
	 */
	public class Tree extends List implements IIMESupport
	{
		/**
		 *  @private
		 */
		private var IS_NEW_ROW_STYLE : Object;
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		private var opening : Boolean;
		/**
		 *  @private
		 */
		private var tween : Object;
		/**
		 *  @private
		 */
		private var maskList : Array;
		/**
		 *  @private
		 */
		private var _userMaxHorizontalScrollPosition : Number;
		/**
		 *  @private
		 */
		private var eventPending : Object;
		/**
		 *  @private
		 */
		private var eventAfterTween : Object;
		/**
		 *  @private
		 */
		private var oldLength : int;
		/**
		 *  @private
		 */
		private var expandedItem : Object;
		/**
		 *  @private
		 */
		private var bSelectedItemRemoved : Boolean;
		/**
		 *  @private
		 */
		private var minScrollInterval : Number;
		/**
		 *  @private
		 */
		private var rowNameID : Number;
		/**
		 *  @private
		 */
		private var _editable : Boolean;
		/**
		 *  @private
		 */
		private var _itemEditor : IFactory;
		/**
		 *  @private
		 */
		private var dontEdit : Boolean;
		/**
		 *  @private
		 */
		private var lastUserInteraction : Event;
		/**
		 *  @private
		 */
		local var _dropData : Object;
		/**
		 *  An object that specifies the icons for the items.
		 */
		public var itemIcons : Object;
		/**
		 *  @private
		 */
		local var isOpening : Boolean;
		/**
		 *  @private
		 */
		private var rowIndex : int;
		/**
		 *  @private
		 */
		private var rowsTweened : int;
		/**
		 *  @private
		 */
		private var rowList : Array;
		/**
		 *  @private
		 */
		local var collectionLength : int;
		/**
		 *  A hook for accessibility
		 */
		local var wrappedCollection : ICollectionView;
		/**
		 *  @private
		 */
		local var collectionThrowsIPE : Boolean;
		/**
		 *  @private
		 */
		private var haveItemIndices : Boolean;
		/**
		 *  @private
		 */
		private var lastTreeSeekPending : TreeSeekPending;
		/**
		 *  @private
		 */
		private var bFinishArrowKeySelection : Boolean;
		private var proposedSelectedItem : Object;
		/**
		 *  @private
		 */
		private var dataProviderChanged : Boolean;
		/**
		 *  @private
		 */
		private var _dragMoveEnabled : Boolean;
		/**
		 *  @private
		 */
		local var _dataDescriptor : ITreeDataDescriptor;
		/**
		 *  @private
		 */
		local var _showRoot : Boolean;
		/**
		 *  @private
		 */
		local var showRootChanged : Boolean;
		/**
		 *  @private
		 */
		local var _hasRoot : Boolean;
		/**
		 *  @private
		 */
		local var _rootModel : ICollectionView;
		/**
		 *  @private
		 */
		private var _openItems : Object;
		/**
		 *  @private
		 */
		private var openItemsChanged : Boolean;

		/**
		 *  An object that contains the data to be displayed.
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  @private
		 */
		public function get dataProvider () : Object;
		/**
		 *  The maximum value for the <code>maxHorizontalScrollPosition</code> property for the Tree control.
		 */
		public function get maxHorizontalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set maxHorizontalScrollPosition (value:Number) : void;
		/**
		 *  Indicates that items can be moved instead of just copied
		 */
		public function get dragMoveEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set dragMoveEnabled (value:Boolean) : void;
		/**
		 *  The item that is currently displayed in the top row of the tree.
		 */
		public function get firstVisibleItem () : Object;
		/**
		 *  @private
		 */
		public function set firstVisibleItem (value:Object) : void;
		/**
		 *  Tree delegates to the data descriptor for information about the data.
		 */
		public function set dataDescriptor (value:ITreeDataDescriptor) : void;
		/**
		 *  Returns the current ITreeDataDescriptor.
		 */
		public function get dataDescriptor () : ITreeDataDescriptor;
		/**
		 *  Sets the visibility of the root item.
		 */
		public function get showRoot () : Boolean;
		/**
		 *  @private
		 */
		public function set showRoot (value:Boolean) : void;
		/**
		 *  Indicates that the current dataProvider has a root item; for example, 
		 */
		public function get hasRoot () : Boolean;
		/**
		 *  The items that have been opened or set opened.
		 */
		public function get openItems () : Object;
		/**
		 *  @private
		 */
		public function set openItems (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function Tree ();
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
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		public function showDropFeedback (event:DragEvent) : void;
		/**
		 *  @private
		 */
		public function calculateDropIndex (event:DragEvent = null) : int;
		/**
		 *  @private
		 */
		protected function addDragData (ds:Object) : void;
		/**
		 *  @private
		 */
		function addClipMask (layoutChanged:Boolean) : void;
		/**
		 *  @private
		 */
		function removeClipMask () : void;
		/**
		 *  Creates a new TreeListData instance and populates the fields based on
		 */
		protected function makeListData (data:Object, uid:String, rowNum:int) : BaseListData;
		/**
		 *  @private
		 */
		public function itemToIcon (item:Object) : Class;
		/**
		 *  @private
		 */
		protected function drawRowBackgrounds () : void;
		/**
		 *  Sets the associated icon for the item.  Calling this method overrides the
		 */
		public function setItemIcon (item:Object, iconID:Class, iconID2:Class) : void;
		/**
		 *   @private
		 */
		private function isBranch (item:Object) : Boolean;
		/**
		 * @private
		 */
		function getChildren (item:Object, view:Object) : ICollectionView;
		/**
		 *  Determines the number of parents from root to the specified item.
		 */
		function getItemDepth (item:Object, offset:int) : int;
		/**
		 *  @private
		 */
		private function getCurrentCursorDepth () : int;
		/**
		 *  @private
		 */
		private function getVisibleChildrenCount (item:Object) : int;
		/**
		 *  Returns <code>true</code> if the specified item branch is open (is showing its children).
		 */
		public function isItemOpen (item:Object) : Boolean;
		/**
		 *  @private
		 */
		private function makeMask () : DisplayObject;
		/**
		 *  Opens or closes a branch item.
		 */
		public function expandItem (item:Object, open:Boolean, animate:Boolean = false, dispatchEvent:Boolean = false, cause:Event = null) : void;
		/**
		 *  @private
		 */
		function onTweenUpdate (value:Object) : void;
		/**
		 *  @private
		 */
		function onTweenEnd (value:Object) : void;
		/**
		 *  @private
		 */
		private function buildUpCollectionEvents (open:Boolean) : Array;
		/**
		 *  @private
		 */
		private function getIndent () : Number;
		/**
		 *   Checks to see if item is visible in the list
		 */
		public function isItemVisible (item:Object) : Boolean;
		/**
		 *  @private
		 */
		public function getItemIndex (item:Object) : int;
		/**
		 *  @private
		 */
		private function getIndexItem (index:int) : Object;
		/**
		 *  Opens or closes all the tree items below the specified item.
		 */
		public function expandChildrenOf (item:Object, open:Boolean) : void;
		/**
		 *  Returns the known parent of a child item. This method returns a value
		 */
		public function getParentItem (item:Object) : *;
		/**
		 *  @private
		 */
		private function getParentStack (item:Object) : Array;
		/**
		 *  @private
		 */
		private function getOpenChildrenStack (item:Object, stack:Array) : Array;
		/**
		 *  @private
		 */
		private function getChildIndexInParent (parent:Object, child:Object) : int;
		/**
		 *  @private
		 */
		private function collapseSelectedItems () : Array;
		/**
		 *  @private
		 */
		private function updateDropData (event:DragEvent) : void;
		/**
		 *  Initializes a TreeListData object that is used by the tree item renderer.
		 */
		protected function initListData (item:Object, treeListData:TreeListData) : void;
		/**
		 *  @private
		 */
		protected function layoutEditor (x:int, y:int, w:int, h:int) : void;
		/**
		 *  @private
		 */
		protected function scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		private function finishArrowKeySelection () : void;
		/**
		 *  @private
		 */
		protected function mouseOverHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseOutHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseClickHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseDoubleClickHandler (event:MouseEvent) : void;
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
		protected function mouseWheelHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function dragEnterHandler (event:DragEvent) : void;
		/**
		 *  @private
		 */
		protected function dragOverHandler (event:DragEvent) : void;
		/**
		 *  @private
		 */
		private function seekPendingDuringDragFailureHandler (data:Object, info:TreeSeekPending) : void;
		/**
		 *  @private
		 */
		private function seekPendingDuringDragResultHandler (data:Object, info:TreeSeekPending) : void;
		/**
		 *  @private
		 */
		private function checkItemIndices (event:DragEvent) : void;
		/**
		 *  Handles <code>DragEvent.DRAG_DROP events</code>.  This method  hides
		 */
		protected function dragDropHandler (event:DragEvent) : void;
		/**
		 *  Handles <code>DragEvent.DRAG_COMPLETE</code> events.  This method
		 */
		protected function dragCompleteHandler (event:DragEvent) : void;
		/**
		 *  @private
		 */
		function addChildItem (parent:Object, child:Object, index:Number) : Boolean;
		/**
		 *  @private
		 */
		function removeChildItem (parent:Object, child:Object, index:Number) : Boolean;
		/**
		 *  @private
		 */
		function dispatchTreeEvent (type:String, item:Object, renderer:IListItemRenderer, trigger:Event = null, opening:Boolean = true, animate:Boolean = true, dispatch:Boolean = true) : void;
		/**
		 *  @private
		 */
		protected function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function adjustAfterRemove (items:Array, location:int, emitEvent:Boolean) : Boolean;
		/**
		 *
		 */
		function expandItemHandler (event:TreeEvent) : void;
		/**
		 *
		 */
		function selectionDataPendingResultHandler (data:Object, info:ListBaseSelectionDataPending) : void;
	}
	internal class TreeSeekPending
	{
		public var event : DragEvent;
		public var retryFunction : Function;

		public function TreeSeekPending (event:DragEvent, retryFunction:Function);
	}
}