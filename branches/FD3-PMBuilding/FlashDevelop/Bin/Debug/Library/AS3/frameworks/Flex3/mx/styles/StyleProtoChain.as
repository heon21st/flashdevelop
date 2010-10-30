﻿package mx.styles
{
	import flash.display.DisplayObject;
	import mx.core.UIComponent;
	import mx.core.IUITextField;
	import mx.core.mx_internal;
	import mx.styles.IStyleClient;
	import mx.styles.StyleProxy;

	/**
	 *  @private
	 */
	public class StyleProtoChain
	{
		/**
		 *  @private
		 */
		public static function initProtoChainForUIComponentStyleName (obj:IStyleClient) : void;
		/**
		 *  See the comment for the initProtoChainForUIComponentStyleName
		 */
		private static function addProperties (chain:Object, obj:IStyleClient, bInheriting:Boolean) : Object;
		/**
		 *  @private
		 */
		public static function initTextField (obj:IUITextField) : void;
	}
}