package gadget.control
{
	import mx.controls.AdvancedDataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridItemRenderer;
	import mx.controls.listClasses.BaseListData;
	
	public class MyAdvancedDataGridItemRenderer extends AdvancedDataGridItemRenderer
	{
		private var col:AdvancedDataGridColumn;
		public function MyAdvancedDataGridItemRenderer()
		{
			super();
		}
		
		public override function set data(value:Object):void{
			if(value!=null){
				if(value.type == ImpactCalendar.ACTUAL_TYPE || value.type==ImpactCalendar.FORECAST_TYPE||value.type==ImpactCalendar.VARIANCE_TYPE){
					//annulized
					if(col.dataField=='CustomCurrency0'){
						setStyle("fontWeight","bold");
					}else{
						setStyle("fontWeight","normal");
					}
				}else{
					setStyle("fontWeight","normal");
				}
			}
			super.data = value;
			
		}
		
		public override function set listData(value:BaseListData):void{
			super.listData = value;
			var grid:AdvancedDataGrid = value.owner as AdvancedDataGrid;
			col = grid.columns[value.columnIndex];			
		}
		
//		public override function getStyle(styleProp:String):*{
//			if(super.data!=null && col!=null){
//				if(super.data.type == ImpactCalendar.ACTUAL_TYPE || super.data.type==ImpactCalendar.FORECAST_TYPE||super.data.type==ImpactCalendar.VARIANCE_TYPE){
//					//annulized
//					if(col.dataField=='CustomCurrency0' && styleProp=="fontWeight"){
//						return "bold";
//					}
//				}
//			}
//			
//			
//			return super.getStyle(styleProp);
//		}
		
		
	}
}