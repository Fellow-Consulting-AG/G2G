package gadget.control
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.TextInput;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.listClasses.BaseListData;

	public class QTextRenderer extends TextInput
	{
		
		public var column:AdvancedDataGridColumn;		
		private var grid:AdvancedDataGrid = null;
		public function QTextRenderer()
		{
			addEventListener(Event.CHANGE,onChange);
			super();
		}

	
		public function set focusOutHandler(f:Function):void{
			
			addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void{f()});
		}
		
		public function get quater():Object{
			return super.data[column.dataField];
		}
		
		private function onChange(e:Event):void{
			if(column != null){
				var quater:Object = super.data[column.dataField];
				if(quater==null||quater==''){
					quater = new Object();
					super.data[column.dataField] = quater;
				}
				var q1:int = parseInt(super.text,0);
				if(q1>0){
					var val:Number = q1/3;
					for each(var f:String in ImpactCalendar.MONTH_FIELD_FOR_EACH_Q){
						
						quater[f]=val.toFixed(2);
					}					
				}
				if(grid is MyAdvancedDataGrid){
					MyAdvancedDataGrid(grid).refreshRow(super.listData.rowIndex);
				}
			}
		}
	
		override public function set listData(value:BaseListData):void
		{			
			super.listData = value;
			if(value!=null){
				grid = value.owner as AdvancedDataGrid;
				var list:AdvancedDataGridListData = value as AdvancedDataGridListData;
				if(list!=null){					
					column = grid.columns[list.columnIndex];
					
				}
				
			}
		}
		
		
	}
}