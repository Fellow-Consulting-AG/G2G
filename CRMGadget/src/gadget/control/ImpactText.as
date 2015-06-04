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

	public class ImpactText extends TextInput
	{
		
		
		public var column:AdvancedDataGridColumn;
		private var grid:AdvancedDataGrid = null;		
		public function ImpactText()
		{
			addEventListener(Event.CHANGE,onChange);
			super();
		}

		
		public function set focusOutHandler(f:Function):void{
			
			addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void{f()});
		}
		
		private function onChange(e:Event):void{
			
					
					if(column != null){
						var colName:String = column.dataField;
						if(colName.indexOf('.')!=-1){
							var fields:Array = colName.split('.');
							var q:Object = data[fields[0]];
							if(q==null){
								q=new Object();
								super.data[fields[0]]=q;
							}
							q[fields[1]]=super.text;
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