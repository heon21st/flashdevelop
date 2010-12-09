﻿package mx.resources
{
	/**
	 *  The IResourceBundle and IResourceManager interfaces work together
	 */
	public interface IResourceBundle
	{
		/**
		 *  A name that identifies this resource bundle,
		 */
		public function get bundleName () : String;
		/**
		 *  An object containing key-value pairs for the resources
		 */
		public function get content () : Object;
		/**
		 *  The locale for which this bundle's resources have been localized.
		 */
		public function get locale () : String;

	}
}