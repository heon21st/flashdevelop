package flash.net.drm
{
	public class DRMPlaybackTimeWindow extends Object
	{
		public function get endDate () : Date;

		public function get period () : uint;

		public function get startDate () : Date;

		public function DRMPlaybackTimeWindow (length:uint, start:uint, end:uint);
	}
}