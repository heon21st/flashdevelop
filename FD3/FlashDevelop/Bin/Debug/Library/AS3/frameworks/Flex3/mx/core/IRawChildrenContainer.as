﻿package mx.core
{
	/**
	 *  The IRawChildrenContainer interface defines the APIs for containers that 
 *  can return an IChildList that represents all their children. 
 *  This interface should be implemented by any container that has overridden
 *  IChildList APIs such as <code>numChildren</code> and <code>addChild()</code>
 *  method to manage only a subset of its actual children.
 *  The mx.core.Container class, for example, has a set of content children
 *  separate from the non-content children, such as borders, title bars,
 *  and dividers.
 *
 *  @see mx.core.Container
	 */
	public interface IRawChildrenContainer
	{
		/**
		 *  Returns an IChildList representing all children.
	 *  This is used by FocusManager to find non-content children that may
	 *  still receive focus (for example, components in ControlBars).
		 */
		public function get rawChildren () : IChildList;
	}
}
