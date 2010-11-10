/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series.items {
	import mx.charts.ChartItem;
	import mx.charts.series.BubbleSeries;
	public class BubbleSeriesItem extends ChartItem {
		/**
		 * Holds the fill color of the item
		 */
		public var fill:IFill;
		/**
		 * The x value of this item converted into screen coordinates.
		 */
		public var x:Number;
		/**
		 * The x value of this item, filtered against the horizontal axis of the containing chart. This value is NaN if the value lies outside the axis' range.
		 */
		public var xFilter:Number;
		/**
		 * The x value of this item, converted to a number by the horizontal axis of the containing chart.
		 */
		public var xNumber:Number;
		/**
		 * The x value of this item.
		 */
		public var xValue:Object;
		/**
		 * The y value of this item converted into screen coordinates.
		 */
		public var y:Number;
		/**
		 * The y value of this item, filtered against the vertical axis of the containing chart. This value is NaN if the value lies outside the axis's range.
		 */
		public var yFilter:Number;
		/**
		 * The y value of this item, converted to a number by the vertical axis of the containing chart.
		 */
		public var yNumber:Number;
		/**
		 * The y value of this item.
		 */
		public var yValue:Object;
		/**
		 * The z value of this item converted into a pixel-based radius.
		 */
		public var z:Number;
		/**
		 * The z value of this item, filtered against the radius axis of the containing chart. This value is NaN if the value lies outside the axis' range.
		 */
		public var zFilter:Number;
		/**
		 * The z value of this item, converted to a number by the radius axis of the containing chart.
		 */
		public var zNumber:Number;
		/**
		 * The z value of this item.
		 */
		public var zValue:Object;
		/**
		 * Constructor.
		 *
		 * @param element           <BubbleSeries (default = null)> The owning series.
		 * @param data              <Object (default = null)> The item from the dataProvider that this ChartItem represents.
		 * @param index             <uint (default = 0)> The index of the item from the series's dataProvider.
		 */
		public function BubbleSeriesItem(element:BubbleSeries = null, data:Object = null, index:uint = 0);
	}
}