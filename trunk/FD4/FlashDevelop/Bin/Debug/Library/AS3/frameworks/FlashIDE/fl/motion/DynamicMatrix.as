﻿package fl.motion
{
	/**
	 * The DynamicMatrix class calculates and stores a matrix based on given values. 
	 */
	public class DynamicMatrix
	{
		/**
		 * Specifies that a matrix is prepended for concatenation. 
		 */
		public static const MATRIX_ORDER_PREPEND : int = 0;
		/**
		 * Specifies that a matrix is appended for concatenation. 
		 */
		public static const MATRIX_ORDER_APPEND : int = 1;
		/**
		 * @private
		 */
		protected var m_width : int;
		/**
		 * @private
		 */
		protected var m_height : int;
		/**
		 * @private
		 */
		protected var m_matrix : Array;

		/**
		 * Constructs a matrix with the given number of rows and columns. 
		 */
		public function DynamicMatrix (width:int, height:int);
		/**
		 * @private
		 */
		protected function Create (width:int, height:int) : void;
		/**
		 * @private
		 */
		protected function Destroy () : void;
		/**
		 * Returns the number of columns in the current matrix. 
		 */
		public function GetWidth () : Number;
		/**
		 * Returns the number of rows in the current matrix. 
		 */
		public function GetHeight () : Number;
		/**
		 * Returns the value at the specified zero-based row and column in the current matrix. 
		 */
		public function GetValue (row:int, col:int) : Number;
		/**
		 * Sets the value at a specified zero-based row and column in the current matrix. 
		 */
		public function SetValue (row:int, col:int, value:Number) : void;
		/**
		 * Sets the current matrix to an identity matrix. 
		 */
		public function LoadIdentity () : void;
		/**
		 * Sets all values in the current matrix to zero. 
		 */
		public function LoadZeros () : void;
		/**
		 * Multiplies the current matrix with a specified matrix; and either
		 */
		public function Multiply (inMatrix:DynamicMatrix, order:int = MATRIX_ORDER_PREPEND) : Boolean;
		/**
		 * Multiplies a number with each item in the matrix and stores the results in
		 */
		public function MultiplyNumber (value:Number) : Boolean;
		/**
		 * Adds the current matrix with a specified matrix. The 
		 */
		public function Add (inMatrix:DynamicMatrix) : Boolean;
	}
}