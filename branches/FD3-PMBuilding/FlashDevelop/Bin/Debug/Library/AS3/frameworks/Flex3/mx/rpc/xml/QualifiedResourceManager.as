﻿package mx.rpc.xml
{
	/**
	 * QualifiedResourceManager is a helper class that simply maintains
	 */
	public class QualifiedResourceManager
	{
		/**
		 * This Array is used to preserve order in which resources were
		 */
		protected var resources : Array;
		/**
		 * Maps <code>Namespace.uri</code> to an <code>Array</code> of
		 */
		protected var resourcesMap : Object;

		/**
		 * Constructor.
		 */
		public function QualifiedResourceManager ();
		/**
		 * Adds a resource to a potential Array of resources for a
		 */
		public function addResource (ns:Namespace, resource:Object) : void;
		/**
		 * Returns an Array of resources for a given target namespace.
		 */
		public function getResourcesForNamespace (ns:Namespace) : Array;
		/**
		 * Returns an Array of resources for a given target URI.
		 */
		public function getResourcesForURI (uri:String) : Array;
		/**
		 * Gets an Array of all resources.
		 */
		public function getResources () : Array;
	}
}