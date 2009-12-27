﻿package mx.events
{
	import flash.events.Event;
	import mx.events.PropertyChangeEventKind;

include "../core/Version.as"
	/**
	 * The PropertyChangeEvent class represents the event object 
 * passed to the event listener when one of the properties of 
 * an object has changed, and provides information about the change. 
 * This event is used by collection classes, and is the only way for 
 * collections to know that the data they represent has changed.
 * This event is also used by the Flex data binding mechanism.
 * 
 * @see PropertyChangeEventKind
	 */
	public class PropertyChangeEvent extends Event
	{
		/**
		 *  The <code>PropertyChangeEvent.PROPERTY_CHANGE</code> constant defines the value of the 
     *  <code>type</code> property of the event object for a <code>PropertyChange</code> event.
     * 
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>Determined by the constructor; defaults to false.</td></tr>
     *     <tr><td><code>cancelable</code></td><td>Determined by the constructor; defaults to false.</td></tr>
     *     <tr><td><code>kind</code></td><td>The kind of change; PropertyChangeEventKind.UPDATE
     *             or PropertyChangeEventKind.DELETE.</td></tr>
     *     <tr><td><code>oldValue</code></td><td>The original property value.</td></tr>
     *     <tr><td><code>newValue</code></td><td>The new property value, if any.</td></tr>
     *     <tr><td><code>property</code></td><td>The property that changed.</td></tr>
     *     <tr><td><code>source</code></td><td>The object that contains the property that changed.</td></tr>
     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the 
     *       event listener that handles the event. For example, if you use 
     *       <code>myButton.addEventListener()</code> to register an event listener, 
     *       myButton is the value of the <code>currentTarget</code>. </td></tr>
     *     <tr><td><code>target</code></td><td>The Object that dispatched the event; 
     *       it is not always the Object listening for the event. 
     *       Use the <code>currentTarget</code> property to always access the 
     *       Object listening for the event.</td></tr>
     *  </table>
     *
     *  @eventType propertyChange
     *
		 */
		public static const PROPERTY_CHANGE : String = "propertyChange";
		/**
		 *  Specifies the kind of change.
     *  The possible values are <code>PropertyChangeEventKind.UPDATE</code>,
     *  <code>PropertyChangeEventKind.DELETE</code>, and <code>null</code>.
		 */
		public var kind : String;
		/**
		 *  The value of the property after the change.
		 */
		public var newValue : Object;
		/**
		 *  The value of the property before the change.
		 */
		public var oldValue : Object;
		/**
		 *  A String, QName, or int specifying the property that changed.
		 */
		public var property : Object;
		/**
		 *  The object that the change occured on.
		 */
		public var source : Object;

		/**
		 *  Returns a new PropertyChangeEvent of kind
     *  <code>PropertyChangeEventKind.UPDATE</code>
     *  with the specified properties.
     *  This is a convenience method.
     * 
     *  @param source The object where the change occured.
     *
     *  @param property A String, QName, or int
     *  specifying the property that changed,
     *
     *  @param oldValue The value of the property before the change.
     *
     *  @param newValue The value of the property after the change.
     *
     *  @return A newly constructed PropertyChangeEvent
     *  with the specified properties.
		 */
		public static function createUpdateEvent (source:Object, property:Object, oldValue:Object, newValue:Object) : PropertyChangeEvent;

		/**
		 *  Constructor.
     *
     *  @param type The event type; indicates the action that triggered the event.
     *
     *  @param bubbles Specifies whether the event can bubble
     *  up the display list hierarchy.
     *
     *  @param cancelable Specifies whether the behavior
     *  associated with the event can be prevented.
     *
     *  @param kind Specifies the kind of change.
     *  The possible values are <code>PropertyChangeEventKind.UPDATE</code>,
     *  <code>PropertyChangeEventKind.DELETE</code>, and <code>null</code>.
     *
     *  @param property A String, QName, or int
     *  specifying the property that changed.
     *
     *  @param oldValue The value of the property before the change.
     *
     *  @param newValue The value of the property after the change.
     *
     *  @param source The object that the change occured on.
		 */
		public function PropertyChangeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, kind:String = null, property:Object = null, oldValue:Object = null, newValue:Object = null, source:Object = null);

		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}
