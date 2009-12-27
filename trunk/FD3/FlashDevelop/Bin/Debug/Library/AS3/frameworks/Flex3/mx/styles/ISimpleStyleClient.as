﻿package mx.styles
{
	/**
	 *  This interface describes the properties and methods that an object 
 *  must implement so that it can participate in the style subsystem. 
 *  This interface is intended to be used by classes that obtain their
 *  style values from other objects rather than through locally set values
 *  and type selectors.
 *  This interface is implemented by ProgrammaticSkin.
 *
 *  @see mx.styles.IStyleClient
 *  @see mx.styles.CSSStyleDeclaration
	 */
	public interface ISimpleStyleClient
	{
		/**
		 *  The source of this object's style values.
     *  The value of the <code>styleName</code> property can be one of three possible types:
     *
     *  <ul>
     *    <li>String, such as "headerStyle". The String names a class selector that is defined in a CSS style sheet.</li>
     *
     *    <li>CSSStyleDeclaration, such as <code>StyleManager.getStyleDeclaration(".headerStyle")</code>.</li>
     *
     *    <li>UIComponent. The object that implements this interface inherits all the style values from the referenced UIComponent.</li>
     *  </ul>
		 */
		public function get styleName () : Object;
		/**
		 *  @private
		 */
		public function set styleName (value:Object) : void;

		/**
		 *  Called when the value of a style property is changed. 
     *
     *  @param styleProp The name of the style property that changed.
		 */
		public function styleChanged (styleProp:String) : void;
	}
}
