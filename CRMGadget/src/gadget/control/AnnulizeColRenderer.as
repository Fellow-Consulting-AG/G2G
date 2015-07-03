package gadget.control
{
	import com.adobe.utils.StringUtil;
	
	import flash.events.Event;
	
	
	public class AnnulizeColRenderer extends ImpactText
	{
		private var _calculateMonth:Function;

		
		
		public function AnnulizeColRenderer()
		{
			super();
		}
		
		protected override function onChange(e:Event):void{
			
			
			if(column != null){
				
				super.data[column.dataField]=StringUtil.trim(super.text);
				if(calculateMonth!=null){
					calculateMonth(super.data);	
				}				
				if(grid is MyAdvancedDataGrid){
					MyAdvancedDataGrid(grid).refreshRow(super.listData.rowIndex);
				}
				
			}
			
		}
		
		public function get calculateMonth():Function
		{
			return _calculateMonth;
		}
		
		public function set calculateMonth(value:Function):void
		{
			_calculateMonth = value;
		}

	}
}