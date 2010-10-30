﻿package mx.core
{
	/**
	 *  The IFlexModule interface is used as an optional contract with IFlexModuleFactory.
	 */
	public interface IFlexModule
	{
		/**
		 *  @private
		 */
		public function set moduleFactory (factory:IFlexModuleFactory) : void;
		/**
		 * @private
		 */
		public function get moduleFactory () : IFlexModuleFactory;

	}
}