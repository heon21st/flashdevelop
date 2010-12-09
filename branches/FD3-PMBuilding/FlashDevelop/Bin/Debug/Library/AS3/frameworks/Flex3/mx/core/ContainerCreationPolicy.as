﻿package mx.core
{
	/**
	 *  The ContainerCreationPolicy class defines the constant values
	 */
	public class ContainerCreationPolicy
	{
		/**
		 *  Delay creating some or all descendants until they are needed.
		 */
		public static const AUTO : String = "auto";
		/**
		 *  Immediately create all descendants.
		 */
		public static const ALL : String = "all";
		/**
		 *  Add the container to a creation queue.
		 */
		public static const QUEUED : String = "queued";
		/**
		 *  Do not create any children.
		 */
		public static const NONE : String = "none";

	}
}