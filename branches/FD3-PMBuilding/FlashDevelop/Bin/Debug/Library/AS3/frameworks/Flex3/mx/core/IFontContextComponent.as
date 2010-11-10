﻿package mx.core
{
	/**
	 *  Allows a component to support a font context property.
	 */
	public interface IFontContextComponent
	{
		/**
		 *  The module factory that provides the font context for this component.
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;

	}
}